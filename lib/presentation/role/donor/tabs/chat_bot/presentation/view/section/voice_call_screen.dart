import 'dart:async';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/presentation/view_model/ask_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum CallState { idle, listening, thinking, speaking }

bool _isArabicText(String text) =>
    text.runes.any((r) => r >= 0x0600 && r <= 0x06FF);

class VoiceCallScreen extends StatefulWidget {
  final String userId;
  const VoiceCallScreen({super.key, required this.userId});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen>
    with TickerProviderStateMixin {

  final SpeechToText _stt = SpeechToText();
  final FlutterTts   _tts = FlutterTts();

  CallState _callState = CallState.idle;
  bool _sttReady       = false;
  bool _callActive     = false;
  String _liveText     = '';
  String _lastQuestion = '';
  String _lastAnswer   = '';

  bool _isArabic = false;

  String _arabicLocale  = 'ar_SA';
  String _englishLocale = 'en_US';

  bool _animationsRunning = false;

  late AnimationController _pulseOuter;
  late AnimationController _pulseInner;
  late AnimationController _waveController;
  late Animation<double>   _outerScale;
  late Animation<double>   _innerScale;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initVoice();
  }

  @override
  void dispose() {
    _pulseOuter.dispose();
    _pulseInner.dispose();
    _waveController.dispose();
    _stt.stop();
    _tts.stop();
    super.dispose();
  }


  void _initAnimations() {
    _pulseOuter = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _pulseInner = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _waveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _outerScale = Tween<double>(begin: 1.0, end: 1.8).animate(
        CurvedAnimation(parent: _pulseOuter, curve: Curves.easeOut));
    _innerScale = Tween<double>(begin: 1.0, end: 1.3).animate(
        CurvedAnimation(parent: _pulseInner, curve: Curves.easeInOut));
  }

  Future<void> _initVoice() async {
    await Permission.microphone.request();

    _sttReady = await _stt.initialize(
      onError: (_) {
        _safeStopAnimations();
        if (_callActive && mounted) {
          Future.delayed(const Duration(milliseconds: 600), _startListening);
        }
      },
    );

    final locales   = await _stt.locales();
    final localeIds = locales.map((l) => l.localeId).toList();

    for (final c in ['ar_SA', 'ar_EG', 'ar_AE', 'ar_001', 'ar']) {
      if (localeIds.any((l) => l.toLowerCase().startsWith(c.split('_')[0]))) {
        _arabicLocale = c;
        break;
      }
    }
    if (localeIds.any((l) => l.startsWith('en_US'))) {
      _englishLocale = 'en_US';
    } else {
      final en = localeIds.where((l) => l.startsWith('en')).toList();
      if (en.isNotEmpty) _englishLocale = en.first;
    }

    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    _tts.setStartHandler(() {
      if (!mounted) return;
      setState(() => _callState = CallState.speaking);
      _startSpeakingAnimation();
    });

    _tts.setCompletionHandler(() {
      _safeStopAnimations();
      if (_callActive && mounted) {
        Future.delayed(const Duration(milliseconds: 400), _startListening);
      }
    });

    _tts.setErrorHandler((_) {
      _safeStopAnimations();
      if (_callActive && mounted) {
        Future.delayed(const Duration(milliseconds: 400), _startListening);
      }
    });
  }


  Future<void> _toggleLanguage() async {
    if (_callState == CallState.thinking) return;

    final wasListening = _callState == CallState.listening;
    final wasSpeaking  = _callState == CallState.speaking;

    await _stt.stop();
    await _tts.stop();
    _safeStopAnimations();

    setState(() {
      _isArabic  = !_isArabic;
      _liveText  = '';
      _callState = CallState.idle;
    });

    if (_callActive && (wasListening || wasSpeaking)) {
      await Future.delayed(const Duration(milliseconds: 200));
      _startListening();
    }
  }

  Future<void> _startCall() async {
    setState(() => _callActive = true);
    _startListening();
  }

  Future<void> _endCall() async {
    setState(() {
      _callActive  = false;
      _callState   = CallState.idle;
      _liveText    = '';
    });
    _safeStopAnimations();
    await _stt.stop();
    await _tts.stop();
    if (mounted) {
      context.read<AskCubit>().stopStream();
      Navigator.pop(context);
    }
  }


  Future<void> _startListening() async {
    if (!_sttReady || !_callActive || !mounted) return;

    await _stt.stop();
    await Future.delayed(const Duration(milliseconds: 150));
    if (!_callActive || !mounted) return;

    setState(() {
      _callState = CallState.listening;
      _liveText  = '';
    });
    _startListeningAnimation();

    final localeId = _isArabic ? _arabicLocale : _englishLocale;

    await _stt.listen(
      localeId:  localeId,
      listenFor: const Duration(seconds: 40),
      pauseFor:  const Duration(seconds: 3),
      onResult: (result) {
        if (!mounted || !_callActive) return;

        final words = result.recognizedWords.trim();
        if (words.isNotEmpty) setState(() => _liveText = words);

        if (!result.finalResult) return;

        if (words.isEmpty) {
          _startListening();
          return;
        }

        _safeStopAnimations();
        setState(() {
          _lastQuestion = words;
          _callState    = CallState.thinking;
          _liveText     = '';
        });
        _startThinkingAnimation();
        context.read<AskCubit>().askQuestionStream(words, widget.userId);
      },
    );
  }


  Future<void> _speakAnswer(String text) async {
    if (text.isEmpty || !_callActive || !mounted) return;
    setState(() => _lastAnswer = text);

    if (_isArabic) {
      await _tts.setLanguage('ar-SA');
      await _tts.setSpeechRate(0.42);
    } else {
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(0.50);
    }

    await _tts.speak(text);
  }


  void _startListeningAnimation() {
    _safeStopAnimations();
    _pulseOuter.repeat(reverse: true);
    _pulseInner.repeat(reverse: true);
    _animationsRunning = true;
  }

  void _startThinkingAnimation() {
    _safeStopAnimations();
    _waveController.repeat();
    _animationsRunning = true;
  }

  void _startSpeakingAnimation() {
    _safeStopAnimations();
    _pulseInner.repeat(reverse: true);
    _animationsRunning = true;
  }

  void _safeStopAnimations() {
    if (!_animationsRunning) return;
    _animationsRunning = false;
    for (final c in [_pulseOuter, _pulseInner, _waveController]) {
      if (c.isAnimating) {
        c.stop();
        c.reset();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<AskCubit, AskState>(
      listener: (context, state) {
        if (state is AskSuccessState) {
          _safeStopAnimations();
          _speakAnswer(state.answer.answer ?? '');
        } else if (state is AskStreamingState) {
          if (mounted) setState(() => _lastAnswer = state.currentText);
        } else if (state is AskErrorState) {
          _safeStopAnimations();
          _speakAnswer(
            _isArabic
                ? 'عذراً، حدث خطأ. حاول مرة أخرى.'
                : 'Sorry, something went wrong. Please try again.',
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F1E),
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(child: _buildCallUI()),
              _buildBottomControls(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTopBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Row(
      children: [
        GestureDetector(
          onTap: _endCall,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 18),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LifeLink Assistant',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                _isArabic ? 'مساعد صوتي' : 'Voice AI',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),

        // ── Language toggle button ──────────────────────────────────
        GestureDetector(
          onTap: _callState == CallState.thinking ? null : _toggleLanguage,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // EN pill
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: !_isArabic
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'EN',
                    style: TextStyle(
                      color: !_isArabic
                          ? const Color(0xFF0F0F1E)
                          : Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // AR pill
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _isArabic
                        ? ColorManger.brightRed
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'AR',
                    style: TextStyle(
                      color: _isArabic ? Colors.white : Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );


  Widget _buildCallUI() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AnimatedBuilder(
        animation: Listenable.merge([_pulseOuter, _pulseInner]),
        builder: (_, __) => SizedBox(
          width: 200, height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_callState == CallState.listening)
                Transform.scale(
                  scale: _outerScale.value,
                  child: Container(
                    width: 130, height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManger.brightRed.withValues(alpha: 0.12),
                    ),
                  ),
                ),
              if (_callState == CallState.listening ||
                  _callState == CallState.speaking)
                Transform.scale(
                  scale: _innerScale.value,
                  child: Container(
                    width: 110, height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _callState == CallState.speaking
                          ? Colors.green.withValues(alpha: 0.2)
                          : ColorManger.brightRed.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 90, height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _avatarColor(),
                ),
                child: Icon(_avatarIcon(), color: Colors.white, size: 40),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 32),

      AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Text(
          _statusLabel(),
          key: ValueKey('${_callState}_$_isArabic'),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),

      const SizedBox(height: 16),

      AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _buildTextPreview(),
      ),

      if (_callState == CallState.thinking)
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: AnimatedBuilder(
            animation: _waveController,
            builder: (_, __) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final offset =
                ((_waveController.value * 3) - i).clamp(0.0, 1.0);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10, height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManger.brightRed
                        .withValues(alpha: 0.4 + offset * 0.6),
                  ),
                );
              }),
            ),
          ),
        ),
    ],
  );

  Widget _buildTextPreview() {
    String text  = '';
    Color  color = Colors.white54;

    if (_callState == CallState.listening && _liveText.isNotEmpty) {
      text  = '"$_liveText"';
      color = Colors.white70;
    } else if (_callState == CallState.speaking && _lastAnswer.isNotEmpty) {
      text  = _lastAnswer.length > 80
          ? '${_lastAnswer.substring(0, 80)}...'
          : _lastAnswer;
      color = Colors.white54;
    } else if (_callState == CallState.thinking && _lastQuestion.isNotEmpty) {
      text  = '"$_lastQuestion"';
      color = Colors.white38;
    }

    if (text.isEmpty) return const SizedBox(key: ValueKey('empty'));

    return Padding(
      key: ValueKey(text.substring(0, text.length.clamp(0, 20))),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        text,
        textAlign: TextAlign.center,
        textDirection:
        _isArabic ? TextDirection.rtl : TextDirection.ltr,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontStyle: FontStyle.italic,
          height: 1.5,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }


  Widget _buildBottomControls() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        _controlButton(
          icon: Icons.call_end_rounded,
          color: Colors.white,
          bgColor: Colors.red[700]!,
          onTap: _endCall,
          label: _isArabic ? 'إنهاء' : 'End',
          size: 64,
        ),
        _controlButton(
          icon: _callActive ? Icons.volume_up_rounded : Icons.call_rounded,
          color: Colors.white,
          bgColor: _callActive
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.green[700]!,
          onTap: _callActive ? null : _startCall,
          label: _isArabic ? 'بدء' : 'Start',
        ),
      ],
    ),
  );

  Widget _controlButton({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback? onTap,
    required String label,
    double size = 52,
  }) =>
      Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size, height: size,
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: bgColor),
              child: Icon(icon, color: color, size: size * 0.44),
            ),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      );

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  Color _avatarColor() => switch (_callState) {
    CallState.idle      => const Color(0xFF2A2A4A),
    CallState.listening => ColorManger.brightRed,
    CallState.thinking  => const Color(0xFF854F0B),
    CallState.speaking  => const Color(0xFF27500A),
  };

  IconData _avatarIcon() => switch (_callState) {
    CallState.idle      => Icons.smart_toy_outlined,
    CallState.listening => Icons.mic_rounded,
    CallState.thinking  => Icons.hourglass_top_rounded,
    CallState.speaking  => Icons.volume_up_rounded,
  };

  String _statusLabel() {
    if (!_callActive) {
      return _isArabic ? 'اضغط بدء للتحدث' : 'Tap Start to begin';
    }
    return switch (_callState) {
      CallState.idle      => _isArabic ? 'جاهز'            : 'Ready',
      CallState.listening => _isArabic ? 'استمع إليك...'   : 'Listening...',
      CallState.thinking  => _isArabic ? 'جاري التفكير...' : 'Thinking...',
      CallState.speaking  => _isArabic ? 'يتحدث...'        : 'Speaking...',
    };
  }
}
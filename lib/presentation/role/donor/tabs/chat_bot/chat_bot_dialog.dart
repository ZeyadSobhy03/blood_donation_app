import 'dart:async';
import 'dart:developer';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/presentation/view_model/ask_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/voice_call_screen.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/widgets/bot_message.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/widgets/user_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';

class ChatBotDialog extends StatefulWidget {
  final String userId;
  const ChatBotDialog({super.key, required this.userId});

  @override
  State<ChatBotDialog> createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog>
    with SingleTickerProviderStateMixin {

  // ── Controllers ─────────────────────────
  late TextEditingController _messageController;
  late ScrollController _scrollController;



  // ── Messages ─────────────────────────────
  late List<Map<String, String>> messages;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController  = ScrollController();



    messages = [
      {
        'type': 'bot',
        'message': 'Hello! 👋 I\'m LifeLink Assistant. How can I help you today?',
        'time': _formatTime(DateTime.now()),
      },
    ];

  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();

    super.dispose();
  }







  // ─────────────────────────────────────────
  // SEND MESSAGES
  // ─────────────────────────────────────────

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _addUserMessage(text);
    _messageController.clear();
    context.read<AskCubit>().askQuestion(text, widget.userId);
  }


  void _addUserMessage(String text) {
    setState(() {
      messages.add({
        'type': 'user',
        'message': text,
        'time': _formatTime(DateTime.now()),
      });
    });
    _scrollToBottom();
  }

  // ─────────────────────────────────────────
  // OPEN VOICE CALL
  // ─────────────────────────────────────────

  void _openVoiceCall() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => BlocProvider.value(
          value: context.read<AskCubit>(),
          child: VoiceCallScreen(userId: widget.userId),
        ),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }


  String _formatTime(DateTime dt) {
    final hour   = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<AskCubit, AskState>(
      listener: (context, state) {
        if (state is AskSuccessState) {
          final answer = state.answer.answer ?? '';
          setState(() {
            messages.removeWhere((m) => m['type'] == 'streaming');
            messages.add({
              'type': 'bot',
              'message': answer,
              'time': _formatTime(DateTime.now()),
            });
          });
          _scrollToBottom();

        } else if (state is AskStreamingState) {
          setState(() {
            final idx = messages
                .indexWhere((m) => m['type'] == 'streaming');
            if (idx != -1) {
              messages[idx]['message'] = state.currentText;
            } else {
              messages.add({
                'type': 'streaming',
                'message': state.currentText,
                'time': _formatTime(DateTime.now()),
              });
            }
          });
          _scrollToBottom();

        } else if (state is AskErrorState) {
          log(state.error);
          setState(() {
            messages.removeWhere((m) => m['type'] == 'streaming');
            messages.add({
              'type': 'bot',
              'message':
              '⚠️ Sorry, something went wrong. Please try again.',
              'time': _formatTime(DateTime.now()),
            });
          });
          _scrollToBottom();
        }
      },

      child: Dialog(
        backgroundColor: ColorManger.pureWhite,
        alignment: Alignment.bottomCenter,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [

              // ── Header ──────────────────────────────
              Container(
                width: double.infinity,
                color: ColorManger.brightRed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 12),
                  child: Row(
                    children: [

                      // Bot avatar
                      CircleAvatar(
                        backgroundColor:
                        ColorManger.pureWhite.withValues(alpha: 0.3),
                        child: const Icon(
                          Icons.smart_toy_outlined,
                          color: ColorManger.pureWhite,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Title + status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "LifeLink Assistant",
                            textStyle: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManger.pureWhite,
                            ),
                          ),
                          const SizedBox(height: 4),
                          BlocBuilder<AskCubit, AskState>(
                            builder: (context, state) {
                              final label = switch (state) {
                                AskLoadingState()   =>
                                "Typing...",
                                AskStreamingState() =>
                                "Typing...",
                                _ => "Always here to help",
                              };
                              return CustomText(
                                text: label,
                                textStyle: TextStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight:
                                  FontWeightManager.regular,
                                  color: ColorManger.pureWhite,
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const Spacer(),

                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: ColorManger.pureWhite
                              .withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: _openVoiceCall,
                          icon: const Icon(
                            Icons.call_rounded,
                            color: ColorManger.pureWhite,
                            size: 22,
                          ),
                          tooltip: 'Voice Call',
                        ),
                      ),

                      // Close button
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManger.pureWhite
                              .withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close,
                            color: ColorManger.pureWhite,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Live STT banner ──────────────────────


              // ── Messages ─────────────────────────────
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message['type'] == 'user';
                    return isUser
                        ? UserMessage(
                      text: message['message']!,
                      time: message['time']!,
                    )
                        : BotMessage(
                      text: message['message']!,
                      time: message['time']!,
                    );
                  },
                ),
              ),

              // ── Progress bar ─────────────────────────
              BlocBuilder<AskCubit, AskState>(
                builder: (context, state) {
                  if (state is AskLoadingState ||
                      state is AskStreamingState) {
                    return LinearProgressIndicator(
                      color: ColorManger.brightRed,
                      backgroundColor: ColorManger.brightRed
                          .withValues(alpha: 0.2),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              // ── Input row ────────────────────────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [



                    const SizedBox(width: 8),

                    // Text input
                    Expanded(
                      child: CustomTextFormField(
                        textEditingController: _messageController,
                        hintText: "Type your message...",
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Send button
                    BlocBuilder<AskCubit, AskState>(
                      builder: (context, state) {
                        final isBusy =
                            state is AskLoadingState ||
                                state is AskStreamingState;
                        return FloatingActionButton(
                          backgroundColor: ColorManger.brightRed,
                          onPressed:
                          isBusy ? null : _sendMessage,
                          child: isBusy
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: ColorManger.pureWhite,
                              strokeWidth: 2,
                            ),
                          )
                              : const Icon(
                            Icons.send,
                            color: ColorManger.pureWhite,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
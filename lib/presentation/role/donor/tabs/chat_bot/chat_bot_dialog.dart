import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/widgets/bot_message.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/widgets/user_message.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ChatBotDialog extends StatefulWidget {
  const ChatBotDialog({super.key});

  @override
  State<ChatBotDialog> createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  late TextEditingController _messageController;
  late List<Map<String, String>> messages;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    // Dummy data for testing
    messages = [
      {
        'type': 'bot',
        'message': 'Hello! 👋 I\'m LifeLink Assistant. How can I help you today?',
        'time': '10:30 AM'
      },
      {
        'type': 'user',
        'message': 'How often can I donate blood?',
        'time': '10:31 AM'
      },
      {
        'type': 'bot',
        'message':
            'Great question! You can donate whole blood every 56 days (8 weeks). Platelet and plasma donations have different frequencies.',
        'time': '10:32 AM'
      },
      {
        'type': 'user',
        'message': 'What should I eat before donation?',
        'time': '10:33 AM'
      },
      {
        'type': 'bot',
        'message':
            'Eat a healthy meal 2-3 hours before donation. Avoid fatty foods and stay hydrated by drinking plenty of water.',
        'time': '10:34 AM'
      },
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _addMessage(String messageText, bool isUser) {
    if (messageText.isEmpty) return;

    setState(() {
      final now = DateTime.now();
      final timeString =
          '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';

      messages.add({
        'type': isUser ? 'user' : 'bot',
        'message': messageText,
        'time': timeString,
      });

      if (isUser) {
        // Simulate bot response
        Future.delayed(Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              final botTime =
                  '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}';
              messages.add({
                'type': 'bot',
                'message':
                    'Thank you for your question! I\'m here to help. Is there anything else you\'d like to know?',
                'time': botTime,
              });
            });
          }
        });
      }
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManger.pureWhite,
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [

            Container(
              width: double.infinity,
              color: ColorManger.brightRed,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorManger.pureWhite.withValues(
                        alpha: 0.3,
                      ),
                      child: Icon(
                        Icons.smart_toy_outlined,
                        color: ColorManger.pureWhite,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
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
                        SizedBox(height: 4),
                        CustomText(
                          text: "Always here to help",
                          textStyle: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManger.pureWhite,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: ColorManger.pureWhite),
                    ),
                  ],
                ),
              ),
            ),
            // Messages List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isBot = message['type'] == 'bot';

                  return isBot
                      ? BotMessage(
                          text: message['message']!,
                          time: message['time']!,
                        )
                      : UserMessage(
                          text: message['message']!,
                          time: message['time']!,
                        );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      textEditingController: _messageController,
                      hintText: "Type your message...",
                      keyboardType: TextInputType.text,
                      maxLines: 1,

                    ),
                  ),
                  SizedBox(width: 8),
                  FloatingActionButton(
                    backgroundColor: ColorManger.brightRed,
                    onPressed: () {
                      _addMessage(_messageController.text, true);
                    },
                    child: Icon(
                      Icons.send,
                      color: ColorManger.pureWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

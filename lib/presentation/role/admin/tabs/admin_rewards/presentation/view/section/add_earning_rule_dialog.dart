import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/presentation/view/widgets/custom_text_form_field.dart';

class NewEarningRuleResult {
  const NewEarningRuleResult({
    required this.type,
    required this.title,
    required this.points,
    required this.category,
    required this.isActive,
  });

  final String type;
  final String title;
  final int points;
  final String category;
  final bool isActive;
}

class AddEarningRuleDialog extends StatefulWidget {
  const AddEarningRuleDialog({super.key});

  @override
  State<AddEarningRuleDialog> createState() => _AddEarningRuleDialogState();
}

class _AddEarningRuleDialogState extends State<AddEarningRuleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _titleController = TextEditingController();
  final _pointsController = TextEditingController();
  String _selectedCategory = 'donation';
  bool _isActive = true;

  static const List<String> _categories = [
    'donation',
    'bonus',
  ];

  @override
  void dispose() {
    _typeController.dispose();
    _titleController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;
    final result = NewEarningRuleResult(
      type: _typeController.text.trim(),
      title: _titleController.text.trim(),
      points: int.parse(_pointsController.text.trim()),
      category: _selectedCategory,
      isActive: _isActive,
    );
    Navigator.of(context).pop(result);
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'donation':
        return 'Blood Component Donation';
      case 'bonus':
        return 'Engagement & Bonus';
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: ColorManger.pureWhite,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorManger.lightPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.emoji_events_outlined,
                        color: ColorManger.brightPurple, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: loc.addEarningRule,
                          textStyle: TextStyle(
                            color: ColorManger.black,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        CustomText(
                          text: loc.addEarningRuleSubtitle,
                          textStyle: TextStyle(
                            color: ColorManger.slateGrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Type field
              _Label(text: loc.earningRuleType),
              const SizedBox(height: 6),
              CustomTextFormField(
                hintText: loc.earningRuleTypeHint,
                textEditingController: _typeController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Title field
              _Label(text: loc.earningRuleTitle),
              const SizedBox(height: 6),
              CustomTextFormField(
                hintText: loc.earningRuleTitleHint,
                textEditingController: _titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Points field
              _Label(text: loc.points),
              const SizedBox(height: 6),
              CustomTextFormField(
                hintText: loc.earningRulePointsHint,
                textEditingController: _pointsController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.fieldRequired;
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return loc.invalidNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Category dropdown
              _Label(text: loc.earningRuleCategory),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorManger.lightPurple.withValues(alpha: 0.9),
                    width: 1.2,
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  dropdownColor: ColorManger.pureWhite,
                  style: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(
                      _getCategoryLabel(cat),
                      style: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                ),
              ),
              const SizedBox(height: 14),

              // isActive toggle
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManger.lightPurple.withValues(alpha: 0.4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.toggle_on_outlined,
                        color: ColorManger.brightPurple, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomText(
                        text: loc.earningRuleActiveStatus,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                    ),
                    Switch(
                      value: _isActive,
                      activeThumbColor: ColorManger.brightPurple,
                      onChanged: (val) => setState(() => _isActive = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.pureWhite,
                      foregroundColor: ColorManger.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: ColorManger.slateGrey.withValues(alpha: 0.4),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      onPressed: () => Navigator.of(context).pop(),
                      child: CustomText(
                        text: loc.cancel,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.brightPurple,
                      foregroundColor: ColorManger.pureWhite,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      onPressed: _handleSave,
                      child: CustomText(
                        text: loc.save,
                        textStyle: TextStyle(
                          color: ColorManger.pureWhite,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      textStyle: TextStyle(
        color: ColorManger.slateGrey,
        fontSize: FontSize.s12,
        fontWeight: FontWeightManager.medium,
      ),
    );
  }
}
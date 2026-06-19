import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';


class UserEditSheet extends StatefulWidget {
  final Users user;
  final Function(String name, String phone) onSaved;

  const UserEditSheet({super.key, required this.user, required this.onSaved});

  static void show(
    BuildContext context,
    Users user,
    Function(String name, String phone) onSaved,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => UserEditSheet(user: user, onSaved: onSaved),
    );
  }

  @override
  State<UserEditSheet> createState() => _UserEditSheetState();
}

class _UserEditSheetState extends State<UserEditSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _phoneCtrl = TextEditingController(text: widget.user.phone);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, appLocalization),
              const SizedBox(height: 20),
              _field(
                appLocalization.full_name,
                _nameCtrl,
                Icons.person_outline,
                validator: (value) => value?.nameValidator(context),
              ),
              const SizedBox(height: 12),
              _field(
                appLocalization.phone,
                _phoneCtrl,
                Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => value?.phoneValidator(context),
              ),
              const SizedBox(height: 20),
              _buildSaveButton(context, appLocalization),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations appLocalization) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: '${appLocalization.edit} ${appLocalization.users}',
          textStyle: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.bold,

            color: ColorManger.black,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ColorManger.grey200,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    AppLocalizations appLocalization,
  ) {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        elevation: 0,
        backgroundColor: ColorManger.brightRed,
        padding: const EdgeInsets.symmetric(vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            widget.onSaved(_nameCtrl.text.trim(), _phoneCtrl.text.trim());
            Navigator.pop(context);
          }
        },
        child: CustomText(
          text: appLocalization.saveChanges,
          textStyle: TextStyle(
            color: ColorManger.pureWhite,
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl,
    IconData icon, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          textStyle: TextStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.medium,
            color: ColorManger.slateGrey,
          ),
        ),
        const SizedBox(height: 6),
        CustomTextFormField(
          keyboardType: keyboardType,
          validator: validator,
          prefixIcon: Icon(icon, color: ColorManger.grey400, size: 20),
          textEditingController: ctrl,
        ),
      ],
    );
  }
}

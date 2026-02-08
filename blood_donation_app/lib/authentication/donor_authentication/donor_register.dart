import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DonorRegister extends StatefulWidget {
  const DonorRegister({super.key});

  @override
  State<DonorRegister> createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedBloodType;
  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.softPinkishWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: ColorManger.grey600),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.favorite_border, color: ColorManger.brightRed, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalization.donor_login_title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorManger.black,
                            ),
                          ),
                          Text(
                            appLocalization.donor_login_subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorManger.grey600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                   CustomAuthBox(
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            appLocalization.donor_register_title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorManger.black,
                            ),
                          ),
                          const SizedBox(height: 24),

                          CustomLabel(text: appLocalization.full_name,),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _fullNameController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_fullname;
                              }
                              return null;
                            },
                            hint: "John Doe",
                            icon: Icons.person_outline,
                            isPassword: false,
                          ),

                          const SizedBox(height: 16),

                          CustomLabel(text: appLocalization.donor_email),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _emailController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_email;
                              }
                              return null;
                            },
                            hint: "donor@example.com",
                            icon: Icons.email_outlined,
                            isPassword: false,
                          ),

                          const SizedBox(height: 16),

                          CustomLabel(text: appLocalization.phone_number,),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _phoneController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_phone;
                              }
                              return null;
                            },
                            hint: "+1 (555) 000-0000",
                            icon: Icons.phone_outlined,
                            isPassword: false,
                          ),

                          const SizedBox(height: 16),

                          CustomLabel(text: appLocalization.donor_blood_type,),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedBloodType,
                            items: _bloodTypes.map((type) {
                              return DropdownMenuItem(value: type, child: Text(type));
                            }).toList(),
                            onChanged: (val) => setState(() => _selectedBloodType = val),
                            decoration: InputDecoration(
                              hintText: appLocalization.donor_select_blood_type,
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              filled: true,
                              fillColor: ColorManger.textFormFieldGrey,
                              prefixIcon: Icon(Icons.water_drop_outlined, color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[500]),
                          ),

                          const SizedBox(height: 16),

                          // Location
                          CustomLabel(text: appLocalization.donor_location,),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _locationController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_location;
                              }
                              return null;
                            },
                            hint: appLocalization.city_state,
                            icon: Icons.location_on_outlined,
                            isPassword: false,
                          ),

                          const SizedBox(height: 16),

                          CustomLabel(text: appLocalization.donor_password),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _passwordController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_password;
                              }
                              return null;
                            },
                            hint: "••••••••",
                            icon: Icons.lock_outline,
                            isPassword: true,
                          ),

                          const SizedBox(height: 16),

                          CustomLabel(text: appLocalization.confirm_password,),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_confirm_password;
                              }
                              return null;
                            },
                            hint: "••••••••",
                            icon: Icons.lock_outline,
                            isPassword: true,
                          ),

                          const SizedBox(height: 32),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState!.validate()){

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManger.brightRed,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                appLocalization.donor_register_now,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appLocalization.already_have_account,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  appLocalization.donor_login_button,
                                  style: TextStyle(
                                    color: ColorManger.brightRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
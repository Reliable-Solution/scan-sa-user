import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/login_screens/controller/login_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/enums/centralize_login_enum.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class NewUserSetupScreen extends StatefulWidget {
  const NewUserSetupScreen({
    super.key,
    required this.name,
    required this.loginType,
    required this.phone,
    required this.email,
  });
  final String name;
  final String loginType;
  final String? phone;
  final String? email;

  @override
  State<NewUserSetupScreen> createState() => _NewUserSetupScreenState();
}

class _NewUserSetupScreenState extends State<NewUserSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _referCodeController = TextEditingController();
  GlobalKey<FormState>? _formKeyInfo;
  String? _countryDialCode;

  bool _isSocial = false;

  @override
  void initState() {
    super.initState();
    _isSocial = widget.loginType == CentralizeLoginType.social.name;
    _formKeyInfo = GlobalKey<FormState>();
    _countryDialCode = '+91';
    _isSocial ? _nameController.text = widget.name : _nameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: SafeArea(
        child: Align(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraLarge,
            ),
            margin: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyInfo,
                child: Column(
                  children: [
                    Image.asset(AppIcons.logo, width: 125),
                    const SizedBox(height: Dimensions.paddingSizeLarge),

                    Text(
                      context.l10n.justOneStepAway,
                      textAlign: TextAlign.center,
                      style: context.style.s18w700,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtremeLarge),

                    AppTextField(
                      hintText: context.l10n.userName,
                      controller: _nameController,
                      validator: (value) => AppValidations.emptyFieldValidation(
                        value,
                        context.l10n.pleaseEnterUserName,
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                    if (_isSocial)
                      AppTextField(
                        hintText: context.l10n.phone,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            AppValidations.emptyFieldValidation(
                              value,
                              context.l10n.pleaseEnterPhoneNumber,
                            ),
                      )
                    // CustomTextField(
                    //   titleText: 'xxx-xxx-xxxxx'.tr,
                    //   labelText: 'phone'.tr,
                    //   showLabelText: true,
                    //   required: true,
                    //   controller: _phoneController,
                    //   focusNode: _phoneFocus,
                    //   nextFocus: _referCodeFocus,
                    //   inputType: TextInputType.phone,
                    //   isPhone: true,
                    //   onCountryChanged: (CountryCode countryCode) {
                    //     _countryDialCode = countryCode.dialCode;
                    //   },
                    //   countryDialCode: _countryDialCode != null
                    //       ? CountryCode.fromCountryCode(
                    //           Get.find<SplashController>()
                    //               .configModel!
                    //               .country!,
                    //         ).code
                    //       : Get.find<LocalizationController>()
                    //             .locale
                    //             .countryCode,
                    //   validator: (value) => ValidateCheck.validateEmptyText(
                    //     value,
                    //     'please_enter_phone_number'.tr,
                    //   ),
                    // )
                    else
                      AppTextField(
                        hintText: context.l10n.email,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (p0) =>
                            AppValidations.emailFieldValidation(p0, context),
                      ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                    if (Get.find<GlobalController>()
                            .configModel!
                            .refEarningStatus ==
                        1)
                      AppTextField(
                        hintText: context.l10n.referCode,
                        controller: _referCodeController,
                        textInputAction: TextInputAction.done,
                      )
                    else
                      const SizedBox(),
                    SizedBox(
                      height:
                          (Get.find<GlobalController>()
                                  .configModel!
                                  .refEarningStatus ==
                              1)
                          ? Dimensions.paddingSizeExtraOverLarge
                          : 0,
                    ),

                    GetBuilder<LoginController>(
                      builder: (authController) {
                        return AppButton(
                          label: context.l10n.done,
                          onPressed: () async {
                            if (_formKeyInfo!.currentState!.validate()) {
                              if (widget.phone == null ||
                                  widget.phone!.isEmpty) {
                                var numberWithCountryCode =
                                    _countryDialCode! +
                                    _phoneController.text.trim();
                                numberWithCountryCode.print;
                                final phoneValid =
                                    await AppValidations.isPhoneValid(
                                      numberWithCountryCode,
                                    );
                                numberWithCountryCode = phoneValid.phone;
                                if (!phoneValid.isValid) {
                                  if (context.mounted) {
                                    showCustomSnackBar(
                                      context.l10n.invalidPhoneNumber,
                                    );
                                  }
                                } else {
                                  _updatePersonalInfo(
                                    authController,
                                    numberWithCountryCode,
                                  );
                                }
                              } else {
                                _updatePersonalInfo(authController, '');
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updatePersonalInfo(
    LoginController loginController,
    String numberWithCountryCode,
  ) {
    final name = _nameController.text.trim();
    loginController
        .updatePersonalInfo(
          name: name.isNotEmpty ? name : widget.name,
          phone: (widget.phone != null && widget.phone!.isNotEmpty)
              ? widget.phone
              : numberWithCountryCode,
          loginType: widget.loginType,
          email: widget.email ?? _emailController.text.trim(),
          referCode: _referCodeController.text.trim(),
        )
        .then((response) {
          if (response.isSuccess) {
            Get.find<GlobalController>().getUserInfo();
          } else {
            showCustomSnackBar(response.message);
          }
        });
  }
}

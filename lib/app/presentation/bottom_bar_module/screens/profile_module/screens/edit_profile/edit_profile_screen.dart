import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/edit_profile/controller/edit_profile_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_dialog.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final globalController = Get.find<GlobalController>();

  final profileController = Get.put(
    EditProfileController(profileServiceInterface: Get.find()),
  );

  @override
  void initState() {
    profileController.nameController.text =
        globalController.userInfoModel?.fName ?? '';
    profileController.gmailController.text =
        globalController.userInfoModel?.email ?? '';
    profileController.mobileController.text =
        globalController.userInfoModel?.phone ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (profileController) {
        return GetBuilder<GlobalController>(
          builder: (globalController) {
            return CommonSubScreen(
              appBarTitle: context.l10n.profile,
              btnText: context.l10n.updateProfile,
              onTap: () => profileController.updateUserInfo(fromButton: true),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                children: [
                  Align(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: context.color.lightText,
                          child: ClipOval(
                            child: profileController.pickedFile == null
                                ? (globalController
                                              .userInfoModel
                                              ?.imageFullUrl
                                              ?.isNotEmpty ??
                                          false)
                                      ? Image.network(
                                          globalController
                                                  .userInfoModel
                                                  ?.imageFullUrl ??
                                              '',
                                          height: 110,
                                          width: 110,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.person, size: 30)
                                : Image.file(
                                    File(
                                      profileController.pickedFile?.path ?? '',
                                    ),
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async => profileController.pickImage(),
                          child: CircleAvatar(
                            backgroundColor: context.color.secondary,
                            radius: 13,
                            child: Icon(
                              Icons.edit,
                              size: 13,
                              color: context.color.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AppTextField(
                      hintText: '',
                      controller: profileController.nameController,
                      borderColor: Colors.transparent,
                      prefixIcon: const Icon(Icons.person),
                      bottomPadding: 0,
                      style: context.style.s16w500,
                    ),
                  ),
                  AppTextField(
                    hintText: '',
                    borderColor: Colors.transparent,
                    controller: profileController.gmailController,
                    prefixIcon: const Icon(Icons.email_rounded),
                    bottomPadding: 4,
                    readOnly: true,
                    style: context.style.s16w500,
                  ),
                  AppTextField(
                    hintText: '',
                    borderColor: Colors.transparent,
                    controller: profileController.mobileController,
                    prefixIcon: const Icon(Icons.call),
                    bottomPadding: 4,
                    readOnly: true,
                    style: context.style.s16w500,
                  ),
                  profileWidget(
                    context,
                    icon: AppIcons.appleIc,
                    title: context.l10n.changePassword,
                    screenPath: AppPages.changePassScreen,
                  ),
                  // Divider(color: context.color.borderColor, height: 15),
                  // profileWidget(
                  //   context,
                  //   icon: AppIcons.appleIc,
                  //   title: context.l10n.darkMode,
                  //   suffixIcon: CustomSwitch(
                  //     value:
                  //         Get.find<GlobalController>().themeMode.value ==
                  //         ThemeMode.dark,
                  //     onChanged: () {
                  //       Get.find<GlobalController>().toggleTheme();
                  //     },
                  //   ),
                  // ),
                  Divider(color: context.color.borderColor, height: 15),
                  profileWidget(
                    context,
                    icon: AppIcons.appleIc,
                    title: context.l10n.notification,
                    suffixIcon: CustomSwitch(
                      value: profileController.notification,
                      onChanged: () {
                        profileController.setNotificationActive();
                      },
                    ),
                  ),
                  Divider(color: context.color.borderColor, height: 15),
                  profileWidget(
                    context,
                    icon: AppIcons.deleteIc,
                    title: context.l10n.deleteAccount,
                    suffixIcon: const SizedBox.shrink(),
                    iconColor: context.color.redColor,
                    onTap: () => showAppDialog(
                      context,
                      icon: '',
                      title: context.l10n.deleteAccountExclam,
                      description: context.l10n.confirmDeleteAccount,
                      onYesTap: () => profileController.deleteUser(),
                    ),
                  ),
                  Divider(color: context.color.borderColor, height: 15),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget profileWidget(
    BuildContext context, {
    required String icon,
    required String title,
    String? screenPath,
    Function()? onTap,
    Color? iconColor,
    Widget? suffixIcon,
  }) {
    return GestureDetector(
      onTap: onTap ?? () => screenPath?.push(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 14),
        color: Colors.transparent,
        child: Row(
          spacing: 14,
          children: [
            SvgAssets(icon, color: iconColor ?? context.color.primary),
            Text(
              title,
              style: context.style.s16w500.copyWith(color: iconColor),
            ),
            const Spacer(),
            suffixIcon ??
                RotatedBox(
                  quarterTurns: 3,
                  child: SvgAssets(AppIcons.arrowBottomIc, height: 10),
                ),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function() onChanged;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _circleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _circleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_animationController);

    if (widget.value) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: 50,
            height: 25,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: _animationController.value > 0.5
                  ? Colors.green
                  : Colors.grey.shade400,
            ),
            child: Align(
              alignment: _circleAnimation.value,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/language_change_sheet.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/edit_profile/edit_profile_screen.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_dialog.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/app/widgets/login_sheet.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (globalController) {
        final userModel = globalController.userInfoModel;
        final isGuest = globalController.isGuestMode;
        return Stack(
          children: [
            gradientWidget(),
            gradientWidget(isRight: true),
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  // SliverAppBar(
                  //   backgroundColor: Colors.transparent,
                  //   elevation: 0,
                  //   floating: true,
                  //   snap: true,
                  //   centerTitle: true,
                  //   toolbarHeight: 160,
                  //   foregroundColor: Colors.transparent,
                  //   surfaceTintColor: Colors.transparent,
                  //   title: Column(
                  //     spacing: 10,
                  //     children: [
                  //       CacheImageNetwork(
                  //         userModel?.imageFullUrl ?? '',
                  //         height: 86,
                  //         width: 86,
                  //         radius: 43,
                  //         boxFit: BoxFit.cover,
                  //       ),
                  //       Text(
                  //         userModel?.fName ?? '',
                  //         textAlign: TextAlign.center,
                  //         style: context.style.s24w700,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            spacing: isGuest ? 20 : 10,
                            children: [
                              if (isGuest)
                                CircleAvatar(
                                  radius: 43,
                                  backgroundColor: context.color.grey,
                                  child: Icon(
                                    Icons.person,
                                    color: context.color.primary,
                                    size: 40,
                                  ),
                                )
                              else
                                CacheImageNetwork(
                                  userModel?.imageFullUrl ?? '',
                                  height: 86,
                                  width: 86,
                                  radius: 43,
                                  boxFit: BoxFit.cover,
                                ),
                              if (isGuest)
                                SizedBox(
                                  width: 180,
                                  height: 40,
                                  child: AppButton(
                                    label: 'login'.tr,
                                    onPressed: () => AppPages.login.offAll(),
                                  ),
                                )
                              else
                                Text(
                                  userModel?.fName ?? '',
                                  textAlign: TextAlign.center,
                                  style: context.style.s24w700,
                                ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: context.color.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.appPadding,
                            vertical: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10n.general,
                                style: context.style.s20w900.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: profileWidget(
                                  context,
                                  icon: AppIcons.appleIc,
                                  title: context.l10n.profile,
                                  screenPath: AppPages.editProfileScreen,
                                ),
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.myAddress,
                                screenPath: AppPages.locationHomeScreen,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.language,
                                onTap: showChangeLanSheet,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.darkMode,
                                suffixIcon: CustomSwitch(
                                  value:
                                      Get.find<GlobalController>()
                                          .themeMode
                                          .value ==
                                      ThemeMode.dark,
                                  onChanged: () {
                                    Get.find<GlobalController>().toggleTheme();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  context.l10n.promotionalActivity,
                                  style: context.style.s20w900.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.coupon,
                                screenPath: AppPages.couponScreen,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.loyalPoints,
                                screenPath: AppPages.loyalPoint,
                                suffixIcon: isGuest
                                    ? null
                                    : DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              context.color.ff65C8A0.withValues(
                                                alpha: .4,
                                              ),
                                              context.color.ff65C8A0.withValues(
                                                alpha: .2,
                                              ),
                                            ],
                                          ),
                                          border: Border.all(
                                            color: context.color.ff65C8A0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            '${userModel?.loyaltyPoint} ${context.l10n.threePoints}',
                                            style: context.style.s12w700
                                                .copyWith(
                                                  color:
                                                      context.color.greenColor,
                                                ),
                                          ),
                                        ),
                                      ),
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.myWallet,
                                screenPath: AppPages.walletScreen,
                                suffixIcon: isGuest
                                    ? null
                                    : DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              context.color.ff65C8A0.withValues(
                                                alpha: .4,
                                              ),
                                              context.color.ff65C8A0.withValues(
                                                alpha: .2,
                                              ),
                                            ],
                                          ),
                                          border: Border.all(
                                            color: context.color.ff65C8A0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            '${userModel?.walletBalance} ${AppStrings.dinar}',
                                            style: context.style.s12w700
                                                .copyWith(
                                                  color:
                                                      context.color.greenColor,
                                                ),
                                          ),
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  context.l10n.earning,
                                  style: context.style.s20w900.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.joinAsDeliveryMan,
                                screenPath: AppPages.joinAsDeliveryScreen,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.openVendor,
                                screenPath: AppPages.joinAsVendorScreen,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  bottom: 10,
                                ),
                                child: Text(
                                  context.l10n.helpSupport,
                                  style: context.style.s20w900.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.liveChat,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                screenPath: AppPages.helpNSupport,
                                title: context.l10n.helpSupport,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.aboutUs,
                                isForceTap: true,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.termsConditions,
                                screenPath: AppPages.htmlViewerScreen,
                                isForceTap: true,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                title: context.l10n.privacyPolicy,
                                isForceTap: true,
                                screenPath: AppPages.htmlViewerScreen,
                                extraParma: true,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              profileWidget(
                                context,
                                icon: AppIcons.appleIc,
                                isForceTap: true,
                                title: context.l10n.refundPolicy,
                              ),
                              Divider(
                                color: context.color.borderColor,
                                height: 4,
                              ),
                              if (!isGuest)
                                profileWidget(
                                  context,
                                  icon: AppIcons.appleIc,
                                  title: context.l10n.logoutPlain,
                                  iconColor: context.color.redColor,
                                  suffixIcon: const SizedBox.shrink(),
                                  onTap: () => showAppDialog(
                                    context,
                                    icon: '',
                                    title: context.l10n.logout,
                                    description: context.l10n.confirmLogout,
                                    onYesTap: () async {
                                      final email =
                                          Get.find<SharedPreferences>()
                                              .getString('email');
                                      final pass = Get.find<SharedPreferences>()
                                          .getString('pass');
                                      // await Get.find<SharedPreferences>().clear();
                                      await Get.find<SharedPreferences>()
                                          .setString('email', email ?? '');
                                      await Get.find<SharedPreferences>()
                                          .setString('email', email ?? '');
                                      await Get.find<SharedPreferences>()
                                          .setString('pass', pass ?? '');
                                      await globalController.logout();
                                      AppPages.login.offAll();
                                    },
                                  ),
                                ),
                              const SizedBox(height: 30),
                              if (isGuest)
                                AppButton(
                                  label: 'login'.tr,
                                  onPressed: () => AppPages.login.offAll(),
                                ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () => showAppDialog(
                              //         context,
                              //         icon: '',
                              //         title: context.l10n.logout,
                              //         description: context.l10n.confirmLogout,
                              //         onYesTap: () => AppPages.login.offAll,
                              //       ),
                              //       child: Container(
                              //         color: Colors.transparent,
                              //         padding: const EdgeInsets.symmetric(
                              //           vertical: 5,
                              //           horizontal: 10,
                              //         ),
                              //         child: Row(
                              //           spacing: 10,
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           children: [
                              //             const Icon(Icons.logout),
                              //             Text(
                              //               context.l10n.logout,
                              //               style: context.style.s18w700.copyWith(
                              //                 color: context.color.primary,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget profileWidget(
    BuildContext context, {
    required String icon,
    required String title,
    String? screenPath,
    bool isForceTap = false,
    Function()? onTap,
    Color? iconColor,
    Widget? suffixIcon,
    dynamic extraParma,
  }) {
    return GestureDetector(
      onTap:
          onTap ??
          () => (!isForceTap && Get.find<GlobalController>().isGuestMode)
              ? showLoginSheet()
              : screenPath?.push(arguments: extraParma),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.transparent,
        child: Row(
          spacing: 10,
          children: [
            const SizedBox.shrink(),
            Text(
              title,
              style: context.style.s16w700.copyWith(
                color: iconColor ?? context.color.ff6c6c6c,
              ),
            ),
            const Spacer(),
            suffixIcon ??
                RotatedBox(
                  quarterTurns: 3,
                  child: SvgAssets(
                    AppIcons.arrowBottomIc,
                    height: 8,
                    color: context.color.ff6c6c6c,
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget gradientWidget({bool isRight = false, double? height}) {
    return Align(
      alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 100,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isRight
                ? [
                    const Color(0xFFF5BE01),
                    const Color(0xFFF5AF01),
                    const Color(0xFFF5B001),
                  ]
                : [
                    const Color(0xFFF5B001),
                    const Color(0xFFF5AF01),
                    const Color(0xFFF5BE01),
                  ],
          ),
        ),
      ),
    );
  }
}

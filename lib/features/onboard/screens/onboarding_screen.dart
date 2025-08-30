import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/features/auth/controllers/auth_controller.dart';
import 'package:scan_sa_user/features/location/controllers/location_controller.dart';
import 'package:scan_sa_user/features/onboard/controllers/onboard_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/common/widgets/web_menu_bar.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    Get.find<OnBoardingController>().getOnBoardingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            Images.onboardingBack,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height * .45,
            width: MediaQuery.sizeOf(context).width,
          ),
          SafeArea(
            child: GetBuilder<OnBoardingController>(
              builder: (onBoardingController) {
                bool showIndicatorAndButton =
                    onBoardingController.selectedIndex <
                        onBoardingController.onBoardingList.length - 1;
                if (onBoardingController.onBoardingList.isNotEmpty) {
                  return SafeArea(
                    child: PageView.builder(
                      itemCount: onBoardingController.onBoardingList.length,
                      controller: _pageController,
                      // physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.paddingOf(
                                          context,
                                        ).top +
                                        75,
                                  ),
                                  Text(
                                    onBoardingController
                                        .onBoardingList[index].title,
                                    style: robotoMedium.copyWith(
                                      fontSize: context.height * 0.028,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    onBoardingController
                                        .onBoardingList[index].description,
                                    style: robotoRegular.copyWith(
                                      fontSize: context.height * 0.017,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            if (showIndicatorAndButton &&
                                onBoardingController
                                        .onBoardingList[index].imageUrl !=
                                    '')
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: context.height * 0.3,
                                  ),
                                  child: SvgAssets(
                                    onBoardingController
                                        .onBoardingList[index].imageUrl,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                      onPageChanged: (index) {
                        onBoardingController.changeSelectIndex(index);
                        if (onBoardingController.selectedIndex == 2) {
                          _configureToRouteInitialPage();
                        }
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 20,
            left: 25,
            child: GetBuilder<OnBoardingController>(
              builder: (onBoardingController) {
                return AnimatedOpacity(
                  duration: Durations.medium1,
                  opacity: onBoardingController.selectedIndex == 0 ? 0 : 1,
                  child: GestureDetector(
                    onTap: () {
                      if (onBoardingController.selectedIndex != 0) {
                        _pageController.previousPage(
                          duration: const Duration(
                            seconds: 1,
                          ),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.color.secondary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF343434).withValues(alpha: .5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgAssets(
                          Images.arrowBackIc,
                          color: context.color.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          GetBuilder<OnBoardingController>(
            builder: (onBoardingController) {
              // bool showIndicatorAndButton = onBoardingController.selectedIndex <
              //     onBoardingController.onBoardingList.length - 1;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40).add(
                  EdgeInsets.only(
                    bottom: (MediaQuery.paddingOf(context).bottom) / 2 + 20,
                  ),
                ),
                child: AppButton(
                  buttonText: onBoardingController.selectedIndex != 2
                      ? 'next'.tr
                      : 'get_started'.tr,
                  onPressed: () {
                    if (onBoardingController.selectedIndex != 2) {
                      _pageController.nextPage(
                        duration: const Duration(
                          seconds: 1,
                        ),
                        curve: Curves.ease,
                      );
                    } else {
                      _configureToRouteInitialPage();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // List<Widget> _pageIndicators(
  //   OnBoardingController onBoardingController,
  //   BuildContext context,
  // ) {
  //   List<Container> indicators = [];
  //   for (int i = 0; i < onBoardingController.onBoardingList.length - 1; i++) {
  //     indicators.add(
  //       Container(
  //         width: 7,
  //         height: 7,
  //         margin: const EdgeInsets.only(right: 10),
  //         decoration: BoxDecoration(
  //           color: i == onBoardingController.selectedIndex
  //               ? context.color.secondary
  //               : Theme.of(context).disabledColor,
  //           borderRadius: i == onBoardingController.selectedIndex
  //               ? BorderRadius.circular(50)
  //               : BorderRadius.circular(25),
  //         ),
  //       ),
  //     );
  //   }
  //   return indicators;
  // }

  Future<void> _configureToRouteInitialPage() async {
    Get.find<SplashController>().disableIntro();
    await Get.find<AuthController>().guestLogin();
    if (AddressHelper.getUserAddressFromSharedPref() != null) {
      Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
    } else {
      Get.find<LocationController>()
          .navigateToLocationScreen(RouteHelper.onBoarding, offNamed: true)
          .then((v) {
        _pageController.jumpToPage(
          Get.find<OnBoardingController>().onBoardingList.length - 2,
        );
      });
    }
  }
}

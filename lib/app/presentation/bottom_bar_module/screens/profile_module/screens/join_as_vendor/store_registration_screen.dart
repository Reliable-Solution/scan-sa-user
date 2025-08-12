import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/vendor_registration_screens/business_plan_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/vendor_registration_screens/location_info_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/vendor_registration_screens/owner_info_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/vendor_registration_screens/vendor_info_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/vendor_registration_screens/vendor_preference_widget.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class StoreRegistrationScreen extends StatefulWidget {
  const StoreRegistrationScreen({super.key});

  @override
  State<StoreRegistrationScreen> createState() =>
      _StoreRegistrationScreenState();
}

class _StoreRegistrationScreenState extends State<StoreRegistrationScreen> {
  final storeController = Get.put(
    StoreRegistrationController(
      locationServiceInterface: Get.find(),
      storeRegistrationServiceInterface: Get.find(),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      EasyLoading.load();
      Get.put(LocationController(locationServiceInterface: Get.find()));

      await Get.find<StoreRegistrationController>().getZoneList();
      Get.find<StoreRegistrationController>().storeStatusChange(
        0.1,
        isUpdate: false,
      );
      Get.find<StoreRegistrationController>().selectModuleIndex(
        -1,
        canUpdate: false,
      );
      if (Get.find<StoreRegistrationController>().showPassView) {
        Get.find<StoreRegistrationController>().showHidePass(isUpdate: false);
      }
      Get.find<StoreRegistrationController>().resetBusiness();
      Get.find<StoreRegistrationController>().clearPickupZone();
      EasyLoading.dismiss();
    });
  }

  int screenIndex = 0;

  @override
  void dispose() {
    // storeController
    //   ..lNameController.clear()
    //   ..fNameController.clear()
    //   ..emailController.clear()
    //   ..phoneController.clear()
    //   ..passwordController.clear()
    //   ..confirmPasswordController.clear()
    //   ..identityNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Get.find<GlobalController>().isDark
                ? context.color.white
                : context.color.fff5f5f5,
            bottomNavigationBar: Padding(
              padding: AppPadding.bottomPad(context),
              child: Row(
                spacing: 10,
                children: [
                  if (screenIndex != 0)
                    Expanded(
                      child: AppButton(
                        label: 'back'.tr,
                        btnColor: context.color.grey,
                        txtColor: context.color.primary,
                        onPressed: () {
                          setState(() {
                            screenIndex--;
                          });
                        },
                      ),
                    ),
                  Expanded(
                    child: AppButton(
                      label: screenIndex == 2 ? 'submit'.tr : 'next'.tr,
                      onPressed: () {
                        if (screenIndex == 0) {
                          if (storeController.vendorName.text.isEmpty) {
                            showCustomSnackBar('Please enter vendor name');
                            return;
                          } else if (storeController.pickedLogo == null) {
                            showCustomSnackBar('Please choose vendor logo');
                            return;
                          } else if (storeController.pickedCover == null) {
                            showCustomSnackBar(
                              'Please choose vendor cover image',
                            );
                            return;
                          } else if (storeController.selectedZoneIndex == -1) {
                            showCustomSnackBar('Please select zone');
                            return;
                          } else if (storeController.selectedModuleIndex ==
                              -1) {
                            showCustomSnackBar('Please select module');
                            return;
                          } else if (storeController
                                  .selectedPickupZone
                                  ?.isEmpty ??
                              true) {
                            showCustomSnackBar('Please select pick zone');
                            return;
                          } else if (storeController
                              .addressController
                              .text
                              .isEmpty) {
                            showCustomSnackBar('Please enter your address');
                            return;
                          } else if (storeController
                              .vatController
                              .text
                              .isEmpty) {
                            showCustomSnackBar('Please enter Vat/Tax amount');
                            return;
                          } else if (storeController.storeMinTime == '--') {
                            showCustomSnackBar(
                              'Please enter estimated delivery time',
                            );
                            return;
                          }
                        } else if (screenIndex == 1) {
                          if (!Form.of(context).validate()) return;
                        } else {
                          if (storeController
                                  .packageModel
                                  ?.packages
                                  ?.isNotEmpty ??
                              false) {
                            if (storeController.isSubscriptionPlan &&
                                storeController.selectedPlan == null) {
                              showCustomSnackBar(
                                'Please choose any one subscription plan',
                              );
                              return;
                            }
                          } else {
                            showCustomSnackBar('No subscription plan found');
                            return;
                          }
                        }
                        if (screenIndex == 2) {
                          storeController.registerStore();
                          return;
                        }
                        setState(() {
                          screenIndex++;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              leadingWidth: AppSizes.appPadding + 40,
              leading: Padding(
                padding: EdgeInsets.only(left: AppSizes.appPadding),
                child: const BackBtn(),
              ),
              title: Text(
                'vendor_registration'.tr,
                style: context.style.s22w700,
              ),
            ),
            body: GetBuilder<StoreRegistrationController>(
              builder: (controller) {
                return ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                    vertical: 10,
                  ),
                  children: [
                    if (screenIndex == 0) const VendorInfoWidget(),
                    if (screenIndex == 0) const LocationInfoWidget(),
                    if (screenIndex == 0) const VendorPreferenceWidget(),
                    if (screenIndex == 1) const OwnerInfoWidget(),
                    if (screenIndex == 2) const BusinessPlanWidget(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sixam_mart/common/widgets/confirmation_dialog.dart';
// import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
// import 'package:sixam_mart/common/widgets/custom_tool_tip_widget.dart';
// import 'package:sixam_mart/features/auth/widgets/business/base_card_widget.dart';
// import 'package:sixam_mart/features/auth/widgets/business/web_business_plan_widget.dart';
// import 'package:sixam_mart/features/auth/widgets/module_view_widget.dart';
// import 'package:sixam_mart/features/auth/widgets/web_registration_stepper_widget.dart';
// import 'package:sixam_mart/features/business/widgets/package_card_widget.dart';
// import 'package:sixam_mart/features/dashboard/screens/dashboard_screen.dart';
// import 'package:sixam_mart/features/language/controllers/language_controller.dart';
// import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
// import 'package:sixam_mart/features/auth/domain/models/store_body_model.dart';
// import 'package:sixam_mart/common/models/translation.dart';
// import 'package:sixam_mart/common/models/config_model.dart';
// import 'package:sixam_mart/features/auth/controllers/store_registration_controller.dart';
// import 'package:sixam_mart/features/auth/widgets/custom_time_picker_widget.dart';
// import 'package:sixam_mart/features/auth/widgets/pass_view_widget.dart';
// import 'package:sixam_mart/features/auth/widgets/select_location_view_widget.dart';
// import 'package:sixam_mart/helper/responsive_helper.dart';
// import 'package:sixam_mart/helper/validate_check.dart';
// import 'package:sixam_mart/util/dimensions.dart';
// import 'package:sixam_mart/util/images.dart';
// import 'package:sixam_mart/util/styles.dart';
// import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
// import 'package:sixam_mart/common/widgets/custom_button.dart';
// import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
// import 'package:sixam_mart/common/widgets/custom_text_field.dart';
// import 'package:sixam_mart/common/widgets/footer_view.dart';
// import 'package:sixam_mart/common/widgets/menu_drawer.dart';
// import 'package:sixam_mart/common/widgets/web_page_title_widget.dart';

// class StoreRegistrationScreen extends StatefulWidget {
//   const StoreRegistrationScreen({super.key});

//   @override
//   State<StoreRegistrationScreen> createState() =>
//       _StoreRegistrationScreenState();
// }

// class _StoreRegistrationScreenState extends State<StoreRegistrationScreen>
//     with TickerProviderStateMixin {
//   final List<TextEditingController> _nameController = [];
//   final List<TextEditingController> _addressController = [];
//   final TextEditingController _vatController = TextEditingController();
//   final TextEditingController _fNameController = TextEditingController();
//   final TextEditingController _lNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   final List<FocusNode> _nameFocus = [];
//   final List<FocusNode> _addressFocus = [];
//   final FocusNode _vatFocus = FocusNode();
//   final FocusNode _fNameFocus = FocusNode();
//   final FocusNode _lNameFocus = FocusNode();
//   final FocusNode _phoneFocus = FocusNode();
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final FocusNode _confirmPasswordFocus = FocusNode();
//   final List<Language>? _languageList =
//       Get.find<SplashController>().configModel!.language;
//   final ScrollController _scrollController = ScrollController();
//   final GlobalKey _storeInfoScrollKey = GlobalKey();
//   final GlobalKey _storePrefScrollKey = GlobalKey();
//   final GlobalKey _locationInfoScrollKey = GlobalKey();

//   String? _countryDialCode;
//   bool firstTime = true;
//   TabController? _tabController;
//   final List<Tab> _tabs = [];

//   GlobalKey<FormState>? _formKeyFirst;
//   GlobalKey<FormState>? _formKeySecond;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: _languageList!.length,
//       initialIndex: 0,
//       vsync: this,
//     );
//     _countryDialCode = CountryCode.fromCountryCode(
//       Get.find<SplashController>().configModel!.country!,
//     ).dialCode;
//     for (var language in _languageList) {
//       if (kDebugMode) {
//         debugPrint(language.toJson().toString());
//       }
//       _nameController.add(TextEditingController());
//       _addressController.add(TextEditingController());
//       _nameFocus.add(FocusNode());
//       _addressFocus.add(FocusNode());
//     }
//     Get.find<StoreRegistrationController>()
//         .storeStatusChange(0.1, isUpdate: false);
//     Get.find<StoreRegistrationController>().getZoneList();
//     Get.find<StoreRegistrationController>()
//         .selectModuleIndex(-1, canUpdate: false);
//     if (Get.find<StoreRegistrationController>().showPassView) {
//       Get.find<StoreRegistrationController>().showHidePass(isUpdate: false);
//     }
//     Get.find<StoreRegistrationController>().resetBusiness();
//     Get.find<StoreRegistrationController>().clearPickupZone();

//     for (var language in _languageList) {
//       _tabs.add(Tab(text: language.value));
//     }
//     _formKeyFirst = GlobalKey<FormState>();
//     _formKeySecond = GlobalKey<FormState>();
//   }

//   Future<void> _showBackPressedDialogue(String title) async {
//     Get.dialog(
//       ConfirmationDialog(
//         icon: Images.support,
//         title: title,
//         description: 'are_you_sure_to_go_back'.tr,
//         isLogOut: true,
//         onYesPressed: () {
//           if (Get.isDialogOpen!) {
//             Get.back();
//           }
//           if (ResponsiveHelper.isDesktop(Get.context)) {
//             Get.back();
//           } else {
//             Get.off(() => const DashboardScreen(pageIndex: 4));
//           }
//         },
//       ),
//       useSafeArea: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) async {
//         if (Get.find<StoreRegistrationController>().storeStatus == 0.6 &&
//             firstTime) {
//           Get.find<StoreRegistrationController>().storeStatusChange(0.1);
//           firstTime = false;
//         } else if (Get.find<StoreRegistrationController>().storeStatus == 0.9) {
//           Get.find<StoreRegistrationController>().storeStatusChange(0.6);
//           // firstTime = false;
//         } else {
//           await _showBackPressedDialogue('your_registration_not_setup_yet'.tr);
//         }
//       },
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title: 'vendor_registration'.tr,
//           onBackPressed: () async {
//             if (Get.find<StoreRegistrationController>().storeStatus != 0.1 &&
//                 firstTime) {
//               Get.find<StoreRegistrationController>().storeStatusChange(0.1);
//               firstTime = false;
//             } else {
//               await _showBackPressedDialogue(
//                 'your_registration_not_setup_yet'.tr,
//               );
//             }
//           },
//         ),
//         endDrawer: const MenuDrawer(),
//         endDrawerEnableOpenDragGesture: false,
//         body: SafeArea(
//           child: GetBuilder<StoreRegistrationController>(
//             builder: (storeController) {
//               if (storeController.storeAddress != null &&
//                   _languageList!.isNotEmpty) {
//                 _addressController[0].text =
//                     storeController.storeAddress.toString();
//               }

//               return Column(
//                 children: [
//                   WebScreenTitleWidget(title: 'join_as_vendor'.tr),
//                   ResponsiveHelper.isDesktop(context)
//                       ? Center(
//                           child: SizedBox(
//                             width: Dimensions.webMaxWidth,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 25, bottom: 35),
//                               child: RegistrationStepperWidget(
//                                 status: storeController.storeStatus == 0.9
//                                     ? 'business'
//                                     : '',
//                               ),
//                             ),
//                           ),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: Dimensions.paddingSizeLarge,
//                             vertical: Dimensions.paddingSizeSmall,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 storeController.storeStatus == 0.1
//                                     ? 'provide_vendor_information_to_proceed_next'
//                                         .tr
//                                     : storeController.storeStatus == 0.6
//                                         ? 'provide_owner_information_to_confirm'
//                                             .tr
//                                         : 'you_are_one_step_away_choose_your_business_plan'
//                                             .tr,
//                                 style: robotoRegular.copyWith(
//                                   fontSize: Dimensions.fontSizeSmall,
//                                   color: Theme.of(context).hintColor,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: Dimensions.paddingSizeSmall,
//                               ),
//                               LinearProgressIndicator(
//                                 backgroundColor:
//                                     Theme.of(context).disabledColor,
//                                 minHeight: 2,
//                                 value:
//                                     storeController.storeStatus.toDouble(),
//                               ),
//                             ],
//                           ),
//                         ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       controller: _scrollController,
//                       padding: ResponsiveHelper.isDesktop(context)
//                           ? EdgeInsets.zero
//                           : const EdgeInsets.symmetric(
//                               vertical: Dimensions.paddingSizeSmall,
//                               horizontal: Dimensions.paddingSizeDefault,
//                             ),
//                       child: FooterView(
//                         child: SizedBox(
//                           width: Dimensions.webMaxWidth,
//                           child: ResponsiveHelper.isDesktop(context)
//                               ? webView(storeController)
//                               : Column(
//                                   children: [
//                                     Visibility(
//                                       visible:
//                                           storeController.storeStatus == 0.1,
//                                       child: Form(
//                                         key: _formKeyFirst,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'vendor_info'.tr,
//                                               style: robotoBold.copyWith(
//                                                 fontSize:
//                                                     Dimensions.fontSizeLarge,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height:
//                                                   Dimensions.paddingSizeDefault,
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color:
//                                                     Theme.of(context).cardColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   Dimensions.radiusDefault,
//                                                 ),
//                                                 boxShadow: const [
//                                                   BoxShadow(
//                                                     color: Colors.black12,
//                                                     blurRadius: 5,
//                                                     spreadRadius: 1,
//                                                   ),
//                                                 ],
//                                               ),
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     Dimensions.paddingSizeSmall,
//                                                 vertical: Dimensions
//                                                     .paddingSizeDefault,
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   SizedBox(
//                                                     height: 40,
//                                                     child: Align(
//                                                       alignment:
//                                                           Alignment.centerLeft,
//                                                       child: TabBar(
//                                                         tabAlignment:
//                                                             TabAlignment.start,
//                                                         controller:
//                                                             _tabController,
//                                                         indicatorColor:
//                                                             Theme.of(context)
//                                                                 .primaryColor,
//                                                         indicatorWeight: 3,
//                                                         labelColor:
//                                                             Theme.of(context)
//                                                                 .primaryColor,
//                                                         unselectedLabelColor:
//                                                             Theme.of(context)
//                                                                 .disabledColor,
//                                                         unselectedLabelStyle:
//                                                             robotoRegular
//                                                                 .copyWith(
//                                                           color: Theme.of(
//                                                             context,
//                                                           ).disabledColor,
//                                                           fontSize: Dimensions
//                                                               .fontSizeSmall,
//                                                         ),
//                                                         labelStyle:
//                                                             robotoBold.copyWith(
//                                                           fontSize: Dimensions
//                                                               .fontSizeDefault,
//                                                           color: Theme.of(
//                                                             context,
//                                                           ).primaryColor,
//                                                         ),
//                                                         labelPadding:
//                                                             const EdgeInsets
//                                                                 .only(
//                                                           right: Dimensions
//                                                               .radiusDefault,
//                                                         ),
//                                                         isScrollable: true,
//                                                         indicatorSize:
//                                                             TabBarIndicatorSize
//                                                                 .tab,
//                                                         tabs: _tabs,
//                                                         onTap: (int? value) {
//                                                           setState(() {});
//                                                         },
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const Padding(
//                                                     padding: EdgeInsets.only(
//                                                       bottom: Dimensions
//                                                           .paddingSizeLarge,
//                                                     ),
//                                                     child: Divider(height: 0),
//                                                   ),
//                                                   CustomTextField(
//                                                     key: _storeInfoScrollKey,
//                                                     titleText:
//                                                         'write_vendor_name'.tr,
//                                                     labelText: 'vendor_name'.tr,
//                                                     controller: _nameController[
//                                                         _tabController!.index],
//                                                     focusNode: _nameFocus[
//                                                         _tabController!.index],
//                                                     nextFocus: _tabController!
//                                                                 .index !=
//                                                             _languageList!
//                                                                     .length -
//                                                                 1
//                                                         ? _addressFocus[
//                                                             _tabController!
//                                                                 .index]
//                                                         : _addressFocus[0],
//                                                     inputType:
//                                                         TextInputType.name,
//                                                     prefixImage:
//                                                         Images.shopIcon,
//                                                     capitalization:
//                                                         TextCapitalization
//                                                             .words,
//                                                     required: true,
//                                                     validator: (value) =>
//                                                         ValidateCheck
//                                                             .validateEmptyText(
//                                                       value,
//                                                       "vendor_name_field_is_required"
//                                                           .tr,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: Dimensions
//                                                         .paddingSizeExtremeLarge,
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         flex: 4,
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   'vendor_logo'
//                                                                       .tr,
//                                                                   style: robotoRegular
//                                                                       .copyWith(
//                                                                     color: Theme
//                                                                             .of(
//                                                                       context,
//                                                                     )
//                                                                         .textTheme
//                                                                         .bodyLarge
//                                                                         ?.color
//                                                                         ?.withValues(
//                                                                           alpha:
//                                                                               0.7,
//                                                                         ),
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   ' (${'1:1'})',
//                                                                   style: robotoRegular
//                                                                       .copyWith(
//                                                                     color: Theme
//                                                                         .of(
//                                                                       context,
//                                                                     ).hintColor,
//                                                                     fontSize:
//                                                                         Dimensions
//                                                                             .fontSizeSmall,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             const SizedBox(
//                                                               height: Dimensions
//                                                                   .paddingSizeDefault,
//                                                             ),
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .center,
//                                                               child: Stack(
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .all(
//                                                                       5.0,
//                                                                     ),
//                                                                     child:
//                                                                         ClipRRect(
//                                                                       borderRadius:
//                                                                           BorderRadius
//                                                                               .circular(
//                                                                         Dimensions
//                                                                             .radiusSmall,
//                                                                       ),
//                                                                       child: storeController.pickedLogo !=
//                                                                               null
//                                                                           ? GetPlatform.isWeb
//                                                                               ? Image.network(
//                                                                                   storeController.pickedLogo!.path,
//                                                                                   width: 150,
//                                                                                   height: 120,
//                                                                                   fit: BoxFit.cover,
//                                                                                 )
//                                                                               : Image.file(
//                                                                                   File(storeController.pickedLogo!.path),
//                                                                                   width: 150,
//                                                                                   height: 120,
//                                                                                   fit: BoxFit.cover,
//                                                                                 )
//                                                                           : SizedBox(
//                                                                               width: 150,
//                                                                               height: 120,
//                                                                               child: Column(
//                                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                                 children: [
//                                                                                   Icon(CupertinoIcons.photo_camera_solid, size: 30, color: Theme.of(context).disabledColor.withValues(alpha: 0.6)),
//                                                                                   const SizedBox(height: Dimensions.paddingSizeSmall),
//                                                                                   Padding(
//                                                                                     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                                                                                     child: Text(
//                                                                                       'upload_vendor_logo'.tr,
//                                                                                       style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7)),
//                                                                                       textAlign: TextAlign.center,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                     ),
//                                                                   ),
//                                                                   Positioned(
//                                                                     bottom: 0,
//                                                                     right: 0,
//                                                                     top: 0,
//                                                                     left: 0,
//                                                                     child:
//                                                                         InkWell(
//                                                                       onTap: () =>
//                                                                           storeController
//                                                                               .pickImage(
//                                                                         true,
//                                                                         false,
//                                                                       ),
//                                                                       child:
//                                                                           DottedBorder(
//                                                                         color: Theme.of(context)
//                                                                             .primaryColor,
//                                                                         strokeWidth:
//                                                                             1,
//                                                                         strokeCap:
//                                                                             StrokeCap.butt,
//                                                                         dashPattern: const [
//                                                                           5,
//                                                                           5,
//                                                                         ],
//                                                                         padding:
//                                                                             const EdgeInsets.all(
//                                                                           0,
//                                                                         ),
//                                                                         borderType:
//                                                                             BorderType.RRect,
//                                                                         radius:
//                                                                             const Radius.circular(
//                                                                           Dimensions
//                                                                               .radiusDefault,
//                                                                         ),
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Visibility(
//                                                                             visible:
//                                                                                 storeController.pickedLogo != null,
//                                                                             child:
//                                                                                 Container(
//                                                                               padding: const EdgeInsets.all(25),
//                                                                               decoration: BoxDecoration(
//                                                                                 border: Border.all(width: 2, color: Colors.white),
//                                                                                 shape: BoxShape.circle,
//                                                                               ),
//                                                                               child: const Icon(CupertinoIcons.photo_camera_solid, color: Colors.white),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                         width: Dimensions
//                                                             .paddingSizeDefault,
//                                                       ),
//                                                       Expanded(
//                                                         flex: 6,
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   'vendor_cover'
//                                                                       .tr,
//                                                                   style: robotoRegular
//                                                                       .copyWith(
//                                                                     color: Theme
//                                                                             .of(
//                                                                       context,
//                                                                     )
//                                                                         .textTheme
//                                                                         .bodyLarge
//                                                                         ?.color
//                                                                         ?.withValues(
//                                                                           alpha:
//                                                                               0.7,
//                                                                         ),
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   ' (${'3:1'})',
//                                                                   style: robotoRegular
//                                                                       .copyWith(
//                                                                     color: Theme
//                                                                         .of(
//                                                                       context,
//                                                                     ).hintColor,
//                                                                     fontSize:
//                                                                         Dimensions
//                                                                             .fontSizeSmall,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             const SizedBox(
//                                                               height: Dimensions
//                                                                   .paddingSizeDefault,
//                                                             ),
//                                                             Stack(
//                                                               children: [
//                                                                 Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                           .all(
//                                                                     5.0,
//                                                                   ),
//                                                                   child:
//                                                                       ClipRRect(
//                                                                     borderRadius:
//                                                                         BorderRadius
//                                                                             .circular(
//                                                                       Dimensions
//                                                                           .radiusSmall,
//                                                                     ),
//                                                                     child: storeController.pickedCover !=
//                                                                             null
//                                                                         ? GetPlatform.isWeb
//                                                                             ? Image.network(
//                                                                                 storeController.pickedCover!.path,
//                                                                                 width: context.width,
//                                                                                 height: 120,
//                                                                                 fit: BoxFit.cover,
//                                                                               )
//                                                                             : Image.file(
//                                                                                 File(storeController.pickedCover!.path),
//                                                                                 width: context.width,
//                                                                                 height: 120,
//                                                                                 fit: BoxFit.cover,
//                                                                               )
//                                                                         : SizedBox(
//                                                                             width:
//                                                                                 context.width,
//                                                                             height:
//                                                                                 120,
//                                                                             child:
//                                                                                 Column(
//                                                                               mainAxisAlignment: MainAxisAlignment.center,
//                                                                               children: [
//                                                                                 Icon(CupertinoIcons.photo_camera_solid, size: 30, color: Theme.of(context).disabledColor.withValues(alpha: 0.6)),
//                                                                                 Text(
//                                                                                   'upload_vendor_cover'.tr,
//                                                                                   style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7)),
//                                                                                   textAlign: TextAlign.center,
//                                                                                 ),
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                                                                                   child: Text(
//                                                                                     'upload_jpg_png_gif_maximum_2_mb'.tr,
//                                                                                     style: robotoRegular.copyWith(color: Theme.of(context).disabledColor.withValues(alpha: 0.6), fontSize: Dimensions.fontSizeSmall),
//                                                                                     textAlign: TextAlign.center,
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                   ),
//                                                                 ),
//                                                                 Positioned(
//                                                                   bottom: 0,
//                                                                   right: 0,
//                                                                   top: 0,
//                                                                   left: 0,
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () =>
//                                                                         storeController
//                                                                             .pickImage(
//                                                                       false,
//                                                                       false,
//                                                                     ),
//                                                                     child:
//                                                                         DottedBorder(
//                                                                       color: Theme
//                                                                           .of(
//                                                                         context,
//                                                                       ).primaryColor,
//                                                                       strokeWidth:
//                                                                           1,
//                                                                       strokeCap:
//                                                                           StrokeCap
//                                                                               .butt,
//                                                                       dashPattern: const [
//                                                                         5,
//                                                                         5,
//                                                                       ],
//                                                                       padding:
//                                                                           const EdgeInsets
//                                                                               .all(
//                                                                         0,
//                                                                       ),
//                                                                       borderType:
//                                                                           BorderType
//                                                                               .RRect,
//                                                                       radius: const Radius
//                                                                           .circular(
//                                                                         Dimensions
//                                                                             .radiusDefault,
//                                                                       ),
//                                                                       child:
//                                                                           Center(
//                                                                         child:
//                                                                             Visibility(
//                                                                           visible:
//                                                                               storeController.pickedCover != null,
//                                                                           child:
//                                                                               Container(
//                                                                             padding:
//                                                                                 const EdgeInsets.all(25),
//                                                                             decoration:
//                                                                                 BoxDecoration(
//                                                                               border: Border.all(width: 3, color: Colors.white),
//                                                                               shape: BoxShape.circle,
//                                                                             ),
//                                                                             child:
//                                                                                 const Icon(
//                                                                               CupertinoIcons.photo_camera_solid,
//                                                                               color: Colors.white,
//                                                                               size: 50,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height:
//                                                   Dimensions.paddingSizeDefault,
//                                             ),
//                                             Text(
//                                               'location_info'.tr,
//                                               style: robotoBold.copyWith(
//                                                 fontSize:
//                                                     Dimensions.fontSizeLarge,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height:
//                                                   Dimensions.paddingSizeDefault,
//                                             ),
//                                             storeController.zoneList != null
//                                                 ? SelectLocationViewWidget(
//                                                     key: _locationInfoScrollKey,
//                                                     fromView: true,
//                                                     addressController:
//                                                         _addressController[0],
//                                                     addressFocus:
//                                                         _addressFocus[0],
//                                                   )
//                                                 : const Center(
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   ),
//                                             const SizedBox(
//                                               height:
//                                                   Dimensions.paddingSizeLarge,
//                                             ),
//                                             Text(
//                                               'vendor_preference'.tr,
//                                               style: robotoBold.copyWith(
//                                                 fontSize:
//                                                     Dimensions.fontSizeLarge,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height:
//                                                   Dimensions.paddingSizeDefault,
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color:
//                                                     Theme.of(context).cardColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   Dimensions.radiusDefault,
//                                                 ),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color:
//                                                         Colors.grey.withValues(
//                                                       alpha: 0.1,
//                                                     ),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 10,
//                                                     offset: const Offset(0, 1),
//                                                   ),
//                                                 ],
//                                               ),
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     Dimensions.paddingSizeSmall,
//                                                 vertical: Dimensions
//                                                     .paddingSizeDefault,
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   CustomTextField(
//                                                     key: _storePrefScrollKey,
//                                                     titleText:
//                                                         'write_vat_tax_amount'
//                                                             .tr,
//                                                     labelText: 'vat_tax'.tr,
//                                                     controller: _vatController,
//                                                     focusNode: _vatFocus,
//                                                     inputAction:
//                                                         TextInputAction.done,
//                                                     inputType:
//                                                         TextInputType.number,
//                                                     prefixImage:
//                                                         Images.vatTaxIcon,
//                                                     isAmount: true,
//                                                     suffixChild: CustomToolTip(
//                                                       message:
//                                                           'please_provide_vat_tax_amount'
//                                                               .tr,
//                                                       preferredDirection:
//                                                           AxisDirection.down,
//                                                       iconColor:
//                                                           Theme.of(context)
//                                                               .disabledColor,
//                                                     ),
//                                                     required: true,
//                                                     validator: (value) =>
//                                                         ValidateCheck
//                                                             .validateEmptyText(
//                                                       value,
//                                                       "vendor_vat_tax_field_is_required"
//                                                           .tr,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: Dimensions
//                                                         .paddingSizeExtremeLarge,
//                                                   ),
//                                                   InkWell(
//                                                     onTap: () {
//                                                       Get.dialog(
//                                                         const CustomTimePickerWidget(),
//                                                       );
//                                                     },
//                                                     child: Stack(
//                                                       clipBehavior: Clip.none,
//                                                       children: [
//                                                         Container(
//                                                           height: 50,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: Theme.of(
//                                                               context,
//                                                             ).cardColor,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                               Dimensions
//                                                                   .radiusDefault,
//                                                             ),
//                                                             border: Border.all(
//                                                               color: Theme.of(
//                                                                 context,
//                                                               ).disabledColor,
//                                                               width: 0.5,
//                                                             ),
//                                                           ),
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                             horizontal: Dimensions
//                                                                 .paddingSizeLarge,
//                                                           ),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 child: Text(
//                                                                   '${storeController.storeMinTime} : ${storeController.storeMaxTime} ${storeController.storeTimeUnit}',
//                                                                   style:
//                                                                       robotoMedium,
//                                                                 ),
//                                                               ),
//                                                               Icon(
//                                                                 Icons
//                                                                     .access_time_filled,
//                                                                 color: Theme.of(
//                                                                   context,
//                                                                 ).primaryColor,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           left: 10,
//                                                           top: -15,
//                                                           child: Container(
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               color: Theme.of(
//                                                                 context,
//                                                               ).cardColor,
//                                                             ),
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(5),
//                                                             child: Text(
//                                                               'select_time'.tr,
//                                                               style:
//                                                                   robotoRegular
//                                                                       .copyWith(
//                                                                 color: Theme.of(
//                                                                   context,
//                                                                 ).disabledColor,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Visibility(
//                                       visible:
//                                           storeController.storeStatus == 0.6,
//                                       child: Form(
//                                         key: _formKeySecond,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   'owner_info'.tr,
//                                                   style: robotoBold.copyWith(
//                                                     fontSize: Dimensions
//                                                         .fontSizeLarge,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: Dimensions
//                                                       .paddingSizeSmall,
//                                                 ),
//                                                 CustomToolTip(
//                                                   message:
//                                                       'this_info_will_need_for_vendor_app_and_panel_login'
//                                                           .tr,
//                                                   preferredDirection:
//                                                       AxisDirection.down,
//                                                   iconColor: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyLarge!
//                                                       .color
//                                                       ?.withValues(alpha: 0.7),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height:
//                                                   Dimensions.paddingSizeDefault,
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color:
//                                                     Theme.of(context).cardColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   Dimensions.radiusDefault,
//                                                 ),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color:
//                                                         Colors.grey.withValues(
//                                                       alpha: 0.1,
//                                                     ),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 10,
//                                                     offset: const Offset(0, 1),
//                                                   ),
//                                                 ],
//                                               ),
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     Dimensions.paddingSizeSmall,
//                                                 vertical: Dimensions
//                                                     .paddingSizeDefault,
//                                               ),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   CustomTextField(
//                                                     titleText:
//                                                         'write_first_name'.tr,
//                                                     controller:
//                                                         _fNameController,
//                                                     focusNode: _fNameFocus,
//                                                     nextFocus: _lNameFocus,
//                                                     inputType:
//                                                         TextInputType.name,
//                                                     capitalization:
//                                                         TextCapitalization
//                                                             .words,
//                                                     prefixIcon: CupertinoIcons
//                                                         .person_crop_circle_fill,
//                                                     iconSize: 25,
//                                                     required: true,
//                                                     labelText: 'first_name'.tr,
//                                                     validator: (value) =>
//                                                         ValidateCheck
//                                                             .validateEmptyText(
//                                                       value,
//                                                       "first_name_field_is_required"
//                                                           .tr,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: Dimensions
//                                                         .paddingSizeExtremeLarge,
//                                                   ),

//                                                   CustomTextField(
//                                                     titleText:
//                                                         'write_last_name'.tr,
//                                                     controller:
//                                                         _lNameController,
//                                                     focusNode: _lNameFocus,
//                                                     nextFocus: _phoneFocus,
//                                                     prefixIcon: CupertinoIcons
//                                                         .person_crop_circle_fill,
//                                                     iconSize: 25,
//                                                     inputType:
//                                                         TextInputType.name,
//                                                     capitalization:
//                                                         TextCapitalization
//                                                             .words,
//                                                     required: true,
//                                                     labelText: 'last_name'.tr,
//                                                     validator: (value) =>
//                                                         ValidateCheck
//                                                             .validateEmptyText(
//                                                       value,
//                                                       "last_name_field_is_required"
//                                                           .tr,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: Dimensions
//                                                         .paddingSizeExtremeLarge,
//                                                   ),

//                                                   CustomTextField(
//                                                     titleText:
//                                                         'enter_phone_number'.tr,
//                                                     controller:
//                                                         _phoneController,
//                                                     focusNode: _phoneFocus,
//                                                     nextFocus: _emailFocus,
//                                                     inputType:
//                                                         TextInputType.phone,
//                                                     isPhone: true,
//                                                     showTitle: ResponsiveHelper
//                                                         .isDesktop(context),
//                                                     onCountryChanged: (
//                                                       CountryCode countryCode,
//                                                     ) {
//                                                       _countryDialCode =
//                                                           countryCode.dialCode;
//                                                     },
//                                                     countryDialCode:
//                                                         _countryDialCode != null
//                                                             ? CountryCode
//                                                                 .fromCountryCode(
//                                                                 Get.find<
//                                                                         SplashController>()
//                                                                     .configModel!
//                                                                     .country!,
//                                                               ).code
//                                                             : Get.find<
//                                                                     LocalizationController>()
//                                                                 .locale
//                                                                 .countryCode,
//                                                     required: true,
//                                                     labelText: 'phone'.tr,
//                                                     validator: (value) =>
//                                                         ValidateCheck
//                                                             .validateEmptyText(
//                                                       value,
//                                                       null,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: Dimensions
//                                                         .paddingSizeExtremeLarge,
//                                                   ),

//                                                   CustomTextField(
//                                                     titleText: 'write_email'.tr,
//                                                     controller:
//                                                         _emailController,
//                                                     focusNode: _emailFocus,
//                                                     nextFocus: _passwordFocus,
//                                                     inputType: TextInputType
//                                                         .emailAddress,
//                                                     prefixIcon: Icons.email,
//                                                     iconSize: 25,
//                                                     required: true,
//                                                     labelText: 'email'.tr,
//                                                     validator: ValidateCheck
//                                                         .validateEmail,
//                                                   ),
//                                                   const SizedBox(
//                                                     height: Dimensions
//                                                         .paddingSizeExtremeLarge,
//                                                   ),

//                                                   GetBuilder<
//                                                       StoreRegistrationController>(
//                                                     builder:
//                                                         (storeController) {
//                                                       return Column(
//                                                         children: [
//                                                           CustomTextField(
//                                                             titleText:
//                                                                 '8+characters'
//                                                                     .tr,
//                                                             controller:
//                                                                 _passwordController,
//                                                             focusNode:
//                                                                 _passwordFocus,
//                                                             nextFocus:
//                                                                 _confirmPasswordFocus,
//                                                             inputType: TextInputType
//                                                                 .visiblePassword,
//                                                             prefixIcon:
//                                                                 Icons.lock,
//                                                             iconSize: 25,
//                                                             isPassword: true,
//                                                             onChanged: (value) {
//                                                               if (value !=
//                                                                       null &&
//                                                                   value
//                                                                       .isNotEmpty) {
//                                                                 if (!storeController
//                                                                     .showPassView) {
//                                                                   storeController
//                                                                       .showHidePass();
//                                                                 }
//                                                                 storeController
//                                                                     .validPassCheck(
//                                                                   value,
//                                                                 );
//                                                               } else {
//                                                                 if (storeController
//                                                                     .showPassView) {
//                                                                   storeController
//                                                                       .showHidePass();
//                                                                 }
//                                                               }
//                                                             },
//                                                             required: true,
//                                                             labelText:
//                                                                 'password'.tr,
//                                                             validator: (value) =>
//                                                                 ValidateCheck
//                                                                     .validateEmptyText(
//                                                               value,
//                                                               "password_field_is_required"
//                                                                   .tr,
//                                                             ),
//                                                           ),
//                                                           storeController
//                                                                   .showPassView
//                                                               ? const PassViewWidget()
//                                                               : const SizedBox(),
//                                                         ],
//                                                       );
//                                                     },
//                                                   ),

//                                                   const SizedBox(
//                                                     height: Dimensions
//                                                         .paddingSizeExtremeLarge,
//                                                   ),

//                                                   CustomTextField(
//                                                     titleText:
//                                                         '8+characters'.tr,
//                                                     controller:
//                                                         _confirmPasswordController,
//                                                     focusNode:
//                                                         _confirmPasswordFocus,
//                                                     inputType: TextInputType
//                                                         .visiblePassword,
//                                                     inputAction:
//                                                         TextInputAction.done,
//                                                     prefixIcon: Icons.lock,
//                                                     iconSize: 25,
//                                                     isPassword: true,
//                                                     required: true,
//                                                     labelText:
//                                                         'confirm_password'.tr,
//                                                     validator: (value) =>
//                                                         ValidateCheck
//                                                             .validateEmptyText(
//                                                       value,
//                                                       "password_field_is_required"
//                                                           .tr,
//                                                     ),
//                                                   ),
//                                                   // const SizedBox(height: Dimensions.paddingSizeExtraLarge),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Visibility(
//                                       visible:
//                                           storeController.storeStatus == 0.9,
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                               top: Dimensions.paddingSizeLarge,
//                                               bottom: Dimensions
//                                                   .paddingSizeExtremeLarge,
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 'choose_your_business_plan'.tr,
//                                                 style: robotoBold,
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                               horizontal:
//                                                   Dimensions.paddingSizeLarge,
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 Get.find<SplashController>()
//                                                             .configModel!
//                                                             .commissionBusinessModel !=
//                                                         0
//                                                     ? Expanded(
//                                                         child: BaseCardWidget(
//                                                           storeRegistrationController:
//                                                               storeController,
//                                                           title:
//                                                               'commission_base'
//                                                                   .tr,
//                                                           index: 0,
//                                                           onTap: () =>
//                                                               storeController
//                                                                   .setBusiness(
//                                                             0,
//                                                           ),
//                                                         ),
//                                                       )
//                                                     : const SizedBox(),
//                                                 SizedBox(
//                                                   width: Get.find<SplashController>()
//                                                               .configModel!
//                                                               .commissionBusinessModel !=
//                                                           0
//                                                       ? Dimensions
//                                                           .paddingSizeDefault
//                                                       : 0,
//                                                 ),
//                                                 Get.find<SplashController>()
//                                                             .configModel!
//                                                             .subscriptionBusinessModel !=
//                                                         0
//                                                     ? Expanded(
//                                                         child: BaseCardWidget(
//                                                           storeRegistrationController:
//                                                               storeController,
//                                                           title:
//                                                               'subscription_base'
//                                                                   .tr,
//                                                           index: 1,
//                                                           onTap: () =>
//                                                               storeController
//                                                                   .setBusiness(
//                                                             1,
//                                                           ),
//                                                         ),
//                                                       )
//                                                     : const SizedBox(),
//                                               ],
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: Dimensions
//                                                 .paddingSizeExtraLarge,
//                                           ),
//                                           storeController.businessIndex == 0
//                                               ? Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                     horizontal: Dimensions
//                                                         .paddingSizeLarge,
//                                                   ),
//                                                   child: Text(
//                                                     "${'vendor_will_pay'.tr} ${Get.find<SplashController>().configModel!.adminCommission}% ${'commission_to'.tr} ${Get.find<SplashController>().configModel!.businessName} ${'from_each_order_You_will_get_access_of_all'.tr}",
//                                                     style:
//                                                         robotoRegular.copyWith(
//                                                       fontSize: Dimensions
//                                                           .fontSizeSmall,
//                                                       color: Theme.of(
//                                                         context,
//                                                       )
//                                                           .textTheme
//                                                           .bodyLarge
//                                                           ?.color
//                                                           ?.withValues(
//                                                             alpha: 0.7,
//                                                           ),
//                                                     ),
//                                                     textAlign:
//                                                         TextAlign.justify,
//                                                     textScaler:
//                                                         const TextScaler.linear(
//                                                       1.1,
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Column(
//                                                   children: [
//                                                     Padding(
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                         horizontal: Dimensions
//                                                             .paddingSizeLarge,
//                                                       ),
//                                                       child: Text(
//                                                         'run_vendor_by_purchasing_subscription_packages'
//                                                             .tr,
//                                                         style: robotoRegular
//                                                             .copyWith(
//                                                           fontSize: Dimensions
//                                                               .fontSizeSmall,
//                                                           color: Theme.of(
//                                                             context,
//                                                           )
//                                                               .textTheme
//                                                               .bodyLarge
//                                                               ?.color
//                                                               ?.withValues(
//                                                                 alpha: 0.7,
//                                                               ),
//                                                         ),
//                                                         textAlign:
//                                                             TextAlign.justify,
//                                                         textScaler:
//                                                             const TextScaler
//                                                                 .linear(1.1),
//                                                       ),
//                                                     ),
//                                                     const SizedBox(
//                                                       height: Dimensions
//                                                           .paddingSizeLarge,
//                                                     ),
//                                                     storeController
//                                                                 .packageModel !=
//                                                             null
//                                                         ? SizedBox(
//                                                             height: 420,
//                                                             child: storeController
//                                                                     .packageModel!
//                                                                     .packages!
//                                                                     .isNotEmpty
//                                                                 ? Swiper(
//                                                                     itemCount: storeController
//                                                                         .packageModel!
//                                                                         .packages!
//                                                                         .length,
//                                                                     viewportFraction:
//                                                                         0.60,
//                                                                     itemBuilder:
//                                                                         (
//                                                                       context,
//                                                                       index,
//                                                                     ) {
//                                                                       return PackageCardWidget(
//                                                                         canSelect:
//                                                                             storeController.activeSubscriptionIndex ==
//                                                                                 index,
//                                                                         packages: storeController
//                                                                             .packageModel!
//                                                                             .packages![index],
//                                                                       );
//                                                                     },
//                                                                     onIndexChanged:
//                                                                         (index) {
//                                                                       storeController
//                                                                           .selectSubscriptionCard(
//                                                                         index,
//                                                                       );
//                                                                     },
//                                                                   )
//                                                                 : Center(
//                                                                     child:
//                                                                         Column(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .center,
//                                                                       children: [
//                                                                         Image
//                                                                             .asset(
//                                                                           Images
//                                                                               .emptyBox,
//                                                                           height:
//                                                                               150,
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           height:
//                                                                               Dimensions.paddingSizeLarge,
//                                                                         ),
//                                                                         Text(
//                                                                           'no_package_available'
//                                                                               .tr,
//                                                                           style:
//                                                                               robotoMedium,
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                           )
//                                                         : const CircularProgressIndicator(),
//                                                   ],
//                                                 ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: Dimensions.paddingSizeLarge,
//                                     ),
//                                   ],
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   (ResponsiveHelper.isDesktop(context))
//                       ? const SizedBox()
//                       : buttonView(),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget webView(StoreRegistrationController storeController) {
//     return Column(
//       children: [
//         storeController.storeStatus != 0.9
//             ? Column(
//                 children: [
//                   Row(
//                     children: [
//                       CustomAssetImageWidget(
//                         Images.shopIcon,
//                         height: 20,
//                         width: 20,
//                         color: Theme.of(context).textTheme.bodyLarge!.color,
//                       ),
//                       const SizedBox(width: Dimensions.paddingSizeSmall),
//                       Text(
//                         'vendor_information'.tr,
//                         style: robotoMedium.copyWith(
//                           fontSize: Dimensions.fontSizeDefault,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeSmall),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius:
//                           BorderRadius.circular(Dimensions.radiusDefault),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     padding:
//                         const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                     margin: const EdgeInsets.symmetric(
//                       vertical: Dimensions.paddingSizeSmall,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               height: 40,
//                               width: 500,
//                               color: Colors.transparent,
//                               child: TabBar(
//                                 tabAlignment: TabAlignment.start,
//                                 controller: _tabController,
//                                 indicatorColor: Theme.of(context).primaryColor,
//                                 indicatorWeight: 3,
//                                 labelColor: Theme.of(context).primaryColor,
//                                 unselectedLabelColor:
//                                     Theme.of(context).disabledColor,
//                                 unselectedLabelStyle: robotoRegular.copyWith(
//                                   color: Theme.of(context).disabledColor,
//                                   fontSize: Dimensions.fontSizeSmall,
//                                 ),
//                                 labelStyle: robotoBold.copyWith(
//                                   fontSize: Dimensions.fontSizeSmall,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                                 labelPadding: const EdgeInsets.symmetric(
//                                   horizontal: Dimensions.radiusDefault,
//                                   vertical: 0,
//                                 ),
//                                 isScrollable: true,
//                                 indicatorSize: TabBarIndicatorSize.tab,
//                                 tabs: _tabs,
//                                 onTap: (int? value) {
//                                   setState(() {});
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: Dimensions.paddingSizeSmall),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   const SizedBox(
//                                     height: Dimensions.paddingSizeSmall,
//                                   ),
//                                   CustomTextField(
//                                     titleText: 'write_vendor_name'.tr,
//                                     labelText: 'vendor_name'.tr,
//                                     controller:
//                                         _nameController[_tabController!.index],
//                                     focusNode:
//                                         _nameFocus[_tabController!.index],
//                                     nextFocus: _tabController!.index !=
//                                             _languageList!.length - 1
//                                         ? _addressFocus[_tabController!.index]
//                                         : _addressFocus[0],
//                                     inputType: TextInputType.name,
//                                     prefixImage: Images.shopIcon,
//                                     capitalization: TextCapitalization.words,
//                                     required: true,
//                                     validator: (value) =>
//                                         ValidateCheck.validateEmptyText(
//                                       value,
//                                       "vendor_name_field_is_required".tr,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height:
//                                         Dimensions.paddingSizeExtraOverLarge,
//                                   ),
//                                   const ModuleViewWidget(),
//                                   const SizedBox(
//                                     height:
//                                         Dimensions.paddingSizeExtraOverLarge,
//                                   ),
//                                   CustomTextField(
//                                     titleText: 'write_vendor_address'.tr,
//                                     labelText: 'address'.tr,
//                                     controller: _addressController[0],
//                                     focusNode: _addressFocus[0],
//                                     inputAction: TextInputAction.done,
//                                     inputType: TextInputType.text,
//                                     capitalization:
//                                         TextCapitalization.sentences,
//                                     maxLines: 3,
//                                     required: true,
//                                     validator: (value) =>
//                                         ValidateCheck.validateEmptyText(
//                                       value,
//                                       "vendor_address_field_is_required".tr,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: Dimensions.paddingSizeSmall),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   const SizedBox(
//                                     height: Dimensions.paddingSizeSmall,
//                                   ),
//                                   storeController.zoneList != null
//                                       ? const SelectLocationViewWidget(
//                                           fromView: true,
//                                           mapView: true,
//                                         )
//                                       : const Center(
//                                           child: CircularProgressIndicator(),
//                                         ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeDefault),
//                   Row(
//                     children: [
//                       const Icon(Icons.person),
//                       const SizedBox(width: Dimensions.paddingSizeSmall),
//                       Text(
//                         'general_information'.tr,
//                         style: robotoMedium.copyWith(
//                           fontSize: Dimensions.fontSizeDefault,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeSmall),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius:
//                           BorderRadius.circular(Dimensions.radiusDefault),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: Dimensions.paddingSizeDefault,
//                       vertical: Dimensions.paddingSizeLarge,
//                     ),
//                     margin: const EdgeInsets.symmetric(
//                       vertical: Dimensions.paddingSizeSmall,
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   CustomTextField(
//                                     titleText: 'write_vat_tax_amount'.tr,
//                                     labelText: 'vat_tax'.tr,
//                                     controller: _vatController,
//                                     focusNode: _vatFocus,
//                                     inputAction: TextInputAction.done,
//                                     inputType: TextInputType.number,
//                                     prefixImage: Images.vatTaxIcon,
//                                     isAmount: true,
//                                     suffixChild: CustomToolTip(
//                                       message:
//                                           'please_provide_vat_tax_amount'.tr,
//                                       preferredDirection: AxisDirection.down,
//                                       iconColor:
//                                           Theme.of(context).disabledColor,
//                                     ),
//                                     required: true,
//                                     validator: (value) =>
//                                         ValidateCheck.validateEmptyText(
//                                       value,
//                                       "vendor_vat_tax_field_is_required".tr,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height:
//                                         Dimensions.paddingSizeExtraOverLarge,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       Get.dialog(
//                                         const CustomTimePickerWidget(),
//                                       );
//                                     },
//                                     child: Stack(
//                                       clipBehavior: Clip.none,
//                                       children: [
//                                         Container(
//                                           height: 50,
//                                           decoration: BoxDecoration(
//                                             color: Theme.of(context).cardColor,
//                                             borderRadius: BorderRadius.circular(
//                                               Dimensions.radiusDefault,
//                                             ),
//                                             border: Border.all(
//                                               color: Theme.of(context)
//                                                   .disabledColor,
//                                               width: 0.5,
//                                             ),
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal:
//                                                 Dimensions.paddingSizeLarge,
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   '${storeController.storeMinTime} : ${storeController.storeMaxTime} ${storeController.storeTimeUnit}',
//                                                   style: robotoMedium,
//                                                 ),
//                                               ),
//                                               Icon(
//                                                 Icons.access_time_filled,
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Positioned(
//                                           left: 10,
//                                           top: -15,
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   Theme.of(context).cardColor,
//                                             ),
//                                             padding: const EdgeInsets.all(5),
//                                             child: Text(
//                                               'select_time'.tr,
//                                               style: robotoRegular.copyWith(
//                                                 color: Theme.of(context)
//                                                     .disabledColor,
//                                                 fontSize: Dimensions
//                                                     .fontSizeExtraSmall,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 4,
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Stack(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 Dimensions.radiusSmall,
//                                               ),
//                                               child: storeController
//                                                           .pickedLogo !=
//                                                       null
//                                                   ? GetPlatform.isWeb
//                                                       ? Image.network(
//                                                           storeController
//                                                               .pickedLogo!.path,
//                                                           width: 150,
//                                                           height: 120,
//                                                           fit: BoxFit.cover,
//                                                         )
//                                                       : Image.file(
//                                                           File(
//                                                             storeController
//                                                                 .pickedLogo!
//                                                                 .path,
//                                                           ),
//                                                           width: 150,
//                                                           height: 120,
//                                                           fit: BoxFit.cover,
//                                                         )
//                                                   : SizedBox(
//                                                       width: 150,
//                                                       height: 120,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Icon(
//                                                             CupertinoIcons
//                                                                 .photo_camera_solid,
//                                                             size: 30,
//                                                             color: Theme.of(
//                                                               context,
//                                                             )
//                                                                 .disabledColor
//                                                                 .withValues(
//                                                                   alpha: 0.6,
//                                                                 ),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: Dimensions
//                                                                 .paddingSizeSmall,
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                               horizontal: Dimensions
//                                                                   .paddingSizeSmall,
//                                                             ),
//                                                             child: Text(
//                                                               '${'upload_vendor_logo'.tr} (${'1:1'})',
//                                                               style:
//                                                                   robotoRegular
//                                                                       .copyWith(
//                                                                 fontSize: Dimensions
//                                                                     .fontSizeExtraSmall,
//                                                                 color: Theme.of(
//                                                                   context,
//                                                                 )
//                                                                     .textTheme
//                                                                     .bodyLarge
//                                                                     ?.color
//                                                                     ?.withValues(
//                                                                       alpha:
//                                                                           0.7,
//                                                                     ),
//                                                               ),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .center,
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                               horizontal: Dimensions
//                                                                   .paddingSizeSmall,
//                                                             ),
//                                                             child: Text(
//                                                               'upload_jpg_png_gif_maximum_2_mb'
//                                                                   .tr,
//                                                               style:
//                                                                   robotoRegular
//                                                                       .copyWith(
//                                                                 color: Theme.of(
//                                                                   context,
//                                                                 )
//                                                                     .disabledColor
//                                                                     .withValues(
//                                                                       alpha:
//                                                                           0.6,
//                                                                     ),
//                                                                 fontSize: Dimensions
//                                                                     .fontSizeOverSmall,
//                                                               ),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .center,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             bottom: 0,
//                                             right: 0,
//                                             top: 0,
//                                             left: 0,
//                                             child: InkWell(
//                                               onTap: () => storeController
//                                                   .pickImage(true, false),
//                                               child: DottedBorder(
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                                 strokeWidth: 1,
//                                                 strokeCap: StrokeCap.butt,
//                                                 dashPattern: const [5, 5],
//                                                 padding:
//                                                     const EdgeInsets.all(0),
//                                                 borderType: BorderType.RRect,
//                                                 radius: const Radius.circular(
//                                                   Dimensions.radiusDefault,
//                                                 ),
//                                                 child: Center(
//                                                   child: Visibility(
//                                                     visible: storeController
//                                                             .pickedLogo !=
//                                                         null,
//                                                     child: Container(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                         25,
//                                                       ),
//                                                       decoration: BoxDecoration(
//                                                         border: Border.all(
//                                                           width: 2,
//                                                           color: Colors.white,
//                                                         ),
//                                                         shape: BoxShape.circle,
//                                                       ),
//                                                       child: const Icon(
//                                                         CupertinoIcons
//                                                             .photo_camera_solid,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   //const SizedBox(width: Dimensions.paddingSizeDefault),

//                                   Expanded(
//                                     flex: 6,
//                                     child: Stack(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(5.0),
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(
//                                               Dimensions.radiusSmall,
//                                             ),
//                                             child: storeController
//                                                         .pickedCover !=
//                                                     null
//                                                 ? GetPlatform.isWeb
//                                                     ? Image.network(
//                                                         storeController
//                                                             .pickedCover!.path,
//                                                         width: context.width,
//                                                         height: 120,
//                                                         fit: BoxFit.cover,
//                                                       )
//                                                     : Image.file(
//                                                         File(
//                                                           storeController
//                                                               .pickedCover!
//                                                               .path,
//                                                         ),
//                                                         width: context.width,
//                                                         height: 120,
//                                                         fit: BoxFit.cover,
//                                                       )
//                                                 : SizedBox(
//                                                     width: context.width,
//                                                     height: 120,
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Icon(
//                                                           CupertinoIcons
//                                                               .photo_camera_solid,
//                                                           size: 30,
//                                                           color: Theme.of(
//                                                             context,
//                                                           )
//                                                               .disabledColor
//                                                               .withValues(
//                                                                 alpha: 0.6,
//                                                               ),
//                                                         ),
//                                                         Text(
//                                                           '${'upload_vendor_cover'.tr} (${'3:1'})',
//                                                           style: robotoRegular
//                                                               .copyWith(
//                                                             color: Theme.of(
//                                                               context,
//                                                             )
//                                                                 .textTheme
//                                                                 .bodyLarge
//                                                                 ?.color
//                                                                 ?.withValues(
//                                                                   alpha: 0.7,
//                                                                 ),
//                                                             fontSize: Dimensions
//                                                                 .fontSizeExtraSmall,
//                                                           ),
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                             horizontal: Dimensions
//                                                                 .paddingSizeSmall,
//                                                           ),
//                                                           child: Text(
//                                                             'upload_jpg_png_gif_maximum_2_mb'
//                                                                 .tr,
//                                                             style: robotoRegular
//                                                                 .copyWith(
//                                                               color: Theme.of(
//                                                                 context,
//                                                               )
//                                                                   .disabledColor
//                                                                   .withValues(
//                                                                     alpha: 0.6,
//                                                                   ),
//                                                               fontSize: Dimensions
//                                                                   .fontSizeOverSmall,
//                                                             ),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                           ),
//                                         ),
//                                         Positioned(
//                                           bottom: 0,
//                                           right: 0,
//                                           top: 0,
//                                           left: 0,
//                                           child: InkWell(
//                                             onTap: () => storeController
//                                                 .pickImage(false, false),
//                                             child: DottedBorder(
//                                               color: Theme.of(context)
//                                                   .primaryColor,
//                                               strokeWidth: 1,
//                                               strokeCap: StrokeCap.butt,
//                                               dashPattern: const [5, 5],
//                                               padding: const EdgeInsets.all(0),
//                                               borderType: BorderType.RRect,
//                                               radius: const Radius.circular(
//                                                 Dimensions.radiusDefault,
//                                               ),
//                                               child: Center(
//                                                 child: Visibility(
//                                                   visible: storeController
//                                                           .pickedCover !=
//                                                       null,
//                                                   child: Container(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                       25,
//                                                     ),
//                                                     decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                         width: 3,
//                                                         color: Colors.white,
//                                                       ),
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     child: const Icon(
//                                                       CupertinoIcons
//                                                           .photo_camera_solid,
//                                                       color: Colors.white,
//                                                       size: 50,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeDefault),
//                   Form(
//                     key: _formKeySecond,
//                     child: Row(
//                       children: [
//                         const Icon(Icons.person),
//                         const SizedBox(width: Dimensions.paddingSizeSmall),
//                         Text(
//                           'owner_information'.tr,
//                           style: robotoMedium.copyWith(
//                             fontSize: Dimensions.fontSizeDefault,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeSmall),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius:
//                           BorderRadius.circular(Dimensions.radiusDefault),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     padding:
//                         const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                     margin: const EdgeInsets.symmetric(
//                       vertical: Dimensions.paddingSizeSmall,
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: CustomTextField(
//                                 titleText: 'write_first_name'.tr,
//                                 controller: _fNameController,
//                                 focusNode: _fNameFocus,
//                                 nextFocus: _lNameFocus,
//                                 inputType: TextInputType.name,
//                                 capitalization: TextCapitalization.words,
//                                 prefixIcon:
//                                     CupertinoIcons.person_crop_circle_fill,
//                                 iconSize: 25,
//                                 required: true,
//                                 labelText: 'first_name'.tr,
//                                 validator: (value) =>
//                                     ValidateCheck.validateEmptyText(
//                                   value,
//                                   "first_name_field_is_required".tr,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeLarge),
//                             Expanded(
//                               child: CustomTextField(
//                                 titleText: 'write_last_name'.tr,
//                                 controller: _lNameController,
//                                 focusNode: _lNameFocus,
//                                 nextFocus: _phoneFocus,
//                                 prefixIcon:
//                                     CupertinoIcons.person_crop_circle_fill,
//                                 iconSize: 25,
//                                 inputType: TextInputType.name,
//                                 capitalization: TextCapitalization.words,
//                                 required: true,
//                                 labelText: 'last_name'.tr,
//                                 validator: (value) =>
//                                     ValidateCheck.validateEmptyText(
//                                   value,
//                                   "last_name_field_is_required".tr,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeLarge),
//                             Expanded(
//                               child: CustomTextField(
//                                 titleText: 'enter_phone_number'.tr,
//                                 controller: _phoneController,
//                                 focusNode: _phoneFocus,
//                                 nextFocus: _emailFocus,
//                                 inputType: TextInputType.phone,
//                                 isPhone: true,
//                                 onCountryChanged: (CountryCode countryCode) {
//                                   _countryDialCode = countryCode.dialCode;
//                                 },
//                                 countryDialCode: _countryDialCode != null
//                                     ? CountryCode.fromCountryCode(
//                                         Get.find<SplashController>()
//                                             .configModel!
//                                             .country!,
//                                       ).code
//                                     : Get.find<LocalizationController>()
//                                         .locale
//                                         .countryCode,
//                                 required: true,
//                                 labelText: 'phone'.tr,
//                                 validator: (value) =>
//                                     ValidateCheck.validateEmptyText(
//                                   value,
//                                   null,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: Dimensions.paddingSizeLarge),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeDefault),
//                   Row(
//                     children: [
//                       const Icon(Icons.lock),
//                       const SizedBox(width: Dimensions.paddingSizeSmall),
//                       Text(
//                         'login_info'.tr,
//                         style: robotoMedium.copyWith(
//                           fontSize: Dimensions.fontSizeDefault,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeSmall),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius:
//                           BorderRadius.circular(Dimensions.radiusDefault),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     padding:
//                         const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                     margin: const EdgeInsets.symmetric(
//                       vertical: Dimensions.paddingSizeSmall,
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: CustomTextField(
//                                 titleText: 'write_email'.tr,
//                                 controller: _emailController,
//                                 focusNode: _emailFocus,
//                                 nextFocus: _passwordFocus,
//                                 inputType: TextInputType.emailAddress,
//                                 prefixIcon: Icons.email,
//                                 iconSize: 25,
//                                 required: true,
//                                 labelText: 'email'.tr,
//                                 validator: ValidateCheck.validateEmail,
//                               ),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeLarge),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   CustomTextField(
//                                     titleText: '8+characters'.tr,
//                                     controller: _passwordController,
//                                     focusNode: _passwordFocus,
//                                     nextFocus: _confirmPasswordFocus,
//                                     inputType: TextInputType.visiblePassword,
//                                     prefixIcon: Icons.lock,
//                                     iconSize: 25,
//                                     isPassword: true,
//                                     onChanged: (value) {
//                                       if (value != null && value.isNotEmpty) {
//                                         if (!storeController.showPassView) {
//                                           storeController.showHidePass();
//                                         }
//                                         storeController
//                                             .validPassCheck(value);
//                                       } else {
//                                         if (storeController.showPassView) {
//                                           storeController.showHidePass();
//                                         }
//                                       }
//                                     },
//                                     required: true,
//                                     labelText: 'password'.tr,
//                                     validator: (value) =>
//                                         ValidateCheck.validateEmptyText(
//                                       value,
//                                       "password_field_is_required".tr,
//                                     ),
//                                   ),
//                                   storeController.showPassView
//                                       ? const PassViewWidget()
//                                       : const SizedBox(),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeLarge),
//                             Expanded(
//                               child: CustomTextField(
//                                 titleText: '8+characters'.tr,
//                                 controller: _confirmPasswordController,
//                                 focusNode: _confirmPasswordFocus,
//                                 inputType: TextInputType.visiblePassword,
//                                 inputAction: TextInputAction.done,
//                                 prefixIcon: Icons.lock,
//                                 iconSize: 25,
//                                 isPassword: true,
//                                 required: true,
//                                 labelText: 'confirm_password'.tr,
//                                 validator: (value) =>
//                                     ValidateCheck.validateEmptyText(
//                                   value,
//                                   "password_field_is_required".tr,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: Dimensions.paddingSizeLarge),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             : const SizedBox(),
//         storeController.storeStatus == 0.9
//             ? const WebBusinessPlanWidget()
//             : const SizedBox(),
//         const SizedBox(height: 40),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                 border: Border.all(
//                   color: Theme.of(context).disabledColor.withValues(alpha: 0.3),
//                 ),
//               ),
//               width: 165,
//               child: CustomButton(
//                 transparent: true,
//                 textColor: Theme.of(context).disabledColor,
//                 radius: Dimensions.radiusSmall,
//                 onPressed: () {
//                   _phoneController.text = '';
//                   _emailController.text = '';
//                   _fNameController.text = '';
//                   _lNameController.text = '';
//                   _lNameController.text = '';
//                   _vatController.text = '';
//                   _passwordController.text = '';
//                   _confirmPasswordController.text = '';
//                   for (int i = 0; i < _nameController.length; i++) {
//                     _nameController[i].text = '';
//                   }
//                   for (int i = 0; i < _addressController.length; i++) {
//                     _addressController[i].text = '';
//                   }
//                   storeController.resetStoreRegistration();

//                   //profileController.initData(isUpdate: true);
//                 },
//                 buttonText: 'reset'.tr,
//                 isBold: false,
//                 fontSize: Dimensions.fontSizeSmall,
//               ),
//             ),
//             const SizedBox(width: Dimensions.paddingSizeLarge),
//             SizedBox(width: 165, child: buttonView()),
//           ],
//         ),
//         const SizedBox(height: 30),
//       ],
//     );
//   }

//   Widget buttonView() {
//     return GetBuilder<StoreRegistrationController>(
//       builder: (storeController) {
//         return Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: ResponsiveHelper.isDesktop(context)
//                 ? 0
//                 : Dimensions.paddingSizeDefault,
//           ),
//           decoration: ResponsiveHelper.isDesktop(context)
//               ? null
//               : BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 5,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                 ),
//           child: CustomButton(
//             fontSize: ResponsiveHelper.isDesktop(context)
//                 ? Dimensions.fontSizeSmall
//                 : Dimensions.fontSizeDefault,
//             isBold: ResponsiveHelper.isDesktop(context) ? false : true,
//             radius: ResponsiveHelper.isDesktop(context)
//                 ? Dimensions.radiusSmall
//                 : Dimensions.radiusDefault,
//             isLoading: storeController.isLoading,
//             margin: EdgeInsets.all(
//               ResponsiveHelper.isDesktop(context)
//                   ? 0
//                   : Dimensions.paddingSizeSmall,
//             ),
//             buttonText: storeController.storeStatus == 0.1 &&
//                     !ResponsiveHelper.isDesktop(context)
//                 ? 'next'.tr
//                 : 'submit'.tr,
//             color: /*ResponsiveHelper.isDesktop(context) ? Theme.of(context).disabledColor.withValues(alpha: 0.9) :*/
//                 Theme.of(context).primaryColor,
//             onPressed: (storeController.storeStatus == 0.1 &&
//                         !ResponsiveHelper.isDesktop(context) &&
//                         !storeController.inZone) ||
//                     (ResponsiveHelper.isDesktop(context) &&
//                         !storeController.inZone)
//                 ? null
//                 : () {
//                     bool defaultDataNull = false;
//                     for (int index = 0;
//                         index < _languageList!.length;
//                         index++) {
//                       if (_languageList[index].key == 'en') {
//                         if (_nameController[index].text.trim().isEmpty ||
//                             _addressController[index].text.trim().isEmpty) {
//                           defaultDataNull = true;
//                         }
//                         break;
//                       }
//                     }
//                     String vat = _vatController.text.trim();
//                     String minTime = storeController.storeMinTime;
//                     String maxTime = storeController.storeMaxTime;
//                     String fName = _fNameController.text.trim();
//                     String lName = _lNameController.text.trim();
//                     String phone = _phoneController.text.trim();
//                     String email = _emailController.text.trim();
//                     String password = _passwordController.text.trim();
//                     String confirmPassword =
//                         _confirmPasswordController.text.trim();
//                     bool valid = false;
//                     try {
//                       num.parse(maxTime);
//                       num.parse(minTime);
//                       valid = true;
//                     } on FormatException {
//                       valid = false;
//                     }

//                     if (storeController.storeStatus == 0.1 ||
//                         storeController.storeStatus == 0.6) {
//                       if (storeController.storeStatus == 0.1 &&
//                           !ResponsiveHelper.isDesktop(context)) {
//                         if (defaultDataNull) {
//                           _scrollToKey(_storeInfoScrollKey);
//                         }
//                         if (vat.isEmpty) {
//                           _scrollToKey(_storePrefScrollKey);
//                         }
//                         if (_formKeyFirst!.currentState!.validate()) {
//                           if (defaultDataNull) {
//                             showCustomSnackBar('enter_vendor_name'.tr);
//                           } else if (storeController.pickedLogo == null) {
//                             _scrollToKey(_storeInfoScrollKey);
//                             showCustomSnackBar('select_vendor_logo'.tr);
//                           } else if (storeController.pickedCover == null) {
//                             _scrollToKey(_storeInfoScrollKey);
//                             showCustomSnackBar('select_vendor_cover_photo'.tr);
//                           } else if (storeController.selectedZoneIndex ==
//                               -1) {
//                             _scrollToKey(_locationInfoScrollKey);
//                             showCustomSnackBar('please_select_zone'.tr);
//                           } else if (storeController.selectedModuleIndex ==
//                               -1) {
//                             _scrollToKey(_locationInfoScrollKey);
//                             showCustomSnackBar('please_select_module_first'.tr);
//                           } else if (storeController.restaurantLocation ==
//                               null) {
//                             showCustomSnackBar('set_vendor_location'.tr);
//                             _scrollToKey(_locationInfoScrollKey);
//                           } else if (vat.isEmpty) {
//                             showCustomSnackBar('enter_vat_amount'.tr);
//                           } else if (minTime.isEmpty) {
//                             showCustomSnackBar(
//                               'enter_minimum_delivery_time'.tr,
//                             );
//                           } else if (maxTime.isEmpty) {
//                             showCustomSnackBar(
//                               'enter_maximum_delivery_time'.tr,
//                             );
//                           } else if (!valid) {
//                             _scrollToKey(_storePrefScrollKey);
//                             showCustomSnackBar(
//                               'please_enter_the_max_min_delivery_time'.tr,
//                             );
//                           } else if (valid &&
//                               num.parse(minTime) > num.parse(maxTime)) {
//                             showCustomSnackBar(
//                               'maximum_delivery_time_can_not_be_smaller_then_minimum_delivery_time'
//                                   .tr,
//                             );
//                           } else {
//                             _scrollController.jumpTo(
//                               _scrollController.position.minScrollExtent,
//                             );
//                             storeController.storeStatusChange(0.6);
//                             firstTime = true;
//                           }
//                         }
//                       } else {
//                         if (ResponsiveHelper.isDesktop(context)) {
//                           if (defaultDataNull) {
//                             showCustomSnackBar('enter_vendor_name'.tr);
//                           } else if (storeController.restaurantLocation ==
//                               null) {
//                             showCustomSnackBar('set_vendor_location'.tr);
//                           } else if (storeController.selectedZoneIndex ==
//                               -1) {
//                             showCustomSnackBar('please_select_zone'.tr);
//                           } else if (storeController.selectedModuleIndex ==
//                               -1) {
//                             showCustomSnackBar('please_select_module_first'.tr);
//                           } else if (vat.isEmpty) {
//                             showCustomSnackBar('enter_vat_amount'.tr);
//                           } else if (minTime.isEmpty) {
//                             showCustomSnackBar(
//                               'enter_minimum_delivery_time'.tr,
//                             );
//                           } else if (maxTime.isEmpty) {
//                             showCustomSnackBar(
//                               'enter_maximum_delivery_time'.tr,
//                             );
//                           } else if (!valid) {
//                             showCustomSnackBar(
//                               'please_enter_the_max_min_delivery_time'.tr,
//                             );
//                           } else if (valid &&
//                               num.parse(minTime) > num.parse(maxTime)) {
//                             showCustomSnackBar(
//                               'maximum_delivery_time_can_not_be_smaller_then_minimum_delivery_time'
//                                   .tr,
//                             );
//                           } else if (storeController.pickedLogo == null) {
//                             showCustomSnackBar('select_vendor_logo'.tr);
//                           } else if (storeController.pickedCover == null) {
//                             showCustomSnackBar('select_vendor_cover_photo'.tr);
//                           }
//                         }
//                         if ((storeController.storeStatus == 0.6 &&
//                                 _formKeySecond!.currentState!.validate()) ||
//                             ResponsiveHelper.isDesktop(context)) {
//                           if (fName.isEmpty) {
//                             showCustomSnackBar('enter_your_first_name'.tr);
//                           } else if (lName.isEmpty) {
//                             showCustomSnackBar('enter_your_last_name'.tr);
//                           } else if (phone.isEmpty) {
//                             showCustomSnackBar('enter_phone_number'.tr);
//                           } else if (email.isEmpty) {
//                             showCustomSnackBar('enter_email_address'.tr);
//                           } else if (!GetUtils.isEmail(email)) {
//                             showCustomSnackBar(
//                               'enter_a_valid_email_address'.tr,
//                             );
//                           } else if (password.isEmpty) {
//                             showCustomSnackBar('enter_password'.tr);
//                           } else if (password.length < 8) {
//                             showCustomSnackBar('password_should_be'.tr);
//                           } else if (password != confirmPassword) {
//                             showCustomSnackBar(
//                               'confirm_password_does_not_matched'.tr,
//                             );
//                           } else if (!storeController.spatialCheck ||
//                               !storeController.lowercaseCheck ||
//                               !storeController.uppercaseCheck ||
//                               !storeController.numberCheck ||
//                               !storeController.lengthCheck) {
//                             showCustomSnackBar('provide_valid_password'.tr);
//                           } else {
//                             storeController.storeStatusChange(0.9);
//                           }
//                         }
//                       }
//                     } else {
//                       List<Translation> translation = [];
//                       for (int index = 0;
//                           index < _languageList.length;
//                           index++) {
//                         translation.add(
//                           Translation(
//                             locale: _languageList[index].key,
//                             key: 'name',
//                             value: _nameController[index].text.trim().isNotEmpty
//                                 ? _nameController[index].text.trim()
//                                 : _nameController[0].text.trim(),
//                           ),
//                         );
//                         translation.add(
//                           Translation(
//                             locale: _languageList[index].key,
//                             key: 'address',
//                             value:
//                                 _addressController[index].text.trim().isNotEmpty
//                                     ? _addressController[index].text.trim()
//                                     : _addressController[0].text.trim(),
//                           ),
//                         );
//                       }

//                       storeController.registerStore(
//                         StoreBodyModel(
//                           translation: jsonEncode(translation),
//                           tax: vat,
//                           minDeliveryTime: minTime,
//                           maxDeliveryTime: maxTime,
//                           lat: storeController.restaurantLocation!.latitude
//                               .toString(),
//                           email: email,
//                           lng: storeController.restaurantLocation!.longitude
//                               .toString(),
//                           fName: fName,
//                           lName: lName,
//                           phone: _countryDialCode! + phone,
//                           password: password,
//                           zoneId: storeController
//                               .zoneList![storeController.selectedZoneIndex!]
//                               .id
//                               .toString(),
//                           moduleId: storeController
//                               .moduleList![
//                                   storeController.selectedModuleIndex!]
//                               .id
//                               .toString(),
//                           deliveryTimeType: storeController.storeTimeUnit,
//                           businessPlan: storeController.businessIndex == 0
//                               ? 'commission'
//                               : 'subscription',
//                           packageId: storeController.businessIndex == 0
//                               ? ''
//                               : storeController
//                                   .packageModel!
//                                   .packages![storeController
//                                       .activeSubscriptionIndex]
//                                   .id!
//                                   .toString(),
//                           pickUpZoneIds: storeController.pickupZoneIdList
//                               .map((e) => e.toString())
//                               .toList(),
//                         ),
//                       );
//                     }
//                   },
//           ),
//         );
//       },
//     );
//   }

//   void stepOne(
//     bool defaultDataNull,
//     String vat,
//     String minTime,
//     String maxTime,
//     bool valid,
//     StoreRegistrationController storeController,
//   ) {
//     if (defaultDataNull) {
//       _scrollToKey(_storeInfoScrollKey);
//     }
//     if (vat.isEmpty) {
//       _scrollToKey(_storePrefScrollKey);
//     }
//     if (_formKeyFirst!.currentState!.validate()) {
//       if (defaultDataNull) {
//         showCustomSnackBar('enter_vendor_name'.tr);
//       } else if (storeController.pickedLogo == null) {
//         _scrollToKey(_storeInfoScrollKey);
//         showCustomSnackBar('select_vendor_logo'.tr);
//       } else if (storeController.pickedCover == null) {
//         _scrollToKey(_storeInfoScrollKey);
//         showCustomSnackBar('select_vendor_cover_photo'.tr);
//       } else if (storeController.selectedZoneIndex == -1) {
//         _scrollToKey(_locationInfoScrollKey);
//         showCustomSnackBar('please_select_zone'.tr);
//       } else if (storeController.selectedModuleIndex == -1) {
//         _scrollToKey(_locationInfoScrollKey);
//         showCustomSnackBar('please_select_module_first'.tr);
//       } else if (storeController.restaurantLocation == null) {
//         showCustomSnackBar('set_vendor_location'.tr);
//         _scrollToKey(_locationInfoScrollKey);
//       } else if (vat.isEmpty) {
//         showCustomSnackBar('enter_vat_amount'.tr);
//       } else if (minTime.isEmpty) {
//         showCustomSnackBar('enter_minimum_delivery_time'.tr);
//       } else if (maxTime.isEmpty) {
//         showCustomSnackBar('enter_maximum_delivery_time'.tr);
//       } else if (!valid) {
//         _scrollToKey(_storePrefScrollKey);
//         showCustomSnackBar('please_enter_the_max_min_delivery_time'.tr);
//       } else if (valid && num.parse(minTime) > num.parse(maxTime)) {
//         showCustomSnackBar(
//           'maximum_delivery_time_can_not_be_smaller_then_minimum_delivery_time'
//               .tr,
//         );
//       } else {
//         _scrollController.jumpTo(_scrollController.position.minScrollExtent);
//         storeController.storeStatusChange(0.6);
//         firstTime = true;
//       }
//     }
//   }

//   void _scrollToKey(GlobalKey scrollKey) {
//     final context = scrollKey.currentContext;
//     if (context != null) {
//       Scrollable.ensureVisible(
//         context,
//         duration: const Duration(seconds: 1),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
// }

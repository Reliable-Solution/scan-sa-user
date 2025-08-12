import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/forgot_pass_screens/controller/forgot_pass_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/forgot_pass_screens/forgot_pass_screen.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/login_screens/controller/login_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/login_screens/login_screen.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/new_user_setup_screen.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/otp_screens/otp_screen.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/reset_pass_screens/reset_pass_screen.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/sign_up_screens/sign_up_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/bottom_bar_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/cart_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/checkout_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/promo_code_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/slot_selection_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/category_module/category_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/home_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/provider/home_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/category_detail_screens/category_detail_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/qr_scanner_screen/qr_scanner_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/controller/restaurant_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/restaurant_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/screens/reservation_screens/reservation_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/screens/reservation_screens/screens/confirmation_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/screens/reservation_screens/screens/success_failed_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/payment/screens/payment_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/change_pass/change_pass_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/coupon_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/edit_profile/edit_profile_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/help_n_support/help_n_support.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/screens/html_viewer_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/delivery_man_registration_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/screens/subscription_payment_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/screens/subscription_success_or_failed_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/store_registration_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/screens/loyalty_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/wallet_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/search_screen.dart';
import 'package:scan_sa_user/app/presentation/location_module/edit_address_screen.dart';
import 'package:scan_sa_user/app/presentation/location_module/location_screen.dart';
import 'package:scan_sa_user/app/presentation/splash_screens/splash_screen.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class AppRoutings {
  AppRoutings._();

  static List<GetPage<dynamic>> routes = [
    GetPage(name: AppRoutes.initial, page: SplashScreen.new),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(
        controller: Get.put(LoginController(authServiceInterface: Get.find())),
      ),
      children: [
        GetPage(
          name: AppRoutes.newUser,
          page: () => NewUserSetupScreen(
            name: Get.parameters['name']!,
            loginType: Get.parameters['login_type']!,
            phone:
                Get.parameters['phone'] != '' &&
                    Get.parameters['phone'] != 'null'
                ? Get.parameters['phone']?.replaceAll(' ', '+')
                : null,
            email:
                Get.parameters['email'] != '' &&
                    Get.parameters['email'] != 'null'
                ? Get.parameters['email']?.replaceAll(' ', '+')
                : null,
          ),
        ),
        GetPage(
          name: AppRoutes.signUp,
          page: SignUpScreen.new,
          children: [
            GetPage(
              name: AppRoutes.otp,
              page: () {
                '===>> Get.arguments ${Get.parameters} === ${Get.arguments}'
                    .print;
                return OtpScreen(
                  isFromSignUp: true,
                  email:
                      (Get.arguments as Map<String, dynamic>?)?['email']
                          as String?,
                  mobile:
                      (Get.arguments as Map<String, dynamic>?)?['mobile']
                          as String?,
                );
              },
            ),
          ],
        ),
        GetPage(
          name: AppRoutes.forgotPass,
          page: () => ForgotPassScreen(
            controller: Get.put(
              ForgotPassController(authServiceInterface: Get.find()),
            ),
          ),
          children: [
            GetPage(
              name: AppRoutes.otp,
              page: () {
                return OtpScreen(
                  email:
                      (Get.arguments as Map<String, dynamic>?)?['email']
                          as String?,
                  mobile:
                      (Get.arguments as Map<String, dynamic>?)?['mobile']
                          as String?,
                );
              },
              children: [
                GetPage(name: AppRoutes.resetPass, page: ResetPassScreen.new),
              ],
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.locationScreen,
      page: () => const LocationScreen(isBack: false),
    ),
    GetPage(
      name: AppRoutes.bottomBarScreen,
      page: BottomBarScreen.new,
      children: [
        GetPage(
          name: AppRoutes.homeScreen,
          page: () {
            return HomeScreen(
              isPickupScreen: (Get.arguments as int?) == 2,
              isSlotScreen: (Get.arguments as int?) == 3,
              controller: Get.put(
                HomeController(storeServiceInterface: Get.find()),
              ),
            );
          },
          children: [
            GetPage(name: AppRoutes.searchScreen, page: SearchScreen.new),
            GetPage(
              name: AppRoutes.restaurantScreen,
              page: () {
                final index = Get.arguments is Map<String, dynamic>
                    ? ((Get.arguments as Map<String, dynamic>?)?['index']
                          as int?)
                    : 0;
                final isReservation = Get.arguments is Map<String, dynamic>
                    ? ((Get.arguments
                              as Map<String, dynamic>?)?['isReservation']
                          as bool?)
                    : false;
                final store = Get.arguments is Map<String, dynamic>
                    ? ((Get.arguments as Map<String, dynamic>?)?['store']
                          as Map<String, dynamic>)
                    : {} as Map<String, dynamic>;
                '==>> Get.arguments ${Get.arguments}'.print;
                Get.put(
                  RestaurantController(
                    storeServiceInterface: Get.find(),
                    store: Store.fromJson(store),
                  ),
                );
                return RestaurantScreen(
                  index: index ?? 0,
                  store: Store.fromJson(store),
                  isReservation: isReservation ?? false,
                );
              },
              children: [
                GetPage(
                  name: AppRoutes.reservationScreen,
                  page: ReservationScreen.new,
                  children: [
                    GetPage(
                      name: AppRoutes.confirmationScreen,
                      page: ConfirmationScreen.new,
                      children: [
                        GetPage(
                          name: AppRoutes.successFailedScreen,
                          page: SuccessFailedScreen.new,
                        ),
                      ],
                    ),
                  ],
                ),
                GetPage(
                  name: AppRoutes.cartScreen,
                  page: CartScreen.new,
                  children: [
                    GetPage(
                      name: AppRoutes.checkOutScreen,
                      page: CheckoutScreen.new,
                      children: [
                        GetPage(
                          name: AppRoutes.slotSelectionScreen,
                          page: () => SlotSelectionScreen(
                            isTodayClosed:
                                (Get.arguments?['isTodayClosed'] as bool?) ??
                                true,
                            isTomorrowClosed:
                                (Get.arguments?['isTomorrowClosed'] as bool?) ??
                                true,
                          ),
                        ),
                        GetPage(
                          name: AppRoutes.promoCodeScreen,
                          page: () {
                            final data = Get.arguments as Map<String, dynamic>;
                            return PromoCodeScreen(
                              order: data['order'] as num,
                              storeId: data['storeId'] as int,
                              deliveryCharge: data['deliveryCharge'] as num,
                              total: data['total'] as num,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GetPage(
          name: AppRoutes.locationScreen,
          page: () => const LocationScreen(isBack: true),
        ),
        GetPage(name: AppRoutes.qrScannerScreen, page: QrScannerScreen.new),
        GetPage(name: AppRoutes.helpNSupport, page: HelpNSupport.new),
        GetPage(
          name: AppRoutes.paymentWebView,
          page: () => PaymentWebView(
            url: Get.arguments['url'] as String,
            forSubscription:
                (Get.arguments['forSubscription'] as bool?) ?? false,
          ),
        ),
        GetPage(
          name: AppRoutes.categoryDetailScreen,
          page: () {
            final data = Get.arguments as Map<String, dynamic>;
            return CategoryDetailScreen(
              categoryId: data['categoryId'] as String,
              categoryName: data['categoryName'] as String,
            );
          },
        ),
        GetPage(
          name: AppRoutes.htmlViewerScreen,
          page: () => HtmlViewerScreen(
            isPrivacyPolicy:
                (Get.arguments is bool) && (Get.arguments! as bool),
          ),
        ),

        GetPage(
          name: AppRoutes.checkOutScreen,
          page: () => const CheckoutScreen(isFromBottom: true),
          children: [
            GetPage(
              name: AppRoutes.slotSelectionScreen,
              page: () => SlotSelectionScreen(
                isTodayClosed:
                    (Get.arguments?['isTodayClosed'] as bool?) ?? true,
                isTomorrowClosed:
                    (Get.arguments?['isTomorrowClosed'] as bool?) ?? true,
              ),
            ),
            GetPage(
              name: AppRoutes.promoCodeScreen,
              page: () {
                final data = Get.arguments as Map<String, dynamic>;
                return PromoCodeScreen(
                  order: data['order'] as num,
                  storeId: data['storeId'] as int,
                  deliveryCharge: data['deliveryCharge'] as num,
                  total: data['total'] as num,
                );
              },
            ),
          ],
        ),
        GetPage(
          name: AppRoutes.editProfileScreen,
          page: () => const EditProfileScreen(),
          children: [
            GetPage(
              name: AppRoutes.changePassScreen,
              page: ChangePassScreen.new,
            ),
          ],
        ),
        GetPage(
          name: AppRoutes.editAddressScreen,
          page: () => EditAddressScreen(
            isEdit: Get.arguments is bool && Get.arguments as bool,
          ),
        ),
        GetPage(name: AppRoutes.couponScreen, page: CouponScreen.new),
        GetPage(name: AppRoutes.walletScreen, page: WalletScreen.new),
        GetPage(
          name: AppRoutes.loyalPoint,
          page: () => const LoyaltyScreen(fromNotification: false),
        ),
        GetPage(
          name: AppRoutes.joinAsDeliveryScreen,
          page: () => const DeliveryManRegistrationScreen(),
        ),
        GetPage(
          name: AppRoutes.joinAsVendorScreen,
          page: () => const StoreRegistrationScreen(),
          children: [
            GetPage(
              name: AppRoutes.subscriptionPayment,
              page: () => SubscriptionPaymentScreen(
                storeId: Get.arguments['storeId'] as int?,
                packageId: Get.arguments['packageId'] as int?,
              ),
            ),
            GetPage(
              name: AppRoutes.subscriptionSuccess,
              page: () => SubscriptionSuccessOrFailedScreen(
                storeId: Get.arguments['storeId'] as int?,
                fromSubscription: true,
                success: (Get.arguments['success'] as bool?) ?? false,
              ),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.categoryScreen,
      page: SpinnerPage.new,
      transition: Transition.upToDown,
    ),
    // GetPage(
    //   name: payment,
    //   page: () {
    //     final order = OrderModel(
    //       id: int.parse(Get.parameters['id']!),
    //       orderType: Get.parameters['type'],
    //       userId: int.parse(Get.parameters['user']!),
    //       orderAmount: num.parse(Get.parameters['amount']!),
    //     );
    //     final isCodActive = Get.parameters['cod-delivery'] == 'true';
    //     var addFundUrl = '';
    //     var subscriptionUrl = '';
    //     final paymentMethod = Get.parameters['payment-method']!;
    //     if (Get.parameters['add-fund-url'] != null &&
    //         Get.parameters['add-fund-url'] != 'null') {
    //       addFundUrl = Get.parameters['add-fund-url']!;
    //     }
    //     if (Get.parameters['subscription-url'] != null &&
    //         Get.parameters['subscription-url'] != 'null') {
    //       subscriptionUrl = Get.parameters['subscription-url']!;
    //     }
    //     final guestId = Get.parameters['guest-id']!;
    //     final number = Get.parameters['number']!;
    //     final storeId =
    //         (Get.parameters['store_id'] != null &&
    //             Get.parameters['store_id'] != 'null')
    //         ? int.parse(Get.parameters['store_id']!)
    //         : null;
    //     final createAccount = Get.parameters['create_account'] == 'true';
    //     final createUserId =
    //         Get.parameters['create_user_id'] != null &&
    //             Get.parameters['create_user_id'] != 'null'
    //         ? int.parse(Get.parameters['create_user_id']!)
    //         : null;
    //     return getRoute(
    //       AppConstants.payInWevView
    //           ? PaymentWebViewScreen(
    //               orderModel: order,
    //               isCashOnDelivery: isCodActive,
    //               addFundUrl: addFundUrl,
    //               paymentMethod: paymentMethod,
    //               guestId: guestId,
    //               contactNumber: number,
    //               subscriptionUrl: subscriptionUrl,
    //               storeId: storeId,
    //               createAccount: createAccount,
    //             )
    //           : PaymentScreen(
    //               orderModel: order,
    //               isCashOnDelivery: isCodActive,
    //               addFundUrl: addFundUrl,
    //               paymentMethod: paymentMethod,
    //               guestId: guestId,
    //               contactNumber: number,
    //               subscriptionUrl: subscriptionUrl,
    //               storeId: storeId,
    //               createAccount: createAccount,
    //               createUserId: createUserId,
    //             ),
    //     );
    //   },
    // ),
  ];
}

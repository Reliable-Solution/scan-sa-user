import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_repo/auth_repository.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_repo/auth_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/item_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/cart_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/cart_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/item_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/item_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/services/cart_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/services/cart_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/services/item_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/services/item_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/repositories/checkout_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/repositories/checkout_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/services/checkout_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/services/checkout_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/controllers/favorite_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/repositories/favorite_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/repositories/favorite_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/services/favorite_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/services/favorite_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/repositories/banner_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/repositories/banner_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/services/banner_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/services/banner_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/repositories/category_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/repositories/category_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/services/category_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/services/category_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/repositories/store_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/repositories/store_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/services/store_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/services/store_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/repositories/profile_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/repositories/profile_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/services/profile_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/services/profile_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/repositories/coupon_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/repositories/coupon_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/services/coupon_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/services/coupon_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/repositories/html_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/repositories/html_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/services/html_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/services/html_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/repositories/deliveryman_registration_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/repositories/deliveryman_registration_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/services/deliveryman_registration_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/services/deliveryman_registration_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/repositories/business_repo.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/repositories/business_repo_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/services/business_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/services/business_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/repositories/store_registration_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/repositories/store_registration_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/services/store_registration_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/services/store_registration_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/repositories/loyalty_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/repositories/loyalty_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/services/loyalty_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/services/loyalty_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/repositories/wallet_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/repositories/wallet_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/services/wallet_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/services/wallet_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/repositories/search_repository.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/repositories/search_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/services/search_service.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/services/search_service_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/repositories/location_repository.dart';
import 'package:scan_sa_user/app/presentation/location_module/repositories/location_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/services/location_service.dart';
import 'package:scan_sa_user/app/presentation/location_module/services/location_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/repositories/global_repository.dart';
import 'package:scan_sa_user/app/presentation/main_screens/repositories/global_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/services/global_service.dart';
import 'package:scan_sa_user/app/presentation/main_screens/services/global_service_interface.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> getDiInit() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);
  Get.put(
    ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()),
  );

  await _registerRepo();
  await registerService();
}

Future<void> _registerRepo() async {
  /// global repo
  final GlobalRepositoryInterface globalRepositoryInterface = GlobalRepository(
    apiClient: Get.find(),
    sharedPreferences: Get.find(),
  );
  Get.put(globalRepositoryInterface);

  /// auth repo
  final AuthRepositoryInterface authRepositoryInterface = AuthRepository(
    apiClient: Get.find(),
    sharedPreferences: Get.find(),
  );
  Get.put(authRepositoryInterface);

  /// location repo
  final LocationRepositoryInterface<AddressModel> locationRepositoryInterface =
      LocationRepository(apiClient: Get.find());
  Get.put(locationRepositoryInterface);

  /// banner repo
  final BannerRepositoryInterface bannerRepositoryInterface = BannerRepository(
    apiClient: Get.find(),
  );
  Get.put(bannerRepositoryInterface);

  /// category repo
  final CategoryRepositoryInterface categoryRepositoryInterface =
      CategoryRepository(apiClient: Get.find());
  Get.put(categoryRepositoryInterface);

  /// search repo
  final SearchRepositoryInterface searchRepositoryInterface = SearchRepository(
    apiClient: Get.find(),
    sharedPreferences: Get.find(),
  );
  Get.put(searchRepositoryInterface);

  /// html repo
  final HtmlRepositoryInterface htmlRepositoryInterface = HtmlRepository(
    apiClient: Get.find(),
  );
  Get.put(htmlRepositoryInterface);

  /// store repo
  final StoreRepositoryInterface storeRepositoryInterface = StoreRepository(
    apiClient: Get.find(),
    sharedPreferences: Get.find(),
  );
  Get.put(storeRepositoryInterface);

  /// Favorite repo
  final FavoriteRepositoryInterface<dynamic> favoriteRepositoryInterface =
      FavoriteRepository(apiClient: Get.find());
  Get.put(favoriteRepositoryInterface);

  /// Cart repo
  final CartRepositoryInterface<dynamic> cartRepositoryInterface =
      CartRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.put(cartRepositoryInterface);

  /// Item repo
  final ItemRepositoryInterface itemRepositoryInterface = ItemRepository(
    apiClient: Get.find(),
  );
  Get.put(itemRepositoryInterface);

  /// Profile repo
  final ProfileRepositoryInterface profileRepositoryInterface =
      ProfileRepository(apiClient: Get.find());
  Get.put(profileRepositoryInterface);

  /// Coupon repo
  final CouponRepositoryInterface couponRepositoryInterface = CouponRepository(
    apiClient: Get.find(),
  );
  Get.put(couponRepositoryInterface);

  /// Loyalty repo
  final LoyaltyRepositoryInterface loyaltyRepositoryInterface =
      LoyaltyRepository(apiClient: Get.find());
  Get.put(loyaltyRepositoryInterface);

  /// Wallet repo
  final WalletRepositoryInterface walletRepositoryInterface = WalletRepository(
    apiClient: Get.find(),
    sharedPreferences: Get.find(),
  );
  Get.put(walletRepositoryInterface);

  /// Checkout repo
  final CheckoutRepositoryInterface checkoutRepositoryInterface =
      CheckoutRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.put(checkoutRepositoryInterface);

  /// Join as delivery repo
  final DeliverymanRegistrationRepositoryInterface
  deliverymanRegistrationRepositoryInterface =
      DeliverymanRegistrationRepository(
        apiClient: Get.find(),
        sharedPreferences: Get.find(),
      );
  Get.put(deliverymanRegistrationRepositoryInterface);

  /// Join as store repo
  final StoreRegistrationRepositoryInterface storeRegistrationServiceInterface =
      StoreRegistrationRepository(apiClient: Get.find());
  Get.put(storeRegistrationServiceInterface);

  /// business interface repo
  final BusinessRepoInterface businessRepoInterface = BusinessRepo(
    apiClient: Get.find(),
  );
  Get.put(businessRepoInterface);
}

Future<void> registerService() async {
  /// global service
  final GlobalServiceInterface globalServiceInterface = GlobalService(
    globalRepositoryInterface: Get.find(),
  );
  Get.put(globalServiceInterface);

  /// auth service
  final AuthServiceInterface authServiceInterface = AuthService(
    authRepositoryInterface: Get.find(),
  );
  Get.put(authServiceInterface);

  /// location service
  final LocationServiceInterface locationServiceInterface = LocationService(
    locationRepoInterface: Get.find(),
  );
  Get.put(locationServiceInterface);

  /// banner service interface service
  final BannerServiceInterface bannerServiceInterface = BannerService(
    bannerRepositoryInterface: Get.find(),
  );
  Get.put(bannerServiceInterface);

  /// category interface service
  final CategoryServiceInterface categoryServiceInterface = CategoryService(
    categoryRepositoryInterface: Get.find(),
  );
  Get.put(categoryServiceInterface);

  /// Search interface service
  final SearchServiceInterface searchServiceInterface = SearchService(
    searchRepositoryInterface: Get.find(),
  );
  Get.put(searchServiceInterface);

  /// Html service interface service
  final HtmlServiceInterface htmlServiceInterface = HtmlService(
    htmlRepositoryInterface: Get.find(),
  );
  Get.put(htmlServiceInterface);

  /// store interface service
  final StoreServiceInterface storeInterface = StoreService(
    storeRepositoryInterface: Get.find(),
  );
  Get.put(storeInterface);

  /// favorite interface service
  final FavoriteServiceInterface favoriteInterface = FavoriteService(
    favoriteRepositoryInterface: Get.find(),
  );
  Get.put(favoriteInterface);

  Get.put(FavoriteController(favoriteServiceInterface: favoriteInterface));

  /// cart interface service
  final CartServiceInterface cartInterface = CartService(
    cartRepositoryInterface: Get.find(),
  );
  Get.put(cartInterface);
  Get.put(CartController(cartServiceInterface: cartInterface));

  /// cart interface service
  final ItemServiceInterface itemInterface = ItemService(
    itemRepositoryInterface: Get.find(),
  );
  Get.put(itemInterface);
  Get.put(ItemController(itemServiceInterface: itemInterface));

  /// profile interface service
  final ProfileServiceInterface profileInterface = ProfileService(
    profileRepositoryInterface: Get.find(),
  );
  Get.put(profileInterface);

  /// coupon interface service
  final CouponServiceInterface couponInterface = CouponService(
    couponRepositoryInterface: Get.find(),
  );
  Get.put(couponInterface);

  /// loyalty interface service
  final LoyaltyServiceInterface loyaltyInterface = LoyaltyService(
    loyaltyRepositoryInterface: Get.find(),
  );
  Get.put(loyaltyInterface);

  /// wallet interface service
  final WalletServiceInterface walletInterface = WalletService(
    walletRepositoryInterface: Get.find(),
  );
  Get.put(walletInterface);

  /// checkout interface service
  final CheckoutServiceInterface checkoutInterface = CheckoutService(
    checkoutRepositoryInterface: Get.find(),
  );
  Get.put(checkoutInterface);

  /// delivery interface service
  final DeliverymanRegistrationServiceInterface
  deliverymanRegistrationServiceInterface = DeliverymanRegistrationService(
    deliverymanRegistrationRepoInterface: Get.find(),
    authRepositoryInterface: Get.find(),
  );
  Get.put(deliverymanRegistrationServiceInterface);

  /// store interface service
  final StoreRegistrationServiceInterface storeRepositoryInterface =
      StoreRegistrationService(
        deliverymanRegistrationRepositoryInterface: Get.find(),
        storeRegistrationRepoInterface: Get.find(),
      );
  Get.put(storeRepositoryInterface);

  /// business interface service
  final BusinessServiceInterface businessServiceInterface = BusinessService(
    businessRepoInterface: Get.find(),
  );
  Get.put(businessServiceInterface);
}

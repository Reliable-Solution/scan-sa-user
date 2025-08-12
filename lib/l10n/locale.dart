import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  static final List<String> supportedLanguages = ['en', 'ar'];
  static const Locale fallbackLocale = Locale('en', 'US');
  static Locale defaultLocale = fallbackLocale;

  static final Map<String, Map<String, String>> _localizedStrings = {};

  static Locale createLocale(String language) {
    return language.contains('_')
        ? Locale.fromSubtags(
            languageCode: language.split('_').first,
            scriptCode: language.split('_').last,
          )
        : Locale(language);
  }

  List<Locale> getSupportedLocales() {
    return supportedLanguages.map(createLocale).toList();
  }

  static Future<void> loadTranslations() async {
    for (final locale in supportedLanguages) {
      final jsonString = await rootBundle.loadString(
        'assets/localizations/$locale.json',
      );
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      _localizedStrings[locale] = jsonMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    }
    defaultLocale = await getLocale();
  }

  @override
  Map<String, Map<String, String>> get keys => _localizedStrings;

  static Future<void> updateLocale(String locale) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('locale', locale);
    Get.find<GlobalController>().changeLocale(Locale(locale));
    await Get.updateLocale(Locale(locale));
  }

  static Future<Locale> getLocale() async {
    final pref = await SharedPreferences.getInstance();
    final savedLocale = pref.getString('locale');
    return createLocale(savedLocale ?? fallbackLocale.languageCode);
  }
}

class AppLocalizations {
  String welcome = 'welcome'.tr;
  String letsStartWith = 'letsStartWith'.tr;
  String enterEmail = 'enterEmail'.tr;
  String password = 'password'.tr;
  String rememberMe = 'rememberMe'.tr;
  String forgotPasswordQ = 'forgotPasswordQ'.tr;
  String iAgree = 'iAgree'.tr;
  String login = 'login'.tr;
  String facebook = 'facebook'.tr;
  String google = 'google'.tr;
  String apple = 'apple'.tr;
  String donNotHaveAcc = 'donNotHaveAcc'.tr;
  String userName = 'userName'.tr;
  String phone = 'phone'.tr;
  String email = 'email'.tr;
  String confirmPassword = 'confirmPassword'.tr;
  String referCode = 'referCode'.tr;
  String signUp = 'signUp'.tr;
  String signIn = 'signIn'.tr;
  String orWith = 'orWith'.tr;
  String alreadyHaveAcc = 'alreadyHaveAcc'.tr;
  String verify = 'verify'.tr;
  String send = 'send'.tr;
  String resetPassword = 'resetPassword'.tr;
  String submit = 'submit'.tr;
  String home = 'home'.tr;
  String search = 'search'.tr;
  String cart = 'cart'.tr;
  String profile = 'profile'.tr;
  String checkout = 'checkout'.tr;
  String placeOrder = 'placeOrder'.tr;
  String deliveryAddress = 'deliveryAddress'.tr;
  String choosePaymentMethod = 'choosePaymentMethod'.tr;
  String summary = 'summary'.tr;
  String itemPrice = 'itemPrice'.tr;
  String discount = 'discount'.tr;
  String vatTax = 'vatTax'.tr;
  String deliveryFee = 'deliveryFee'.tr;
  String serviceFee = 'serviceFee'.tr;
  String promoCode = 'promoCode'.tr;
  String enterPromoCode = 'enterPromoCode'.tr;
  String apply = 'apply'.tr;
  String schedule = 'schedule'.tr;
  String today = 'today'.tr;
  String tomorrow = 'tomorrow'.tr;
  String instant = 'instant'.tr;
  String privacyPolicy = 'privacyPolicy'.tr;
  String termsConditions = 'termsConditions'.tr;
  String refundPolicy = 'refundPolicy'.tr;
  String and = 'and'.tr;
  String weJustSent = 'weJustSent'.tr;
  String enterTheSecurity = 'enterTheSecurity'.tr;
  String forgotPassword = 'forgotPassword'.tr;
  String checkYourInbox = 'checkYourInbox'.tr;
  String pleaseEnterEmail = 'pleaseEnterEmail'.tr;
  String pleaseEnterValidEmail = 'pleaseEnterValidEmail'.tr;
  String pleaseEnterUserName = 'pleaseEnterUserName'.tr;
  String pleaseEnterPassword = 'pleaseEnterPassword'.tr;
  String passwordShouldBe = 'passwordShouldBe'.tr;
  String pleaseEnterConfirmPassword = 'pleaseEnterConfirmPassword'.tr;
  String pleaseEnterPhoneNumber = 'pleaseEnterPhoneNumber'.tr;
  String invalidPhoneNumber = 'invalidPhoneNumber'.tr;
  String pleaseEnterOtp = 'pleaseEnterOtp'.tr;
  String justOneStepAway = 'justOneStepAway'.tr;
  String done = 'done'.tr;
  String notConnected = 'notConnected'.tr;
  String connected = 'connected'.tr;
  String subscribedSuccessfully = 'subscribedSuccessfully'.tr;
  String pickAddress = 'pickAddress'.tr;
  String restaurant = 'restaurant'.tr;
  String restaurants = 'restaurants'.tr;
  String cafe = 'cafe'.tr;
  String dineIn = 'dineIn'.tr;
  String sortBy = 'sortBy'.tr;
  String popularBrand = 'popularBrand'.tr;
  String recommended = 'recommended'.tr;
  String nearMe = 'nearMe'.tr;
  String showResult = 'showResult'.tr;
  String free = 'free'.tr;
  String deleteCart = 'deleteCart'.tr;
  String deleteCartDescription = 'deleteCartDescription'.tr;
  String keepCart = 'keepCart'.tr;
  String confirmDeleteCart = 'confirmDeleteCart'.tr;
  String goToCheckout = 'goToCheckout'.tr;
  String yourCart = 'yourCart'.tr;
  String productFrom = 'productFrom'.tr;
  String addMoreItems = 'addMoreItems'.tr;
  String itemsAdded = 'itemsAdded'.tr;
  String viewCart = 'viewCart'.tr;
  String ratings = 'ratings'.tr;
  String items = 'items'.tr;
  String mealStart = 'mealStart'.tr;
  String emptyCartMessage = 'emptyCartMessage'.tr;
  String browseRestaurants = 'browseRestaurants'.tr;
  String homeDelivery = 'homeDelivery'.tr;
  String takeAway = 'takeAway'.tr;
  String deliveryType = 'deliveryType'.tr;
  String charge = 'charge'.tr;
  String streetNumber = 'streetNumber'.tr;
  String house = 'house'.tr;
  String floor = 'floor'.tr;
  String preferenceTime = 'preferenceTime'.tr;
  String select = 'select'.tr;
  String addNotes = 'addNotes'.tr;
  String gotPromoCode = 'gotPromoCode'.tr;
  String agreeWith = 'agreeWith'.tr;
  String choosePayment = 'choosePayment'.tr;
  String promoCodes = 'promoCodes'.tr;
  String addVoucher = 'addVoucher'.tr;
  String selectPreferenceTime = 'selectPreferenceTime'.tr;
  String setANewPass = 'setANewPass'.tr;
  String enterNewPass = 'enterNewPass'.tr;
  String myAddress = 'myAddress'.tr;
  String language = 'language'.tr;
  String promotionalActivity = 'promotionalActivity'.tr;
  String coupon = 'coupon'.tr;
  String loyalPoints = 'loyalPoints'.tr;
  String threePoints = 'threePoints'.tr;
  String myWallet = 'myWallet'.tr;
  String earning = 'earning'.tr;
  String joinAsDeliveryMan = 'joinAsDeliveryMan'.tr;
  String openVendor = 'openVendor'.tr;
  String helpSupport = 'helpSupport'.tr;
  String liveChat = 'liveChat'.tr;
  String aboutUs = 'aboutUs'.tr;
  String logout = 'logout'.tr;
  String confirmLogout = 'confirmLogout'.tr;
  String logoutPlain = 'logoutPlain'.tr;
  String chooseLanguage = 'chooseLanguage'.tr;
  String chooseLanguageToProceed = 'chooseLanguageToProceed'.tr;
  String changePassword = 'changePassword'.tr;
  String enterOldPassword = 'enterOldPassword'.tr;
  String updateProfile = 'updateProfile'.tr;
  String darkMode = 'darkMode'.tr;
  String notification = 'notification'.tr;
  String deleteAccount = 'deleteAccount'.tr;
  String deleteAccountExclam = 'deleteAccountExclam'.tr;
  String confirmDeleteAccount = 'confirmDeleteAccount'.tr;
  String enterNewPassword = 'enterNewPassword'.tr;
  String general = 'general'.tr;
  String selectYourCategory = 'Select your category'.tr;
  String slot = 'slot'.tr;
  String food = 'food'.tr;
  String pickup = 'pickup'.tr;
  String orderNowAnything = 'orderNowAnything'.tr;
  String easilyOrder = 'easilyOrder'.tr;
  String reserveYour = 'reserveYour'.tr;
  String editAddress = 'editAddress'.tr;
  String addAddress = 'addAddress'.tr;
  String saveLocation = 'saveLocation'.tr;
  String labelAs = 'labelAs'.tr;
  String contactPersonName = 'contactPersonName'.tr;
  String address = 'address'.tr;
  String additionalAddress = 'additionalAddress'.tr;
  String contactPersonNumber = 'contactPersonNumber'.tr;
  String streetNumberOptional = 'streetNumberOptional'.tr;
  String houseOptional = 'houseOptional'.tr;
  String floorOptional = 'floorOptional'.tr;
  String googleMap = 'googleMap'.tr;

  // Add more strings as needed
}

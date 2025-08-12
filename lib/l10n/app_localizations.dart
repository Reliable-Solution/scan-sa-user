// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart' as intl;

// import 'app_localizations_ar.dart';
// import 'app_localizations_en.dart';

// // ignore_for_file: type=lint

// /// Callers can lookup localized strings with an instance of AppLocalizations
// /// returned by `AppLocalizations.of(context)`.
// ///
// /// Applications need to include `AppLocalizations.delegate()` in their app's
// /// `localizationDelegates` list, and the locales they support in the app's
// /// `supportedLocales` list. For example:
// ///
// /// ```dart
// /// import 'l10n/app_localizations.dart';
// ///
// /// return MaterialApp(
// ///   localizationsDelegates: AppLocalizations.localizationsDelegates,
// ///   supportedLocales: AppLocalizations.supportedLocales,
// ///   home: MyApplicationHome(),
// /// );
// /// ```
// ///
// /// ## Update pubspec.yaml
// ///
// /// Please make sure to update your pubspec.yaml to include the following
// /// packages:
// ///
// /// ```yaml
// /// dependencies:
// ///   # Internationalization support.
// ///   flutter_localizations:
// ///     sdk: flutter
// ///   intl: any # Use the pinned version from flutter_localizations
// ///
// ///   # Rest of dependencies
// /// ```
// ///
// /// ## iOS Applications
// ///
// /// iOS applications define key application metadata, including supported
// /// locales, in an Info.plist file that is built into the application bundle.
// /// To configure the locales supported by your app, you’ll need to edit this
// /// file.
// ///
// /// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
// /// Then, in the Project Navigator, open the Info.plist file under the Runner
// /// project’s Runner folder.
// ///
// /// Next, select the Information Property List item, select Add Item from the
// /// Editor menu, then select Localizations from the pop-up menu.
// ///
// /// Select and expand the newly-created Localizations item then, for each
// /// locale your application supports, add a new item and select the locale
// /// you wish to add from the pop-up menu in the Value field. This list should
// /// be consistent with the languages listed in the AppLocalizations.supportedLocales
// /// property.
// abstract class AppLocalizations {
//   AppLocalizations(String locale)
//     : localeName = intl.Intl.canonicalizedLocale(locale.toString());

//   final String localeName;

//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }

//   static const LocalizationsDelegate<AppLocalizations> delegate =
//       _AppLocalizationsDelegate();

//   /// A list of this localizations delegate along with the default localizations
//   /// delegates.
//   ///
//   /// Returns a list of localizations delegates containing this delegate along with
//   /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
//   /// and GlobalWidgetsLocalizations.delegate.
//   ///
//   /// Additional delegates can be added by appending to this list in
//   /// MaterialApp. This list does not have to be used at all if a custom list
//   /// of delegates is preferred or required.
//   static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
//       <LocalizationsDelegate<dynamic>>[
//         delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ];

//   /// A list of this localizations delegate's supported locales.
//   static const List<Locale> supportedLocales = <Locale>[
//     Locale('ar'),
//     Locale('en'),
//   ];

//   /// No description provided for @welcome.
//   ///
//   /// In ar, this message translates to:
//   /// **'مرحبًا'**
//   String get welcome;

//   /// No description provided for @letsStartWith.
//   ///
//   /// In ar, this message translates to:
//   /// **'لنبدأ بعنوان بريدك الإلكتروني'**
//   String get letsStartWith;

//   /// No description provided for @enterEmail.
//   ///
//   /// In ar, this message translates to:
//   /// **'أدخل البريد الإلكتروني'**
//   String get enterEmail;

//   /// No description provided for @password.
//   ///
//   /// In ar, this message translates to:
//   /// **'كلمة المرور'**
//   String get password;

//   /// No description provided for @rememberMe.
//   ///
//   /// In ar, this message translates to:
//   /// **'تذكرني'**
//   String get rememberMe;

//   /// No description provided for @forgotPasswordQ.
//   ///
//   /// In ar, this message translates to:
//   /// **'هل نسيت كلمة المرور؟'**
//   String get forgotPasswordQ;

//   /// No description provided for @iAgree.
//   ///
//   /// In ar, this message translates to:
//   /// **'أوافق على جميع'**
//   String get iAgree;

//   /// No description provided for @login.
//   ///
//   /// In ar, this message translates to:
//   /// **'تسجيل الدخول'**
//   String get login;

//   /// No description provided for @facebook.
//   ///
//   /// In ar, this message translates to:
//   /// **'فيسبوك'**
//   String get facebook;

//   /// No description provided for @google.
//   ///
//   /// In ar, this message translates to:
//   /// **'جوجل'**
//   String get google;

//   /// No description provided for @apple.
//   ///
//   /// In ar, this message translates to:
//   /// **'أبل'**
//   String get apple;

//   /// No description provided for @donNotHaveAcc.
//   ///
//   /// In ar, this message translates to:
//   /// **'ليس لديك حساب؟'**
//   String get donNotHaveAcc;

//   /// No description provided for @userName.
//   ///
//   /// In ar, this message translates to:
//   /// **'اسم المستخدم'**
//   String get userName;

//   /// No description provided for @phone.
//   ///
//   /// In ar, this message translates to:
//   /// **'رقم الهاتف'**
//   String get phone;

//   /// No description provided for @email.
//   ///
//   /// In ar, this message translates to:
//   /// **'البريد الإلكتروني'**
//   String get email;

//   /// No description provided for @confirmPassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'تأكيد كلمة المرور'**
//   String get confirmPassword;

//   /// No description provided for @referCode.
//   ///
//   /// In ar, this message translates to:
//   /// **'رمز الإحالة (اختياري)'**
//   String get referCode;

//   /// No description provided for @signUp.
//   ///
//   /// In ar, this message translates to:
//   /// **'إنشاء حساب'**
//   String get signUp;

//   /// No description provided for @signIn.
//   ///
//   /// In ar, this message translates to:
//   /// **'تسجيل الدخول'**
//   String get signIn;

//   /// No description provided for @orWith.
//   ///
//   /// In ar, this message translates to:
//   /// **'أو عبر'**
//   String get orWith;

//   /// No description provided for @alreadyHaveAcc.
//   ///
//   /// In ar, this message translates to:
//   /// **'لديك حساب بالفعل؟'**
//   String get alreadyHaveAcc;

//   /// No description provided for @verify.
//   ///
//   /// In ar, this message translates to:
//   /// **'تحقق'**
//   String get verify;

//   /// No description provided for @send.
//   ///
//   /// In ar, this message translates to:
//   /// **'إرسال'**
//   String get send;

//   /// No description provided for @resetPassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'إعادة تعيين كلمة المرور'**
//   String get resetPassword;

//   /// No description provided for @submit.
//   ///
//   /// In ar, this message translates to:
//   /// **'إرسال'**
//   String get submit;

//   /// No description provided for @home.
//   ///
//   /// In ar, this message translates to:
//   /// **'الرئيسية'**
//   String get home;

//   /// No description provided for @search.
//   ///
//   /// In ar, this message translates to:
//   /// **'بحث'**
//   String get search;

//   /// No description provided for @cart.
//   ///
//   /// In ar, this message translates to:
//   /// **'السلة'**
//   String get cart;

//   /// No description provided for @profile.
//   ///
//   /// In ar, this message translates to:
//   /// **'الملف الشخصي'**
//   String get profile;

//   /// No description provided for @checkout.
//   ///
//   /// In ar, this message translates to:
//   /// **'الدفع'**
//   String get checkout;

//   /// No description provided for @placeOrder.
//   ///
//   /// In ar, this message translates to:
//   /// **'تأكيد الطلب'**
//   String get placeOrder;

//   /// No description provided for @deliveryAddress.
//   ///
//   /// In ar, this message translates to:
//   /// **'عنوان التوصيل'**
//   String get deliveryAddress;

//   /// No description provided for @choosePaymentMethod.
//   ///
//   /// In ar, this message translates to:
//   /// **'اختر طريقة الدفع'**
//   String get choosePaymentMethod;

//   /// No description provided for @summary.
//   ///
//   /// In ar, this message translates to:
//   /// **'الملخص'**
//   String get summary;

//   /// No description provided for @itemPrice.
//   ///
//   /// In ar, this message translates to:
//   /// **'سعر المنتج'**
//   String get itemPrice;

//   /// No description provided for @discount.
//   ///
//   /// In ar, this message translates to:
//   /// **'الخصم'**
//   String get discount;

//   /// No description provided for @vatTax.
//   ///
//   /// In ar, this message translates to:
//   /// **'الضريبة'**
//   String get vatTax;

//   /// No description provided for @deliveryFee.
//   ///
//   /// In ar, this message translates to:
//   /// **'رسوم التوصيل'**
//   String get deliveryFee;

//   /// No description provided for @serviceFee.
//   ///
//   /// In ar, this message translates to:
//   /// **'رسوم الخدمة'**
//   String get serviceFee;

//   /// No description provided for @promoCode.
//   ///
//   /// In ar, this message translates to:
//   /// **'رمز الخصم'**
//   String get promoCode;

//   /// No description provided for @enterPromoCode.
//   ///
//   /// In ar, this message translates to:
//   /// **'أدخل رمز الخصم'**
//   String get enterPromoCode;

//   /// No description provided for @apply.
//   ///
//   /// In ar, this message translates to:
//   /// **'تطبيق'**
//   String get apply;

//   /// No description provided for @schedule.
//   ///
//   /// In ar, this message translates to:
//   /// **'الجدولة'**
//   String get schedule;

//   /// No description provided for @today.
//   ///
//   /// In ar, this message translates to:
//   /// **'اليوم'**
//   String get today;

//   /// No description provided for @tomorrow.
//   ///
//   /// In ar, this message translates to:
//   /// **'غدًا'**
//   String get tomorrow;

//   /// No description provided for @instant.
//   ///
//   /// In ar, this message translates to:
//   /// **'فوري'**
//   String get instant;

//   /// No description provided for @privacyPolicy.
//   ///
//   /// In ar, this message translates to:
//   /// **'سياسة الخصوصية'**
//   String get privacyPolicy;

//   /// No description provided for @termsConditions.
//   ///
//   /// In ar, this message translates to:
//   /// **'الشروط والأحكام'**
//   String get termsConditions;

//   /// No description provided for @refundPolicy.
//   ///
//   /// In ar, this message translates to:
//   /// **'سياسة الاسترجاع'**
//   String get refundPolicy;

//   /// No description provided for @and.
//   ///
//   /// In ar, this message translates to:
//   /// **'و'**
//   String get and;

//   /// No description provided for @weJustSent.
//   ///
//   /// In ar, this message translates to:
//   /// **'لقد أرسلنا رمز التحقق'**
//   String get weJustSent;

//   /// No description provided for @enterTheSecurity.
//   ///
//   /// In ar, this message translates to:
//   /// **'أدخل رمز الأمان الذي أرسلناه إلى'**
//   String get enterTheSecurity;

//   /// No description provided for @forgotPassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'نسيت كلمة المرور'**
//   String get forgotPassword;

//   /// No description provided for @checkYourInbox.
//   ///
//   /// In ar, this message translates to:
//   /// **'تحقق من بريدك الوارد! سنرسل رمز التحقق إلى بريدك الإلكتروني المسجل والنشط'**
//   String get checkYourInbox;

//   /// No description provided for @pleaseEnterEmail.
//   ///
//   /// In ar, this message translates to:
//   /// **'يرجى إدخال البريد الإلكتروني'**
//   String get pleaseEnterEmail;

//   /// No description provided for @pleaseEnterValidEmail.
//   ///
//   /// In ar, this message translates to:
//   /// **'يرجى إدخال بريد إلكتروني صالح'**
//   String get pleaseEnterValidEmail;

//   /// No description provided for @pleaseEnterUserName.
//   ///
//   /// In ar, this message translates to:
//   /// **'يرجى إدخال اسم المستخدم'**
//   String get pleaseEnterUserName;

//   /// No description provided for @pleaseEnterPassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'يرجى إدخال كلمة المرور'**
//   String get pleaseEnterPassword;

//   /// No description provided for @passwordShouldBe.
//   ///
//   /// In ar, this message translates to:
//   /// **'يجب أن تكون كلمة المرور أكثر من 8 أحرف'**
//   String get passwordShouldBe;

//   /// No description provided for @pleaseEnterConfirmPassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'يرجى إدخال تأكيد كلمة المرور'**
//   String get pleaseEnterConfirmPassword;

//   /// No description provided for @pleaseEnterPhoneNumber.
//   ///
//   /// In ar, this message translates to:
//   /// **'يرجى إدخال رقم الهاتف'**
//   String get pleaseEnterPhoneNumber;

//   /// No description provided for @invalidPhoneNumber.
//   ///
//   /// In ar, this message translates to:
//   /// **'رقم الهاتف غير صالح'**
//   String get invalidPhoneNumber;

//   /// No description provided for @pleaseEnterOtp.
//   ///
//   /// In ar, this message translates to:
//   /// **'يرجى إدخال رمز التحقق'**
//   String get pleaseEnterOtp;

//   /// No description provided for @justOneStepAway.
//   ///
//   /// In ar, this message translates to:
//   /// **'خطوة واحدة فقط متبقية'**
//   String get justOneStepAway;

//   /// No description provided for @done.
//   ///
//   /// In ar, this message translates to:
//   /// **'تم'**
//   String get done;

//   /// No description provided for @notConnected.
//   ///
//   /// In ar, this message translates to:
//   /// **'غير متصل'**
//   String get notConnected;

//   /// No description provided for @connected.
//   ///
//   /// In ar, this message translates to:
//   /// **'متصل'**
//   String get connected;

//   /// No description provided for @subscribedSuccessfully.
//   ///
//   /// In ar, this message translates to:
//   /// **'تم الاشتراك بنجاح'**
//   String get subscribedSuccessfully;

//   /// No description provided for @pickAddress.
//   ///
//   /// In ar, this message translates to:
//   /// **'اختر العنوان'**
//   String get pickAddress;

//   /// No description provided for @restaurant.
//   ///
//   /// In ar, this message translates to:
//   /// **'مطعم'**
//   String get restaurant;

//   /// No description provided for @restaurants.
//   ///
//   /// In ar, this message translates to:
//   /// **'مطاعم'**
//   String get restaurants;

//   /// No description provided for @cafe.
//   ///
//   /// In ar, this message translates to:
//   /// **'مقهى'**
//   String get cafe;

//   /// No description provided for @dineIn.
//   ///
//   /// In ar, this message translates to:
//   /// **'تناول الطعام في المكان'**
//   String get dineIn;

//   /// No description provided for @sortBy.
//   ///
//   /// In ar, this message translates to:
//   /// **'ترتيب حسب'**
//   String get sortBy;

//   /// No description provided for @popularBrand.
//   ///
//   /// In ar, this message translates to:
//   /// **'العلامات التجارية الشهيرة'**
//   String get popularBrand;

//   /// No description provided for @recommended.
//   ///
//   /// In ar, this message translates to:
//   /// **'موصى به'**
//   String get recommended;

//   /// No description provided for @nearMe.
//   ///
//   /// In ar, this message translates to:
//   /// **'بالقرب مني'**
//   String get nearMe;

//   /// No description provided for @showResult.
//   ///
//   /// In ar, this message translates to:
//   /// **'عرض النتائج'**
//   String get showResult;

//   /// No description provided for @free.
//   ///
//   /// In ar, this message translates to:
//   /// **'مجاني'**
//   String get free;

//   /// No description provided for @deleteCart.
//   ///
//   /// In ar, this message translates to:
//   /// **'حذف السلة'**
//   String get deleteCart;

//   /// No description provided for @deleteCartDescription.
//   ///
//   /// In ar, this message translates to:
//   /// **'سيتم إزالة جميع العناصر. لإضافتها مرة أخرى، يجب بدء سلة جديدة.'**
//   String get deleteCartDescription;

//   /// No description provided for @keepCart.
//   ///
//   /// In ar, this message translates to:
//   /// **'الاحتفاظ بالسلة'**
//   String get keepCart;

//   /// No description provided for @confirmDeleteCart.
//   ///
//   /// In ar, this message translates to:
//   /// **'هل تريد حذف السلة؟'**
//   String get confirmDeleteCart;

//   /// No description provided for @goToCheckout.
//   ///
//   /// In ar, this message translates to:
//   /// **'الانتقال إلى الدفع'**
//   String get goToCheckout;

//   /// No description provided for @yourCart.
//   ///
//   /// In ar, this message translates to:
//   /// **'سلتك'**
//   String get yourCart;

//   /// No description provided for @productFrom.
//   ///
//   /// In ar, this message translates to:
//   /// **'منتج من'**
//   String get productFrom;

//   /// No description provided for @addMoreItems.
//   ///
//   /// In ar, this message translates to:
//   /// **'أضف المزيد من العناصر'**
//   String get addMoreItems;

//   /// No description provided for @itemsAdded.
//   ///
//   /// In ar, this message translates to:
//   /// **'تمت إضافة العناصر'**
//   String get itemsAdded;

//   /// No description provided for @viewCart.
//   ///
//   /// In ar, this message translates to:
//   /// **'عرض السلة'**
//   String get viewCart;

//   /// No description provided for @ratings.
//   ///
//   /// In ar, this message translates to:
//   /// **'التقييمات'**
//   String get ratings;

//   /// No description provided for @items.
//   ///
//   /// In ar, this message translates to:
//   /// **'العناصر'**
//   String get items;

//   /// No description provided for @mealStart.
//   ///
//   /// In ar, this message translates to:
//   /// **'كل وجبة رائعة تبدأ\nبنقرة.'**
//   String get mealStart;

//   /// No description provided for @emptyCartMessage.
//   ///
//   /// In ar, this message translates to:
//   /// **'سلتك فارغة. أضف شيئًا\nمن القائمة'**
//   String get emptyCartMessage;

//   /// No description provided for @browseRestaurants.
//   ///
//   /// In ar, this message translates to:
//   /// **'تصفح المطاعم'**
//   String get browseRestaurants;

//   /// No description provided for @homeDelivery.
//   ///
//   /// In ar, this message translates to:
//   /// **'توصيل إلى المنزل'**
//   String get homeDelivery;

//   /// No description provided for @takeAway.
//   ///
//   /// In ar, this message translates to:
//   /// **'استلام شخصي'**
//   String get takeAway;

//   /// No description provided for @deliveryType.
//   ///
//   /// In ar, this message translates to:
//   /// **'نوع التوصيل'**
//   String get deliveryType;

//   /// No description provided for @charge.
//   ///
//   /// In ar, this message translates to:
//   /// **'المبلغ'**
//   String get charge;

//   /// No description provided for @streetNumber.
//   ///
//   /// In ar, this message translates to:
//   /// **'رقم الشارع'**
//   String get streetNumber;

//   /// No description provided for @house.
//   ///
//   /// In ar, this message translates to:
//   /// **'المنزل'**
//   String get house;

//   /// No description provided for @floor.
//   ///
//   /// In ar, this message translates to:
//   /// **'الطابق'**
//   String get floor;

//   /// No description provided for @preferenceTime.
//   ///
//   /// In ar, this message translates to:
//   /// **'الوقت المفضل'**
//   String get preferenceTime;

//   /// No description provided for @select.
//   ///
//   /// In ar, this message translates to:
//   /// **'اختر'**
//   String get select;

//   /// No description provided for @addNotes.
//   ///
//   /// In ar, this message translates to:
//   /// **'أضف ملاحظات'**
//   String get addNotes;

//   /// No description provided for @gotPromoCode.
//   ///
//   /// In ar, this message translates to:
//   /// **'هل لديك رمز خصم؟'**
//   String get gotPromoCode;

//   /// No description provided for @agreeWith.
//   ///
//   /// In ar, this message translates to:
//   /// **'لقد قرأت ووافقت على'**
//   String get agreeWith;

//   /// No description provided for @choosePayment.
//   ///
//   /// In ar, this message translates to:
//   /// **'اختر طريقة الدفع الخاصة بك'**
//   String get choosePayment;

//   /// No description provided for @promoCodes.
//   ///
//   /// In ar, this message translates to:
//   /// **'رموز الخصم'**
//   String get promoCodes;

//   /// No description provided for @addVoucher.
//   ///
//   /// In ar, this message translates to:
//   /// **'أضف قسيمة +'**
//   String get addVoucher;

//   /// No description provided for @selectPreferenceTime.
//   ///
//   /// In ar, this message translates to:
//   /// **'اختر الوقت المفضل'**
//   String get selectPreferenceTime;

//   /// No description provided for @setANewPass.
//   ///
//   /// In ar, this message translates to:
//   /// **'قم بتعيين كلمة مرور جديدة وواصل رحلتك'**
//   String get setANewPass;

//   /// No description provided for @enterNewPass.
//   ///
//   /// In ar, this message translates to:
//   /// **'أدخل كلمة مرور جديدة'**
//   String get enterNewPass;

//   /// No description provided for @myAddress.
//   ///
//   /// In ar, this message translates to:
//   /// **'عنواني'**
//   String get myAddress;

//   /// No description provided for @language.
//   ///
//   /// In ar, this message translates to:
//   /// **'اللغة'**
//   String get language;

//   /// No description provided for @promotionalActivity.
//   ///
//   /// In ar, this message translates to:
//   /// **'النشاط الترويجي'**
//   String get promotionalActivity;

//   /// No description provided for @coupon.
//   ///
//   /// In ar, this message translates to:
//   /// **'قسيمة'**
//   String get coupon;

//   /// No description provided for @loyalPoints.
//   ///
//   /// In ar, this message translates to:
//   /// **'نقاط الولاء'**
//   String get loyalPoints;

//   /// No description provided for @threePoints.
//   ///
//   /// In ar, this message translates to:
//   /// **'نقاط'**
//   String get threePoints;

//   /// No description provided for @myWallet.
//   ///
//   /// In ar, this message translates to:
//   /// **'محفظتي'**
//   String get myWallet;

//   /// No description provided for @earning.
//   ///
//   /// In ar, this message translates to:
//   /// **'الأرباح'**
//   String get earning;

//   /// No description provided for @joinAsDeliveryMan.
//   ///
//   /// In ar, this message translates to:
//   /// **'انضم كعامل توصيل'**
//   String get joinAsDeliveryMan;

//   /// No description provided for @openVendor.
//   ///
//   /// In ar, this message translates to:
//   /// **'فتح كبائع'**
//   String get openVendor;

//   /// No description provided for @helpSupport.
//   ///
//   /// In ar, this message translates to:
//   /// **'المساعدة والدعم'**
//   String get helpSupport;

//   /// No description provided for @liveChat.
//   ///
//   /// In ar, this message translates to:
//   /// **'الدردشة المباشرة'**
//   String get liveChat;

//   /// No description provided for @aboutUs.
//   ///
//   /// In ar, this message translates to:
//   /// **'من نحن'**
//   String get aboutUs;

//   /// No description provided for @logout.
//   ///
//   /// In ar, this message translates to:
//   /// **'تسجيل الخروج!'**
//   String get logout;

//   /// No description provided for @confirmLogout.
//   ///
//   /// In ar, this message translates to:
//   /// **'هل أنت متأكد أنك تريد تسجيل الخروج؟'**
//   String get confirmLogout;

//   /// No description provided for @logoutPlain.
//   ///
//   /// In ar, this message translates to:
//   /// **'تسجيل الخروج'**
//   String get logoutPlain;

//   /// No description provided for @chooseLanguage.
//   ///
//   /// In ar, this message translates to:
//   /// **'اختر لغتك'**
//   String get chooseLanguage;

//   /// No description provided for @chooseLanguageToProceed.
//   ///
//   /// In ar, this message translates to:
//   /// **'اختر لغتك للمتابعة'**
//   String get chooseLanguageToProceed;

//   /// No description provided for @changePassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'تغيير كلمة المرور'**
//   String get changePassword;

//   /// No description provided for @enterOldPassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'أدخل كلمة المرور القديمة'**
//   String get enterOldPassword;

//   /// No description provided for @updateProfile.
//   ///
//   /// In ar, this message translates to:
//   /// **'تحديث الملف الشخصي'**
//   String get updateProfile;

//   /// No description provided for @darkMode.
//   ///
//   /// In ar, this message translates to:
//   /// **'الوضع الداكن'**
//   String get darkMode;

//   /// No description provided for @notification.
//   ///
//   /// In ar, this message translates to:
//   /// **'الإشعارات'**
//   String get notification;

//   /// No description provided for @deleteAccount.
//   ///
//   /// In ar, this message translates to:
//   /// **'حذف الحساب'**
//   String get deleteAccount;

//   /// No description provided for @deleteAccountExclam.
//   ///
//   /// In ar, this message translates to:
//   /// **'حذف الحساب!'**
//   String get deleteAccountExclam;

//   /// No description provided for @confirmDeleteAccount.
//   ///
//   /// In ar, this message translates to:
//   /// **'هل أنت متأكد أنك تريد حذف الحساب؟'**
//   String get confirmDeleteAccount;

//   /// No description provided for @enterNewPassword.
//   ///
//   /// In ar, this message translates to:
//   /// **'أدخل كلمة مرور جديدة'**
//   String get enterNewPassword;

//   /// No description provided for @general.
//   ///
//   /// In ar, this message translates to:
//   /// **'عام'**
//   String get general;
// }

// class _AppLocalizationsDelegate
//     extends LocalizationsDelegate<AppLocalizations> {
//   const _AppLocalizationsDelegate();

//   @override
//   Future<AppLocalizations> load(Locale locale) {
//     return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
//   }

//   @override
//   bool isSupported(Locale locale) =>
//       <String>['ar', 'en'].contains(locale.languageCode);

//   @override
//   bool shouldReload(_AppLocalizationsDelegate old) => false;
// }

// AppLocalizations lookupAppLocalizations(Locale locale) {
//   // Lookup logic when only language code is specified.
//   switch (locale.languageCode) {
//     case 'ar':
//       return AppLocalizationsAr();
//     case 'en':
//       return AppLocalizationsEn();
//   }

//   throw FlutterError(
//     'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
//     'an issue with the localizations generation tool. Please file an issue '
//     'on GitHub with a reproducible sample app and the gen-l10n configuration '
//     'that was used.',
//   );
// }

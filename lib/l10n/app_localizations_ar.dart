// // ignore: unused_import
// import 'package:intl/intl.dart' as intl;
// import 'app_localizations.dart';

// // ignore_for_file: type=lint

// /// The translations for Arabic (`ar`).
// class AppLocalizationsAr extends AppLocalizations {
//   AppLocalizationsAr([String locale = 'ar']) : super(locale);

//   @override
//   String get welcome => 'مرحبًا';

//   @override
//   String get letsStartWith => 'لنبدأ بعنوان بريدك الإلكتروني';

//   @override
//   String get enterEmail => 'أدخل البريد الإلكتروني';

//   @override
//   String get password => 'كلمة المرور';

//   @override
//   String get rememberMe => 'تذكرني';

//   @override
//   String get forgotPasswordQ => 'هل نسيت كلمة المرور؟';

//   @override
//   String get iAgree => 'أوافق على جميع';

//   @override
//   String get login => 'تسجيل الدخول';

//   @override
//   String get facebook => 'فيسبوك';

//   @override
//   String get google => 'جوجل';

//   @override
//   String get apple => 'أبل';

//   @override
//   String get donNotHaveAcc => 'ليس لديك حساب؟';

//   @override
//   String get userName => 'اسم المستخدم';

//   @override
//   String get phone => 'رقم الهاتف';

//   @override
//   String get email => 'البريد الإلكتروني';

//   @override
//   String get confirmPassword => 'تأكيد كلمة المرور';

//   @override
//   String get referCode => 'رمز الإحالة (اختياري)';

//   @override
//   String get signUp => 'إنشاء حساب';

//   @override
//   String get signIn => 'تسجيل الدخول';

//   @override
//   String get orWith => 'أو عبر';

//   @override
//   String get alreadyHaveAcc => 'لديك حساب بالفعل؟';

//   @override
//   String get verify => 'تحقق';

//   @override
//   String get send => 'إرسال';

//   @override
//   String get resetPassword => 'إعادة تعيين كلمة المرور';

//   @override
//   String get submit => 'إرسال';

//   @override
//   String get home => 'الرئيسية';

//   @override
//   String get search => 'بحث';

//   @override
//   String get cart => 'السلة';

//   @override
//   String get profile => 'الملف الشخصي';

//   @override
//   String get checkout => 'الدفع';

//   @override
//   String get placeOrder => 'تأكيد الطلب';

//   @override
//   String get deliveryAddress => 'عنوان التوصيل';

//   @override
//   String get choosePaymentMethod => 'اختر طريقة الدفع';

//   @override
//   String get summary => 'الملخص';

//   @override
//   String get itemPrice => 'سعر المنتج';

//   @override
//   String get discount => 'الخصم';

//   @override
//   String get vatTax => 'الضريبة';

//   @override
//   String get deliveryFee => 'رسوم التوصيل';

//   @override
//   String get serviceFee => 'رسوم الخدمة';

//   @override
//   String get promoCode => 'رمز الخصم';

//   @override
//   String get enterPromoCode => 'أدخل رمز الخصم';

//   @override
//   String get apply => 'تطبيق';

//   @override
//   String get schedule => 'الجدولة';

//   @override
//   String get today => 'اليوم';

//   @override
//   String get tomorrow => 'غدًا';

//   @override
//   String get instant => 'فوري';

//   @override
//   String get privacyPolicy => 'سياسة الخصوصية';

//   @override
//   String get termsConditions => 'الشروط والأحكام';

//   @override
//   String get refundPolicy => 'سياسة الاسترجاع';

//   @override
//   String get and => 'و';

//   @override
//   String get weJustSent => 'لقد أرسلنا رمز التحقق';

//   @override
//   String get enterTheSecurity => 'أدخل رمز الأمان الذي أرسلناه إلى';

//   @override
//   String get forgotPassword => 'نسيت كلمة المرور';

//   @override
//   String get checkYourInbox =>
//       'تحقق من بريدك الوارد! سنرسل رمز التحقق إلى بريدك الإلكتروني المسجل والنشط';

//   @override
//   String get pleaseEnterEmail => 'يرجى إدخال البريد الإلكتروني';

//   @override
//   String get pleaseEnterValidEmail => 'يرجى إدخال بريد إلكتروني صالح';

//   @override
//   String get pleaseEnterUserName => 'يرجى إدخال اسم المستخدم';

//   @override
//   String get pleaseEnterPassword => 'يرجى إدخال كلمة المرور';

//   @override
//   String get passwordShouldBe => 'يجب أن تكون كلمة المرور أكثر من 8 أحرف';

//   @override
//   String get pleaseEnterConfirmPassword => 'يرجى إدخال تأكيد كلمة المرور';

//   @override
//   String get pleaseEnterPhoneNumber => 'يرجى إدخال رقم الهاتف';

//   @override
//   String get invalidPhoneNumber => 'رقم الهاتف غير صالح';

//   @override
//   String get pleaseEnterOtp => 'يرجى إدخال رمز التحقق';

//   @override
//   String get justOneStepAway => 'خطوة واحدة فقط متبقية';

//   @override
//   String get done => 'تم';

//   @override
//   String get notConnected => 'غير متصل';

//   @override
//   String get connected => 'متصل';

//   @override
//   String get subscribedSuccessfully => 'تم الاشتراك بنجاح';

//   @override
//   String get pickAddress => 'اختر العنوان';

//   @override
//   String get restaurant => 'مطعم';

//   @override
//   String get restaurants => 'مطاعم';

//   @override
//   String get cafe => 'مقهى';

//   @override
//   String get dineIn => 'تناول الطعام في المكان';

//   @override
//   String get sortBy => 'ترتيب حسب';

//   @override
//   String get popularBrand => 'العلامات التجارية الشهيرة';

//   @override
//   String get recommended => 'موصى به';

//   @override
//   String get nearMe => 'بالقرب مني';

//   @override
//   String get showResult => 'عرض النتائج';

//   @override
//   String get free => 'مجاني';

//   @override
//   String get deleteCart => 'حذف السلة';

//   @override
//   String get deleteCartDescription =>
//       'سيتم إزالة جميع العناصر. لإضافتها مرة أخرى، يجب بدء سلة جديدة.';

//   @override
//   String get keepCart => 'الاحتفاظ بالسلة';

//   @override
//   String get confirmDeleteCart => 'هل تريد حذف السلة؟';

//   @override
//   String get goToCheckout => 'الانتقال إلى الدفع';

//   @override
//   String get yourCart => 'سلتك';

//   @override
//   String get productFrom => 'منتج من';

//   @override
//   String get addMoreItems => 'أضف المزيد من العناصر';

//   @override
//   String get itemsAdded => 'تمت إضافة العناصر';

//   @override
//   String get viewCart => 'عرض السلة';

//   @override
//   String get ratings => 'التقييمات';

//   @override
//   String get items => 'العناصر';

//   @override
//   String get mealStart => 'كل وجبة رائعة تبدأ\nبنقرة.';

//   @override
//   String get emptyCartMessage => 'سلتك فارغة. أضف شيئًا\nمن القائمة';

//   @override
//   String get browseRestaurants => 'تصفح المطاعم';

//   @override
//   String get homeDelivery => 'توصيل إلى المنزل';

//   @override
//   String get takeAway => 'استلام شخصي';

//   @override
//   String get deliveryType => 'نوع التوصيل';

//   @override
//   String get charge => 'المبلغ';

//   @override
//   String get streetNumber => 'رقم الشارع';

//   @override
//   String get house => 'المنزل';

//   @override
//   String get floor => 'الطابق';

//   @override
//   String get preferenceTime => 'الوقت المفضل';

//   @override
//   String get select => 'اختر';

//   @override
//   String get addNotes => 'أضف ملاحظات';

//   @override
//   String get gotPromoCode => 'هل لديك رمز خصم؟';

//   @override
//   String get agreeWith => 'لقد قرأت ووافقت على';

//   @override
//   String get choosePayment => 'اختر طريقة الدفع الخاصة بك';

//   @override
//   String get promoCodes => 'رموز الخصم';

//   @override
//   String get addVoucher => 'أضف قسيمة +';

//   @override
//   String get selectPreferenceTime => 'اختر الوقت المفضل';

//   @override
//   String get setANewPass => 'قم بتعيين كلمة مرور جديدة وواصل رحلتك';

//   @override
//   String get enterNewPass => 'أدخل كلمة مرور جديدة';

//   @override
//   String get myAddress => 'عنواني';

//   @override
//   String get language => 'اللغة';

//   @override
//   String get promotionalActivity => 'النشاط الترويجي';

//   @override
//   String get coupon => 'قسيمة';

//   @override
//   String get loyalPoints => 'نقاط الولاء';

//   @override
//   String get threePoints => 'نقاط';

//   @override
//   String get myWallet => 'محفظتي';

//   @override
//   String get earning => 'الأرباح';

//   @override
//   String get joinAsDeliveryMan => 'انضم كعامل توصيل';

//   @override
//   String get openVendor => 'فتح كبائع';

//   @override
//   String get helpSupport => 'المساعدة والدعم';

//   @override
//   String get liveChat => 'الدردشة المباشرة';

//   @override
//   String get aboutUs => 'من نحن';

//   @override
//   String get logout => 'تسجيل الخروج!';

//   @override
//   String get confirmLogout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

//   @override
//   String get logoutPlain => 'تسجيل الخروج';

//   @override
//   String get chooseLanguage => 'اختر لغتك';

//   @override
//   String get chooseLanguageToProceed => 'اختر لغتك للمتابعة';

//   @override
//   String get changePassword => 'تغيير كلمة المرور';

//   @override
//   String get enterOldPassword => 'أدخل كلمة المرور القديمة';

//   @override
//   String get updateProfile => 'تحديث الملف الشخصي';

//   @override
//   String get darkMode => 'الوضع الداكن';

//   @override
//   String get notification => 'الإشعارات';

//   @override
//   String get deleteAccount => 'حذف الحساب';

//   @override
//   String get deleteAccountExclam => 'حذف الحساب!';

//   @override
//   String get confirmDeleteAccount => 'هل أنت متأكد أنك تريد حذف الحساب؟';

//   @override
//   String get enterNewPassword => 'أدخل كلمة مرور جديدة';

//   @override
//   String get general => 'عام';
// }

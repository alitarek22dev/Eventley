import 'package:flutter/material.dart';

import 'app_settings.dart';

class AppStrings {
  AppStrings(this.locale);

  final Locale locale;

  bool get _isAr => locale.languageCode == 'ar';
  bool get isArabic => _isAr;

  factory AppStrings.of(BuildContext context) {
    return AppStrings(SettingsScope.of(context).locale);
  }

  String get addNewEvent => _isAr ? 'إضافة فعالية جديدة' : 'Add New Event';

  String get language => _isAr ? 'اللغة' : 'Language';


  String get letsStart => _isAr ? 'لنبدأ' : "Let's Start";

  String get next => _isAr ? 'التالي' : 'Next';

  String get getStarted => _isAr ? 'ابدأ الآن' : 'Get started';

  String get home => _isAr ? 'الرئيسية' : 'Home';

  String get personalizeTitle =>
      _isAr ? 'خصص تجربتك' : 'Personalize Your Experience';

  String get personalizeBody => _isAr
      ? 'اختر السمة واللغة المفضلة لديك للبدء في تجربة مريحة ومصممة خصيصًا تناسب أسلوبك.'
      : 'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.';

  String get findEventsTitle =>
      _isAr ? 'ابحث عن الفعاليات التي تلهمك' : 'Find Events That Inspire You';

  String get findEventsBody => _isAr
      ? 'انغمس في عالم من الفعاليات المصممة لتناسب اهتماماتك الفريدة. سواء كنت من محبي الموسيقى الحية أو المعارض الفنية أو لقاءات التكنولوجيا أو مجرد اكتشاف تجارب جديدة، لدينا ما يناسب الجميع. ستساعدك توصياتنا المختارة على الاستكشاف والتواصل والاستفادة من كل فرصة حولك.'
      : "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art shows, technology meetups, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.";

  String get planningTitle =>
      _isAr ? 'تخطيط سهل للفعاليات' : 'Effortless Event Planning';

  String get planningBody => _isAr
      ? 'تخلص من عناء تنظيم الفعاليات باستخدام أدوات التخطيط الشاملة لدينا. من إعداد الدعوات وإدارة الردود إلى جدولة التذكيرات وتنسيق التفاصيل، نحن نوفر لك كل ما تحتاجه. خطط بسهولة وركز على ما يهم – خلق تجربة لا تُنسى لك ولضيوفك.'
      : "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we've got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.";

  String get connectTitle => _isAr
      ? 'تواصل مع الأصدقاء وشارك اللحظات'
      : 'Connect with Friends & Share Moments';

  String get connectBody => _isAr
      ? 'اجعل كل فعالية لا تُنسى من خلال مشاركة التجربة مع الآخرين. تتيح لك منصتنا دعوة الأصدقاء وإبقاء الجميع على اطلاع والاحتفال باللحظات معًا. التقط الإثارة وشاركها مع شبكتك لتعيش أبرز اللحظات مجددًا وتبني علاقات أقوى.'
      : 'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and build stronger connections.';

  String get loginToYourAccount =>
      _isAr ? 'تسجيل الدخول إلى حسابك' : 'Login to your account';

  String get email => _isAr ? 'البريد الإلكتروني' : 'Email';

  String get enterYourEmail =>
      _isAr ? 'أدخل بريدك الإلكتروني' : 'Enter your email';

  String get password => _isAr ? 'كلمة المرور' : 'Password';

  String get enterYourPassword =>
      _isAr ? 'أدخل كلمة المرور' : 'Enter your password';

  String get forgotPassword =>
      _isAr ? 'نسيت كلمة المرور؟' : 'Forgot Password?';

  String get login => _isAr ? 'تسجيل الدخول' : 'Login';

  String get dontHaveAccount =>
      _isAr ? 'ليس لديك حساب؟ ' : "Don't have an account? ";

  String get signUp => _isAr ? 'إنشاء حساب' : 'Signup';

  String get signUpButton => _isAr ? 'إنشاء حساب' : 'Sign up';

  String get or => _isAr ? 'أو' : 'Or';


  String get loginWithGoogle =>
      _isAr ? 'تسجيل الدخول عبر Google' : 'Login With Google';

  String get emailRequired =>
      _isAr ? 'يرجى إدخال البريد الإلكتروني' : 'Please enter your email';

  String get invalidEmail =>
      _isAr ? 'يرجى إدخال بريد إلكتروني صالح' : 'Please enter a valid email';

  String get passwordRequired =>
      _isAr ? 'يرجى إدخال كلمة المرور' : 'Please enter your password';

  String get passwordTooShort => _isAr
      ? 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل'
      : 'Password must be at least 6 characters';

  String get googleSignInNotConfigured => _isAr
      ? 'تسجيل الدخول عبر Google غير متاح حاليًا'
      : 'Google Sign-In is not configured yet';

  String get createYourAccount =>
      _isAr ? 'إنشاء حسابك' : 'Create your account';

  String get name => _isAr ? 'الاسم' : 'Name';

  String get enterYourName =>
      _isAr ? 'أدخل اسمك' : 'Enter your name';

  String get confirmPassword =>
      _isAr ? 'تأكيد كلمة المرور' : 'Confirm password';

  String get confirmYourPassword =>
      _isAr ? 'أكد كلمة المرور' : 'Confirm your password';

  String get alreadyHaveAccount =>
      _isAr ? 'لديك حساب بالفعل؟ ' : 'Already have an account? ';

  String get signUpWithGoogle =>
      _isAr ? 'إنشاء حساب عبر Google' : 'Sign up with Google';

  String get nameRequired =>
      _isAr ? 'يرجى إدخال الاسم' : 'Please enter your name';

  String get confirmPasswordRequired =>
      _isAr ? 'يرجى تأكيد كلمة المرور' : 'Please confirm your password';

  String get passwordsDoNotMatch =>
      _isAr ? 'كلمات المرور غير متطابقة' : 'Passwords do not match';

  String get signUpSuccess =>
      _isAr ? 'تم إنشاء الحساب بنجاح' : 'Account created successfully';

  String get forgetPasswordTitle =>
      _isAr ? 'نسيت كلمة المرور' : 'Forget Password';

  String get resetPassword =>
      _isAr ? 'إعادة تعيين كلمة المرور' : 'Reset password';

  String get resetPasswordInstructions => _isAr
      ? 'أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور'
      : 'Enter your email to reset password';

  String get resetPasswordEmailSent => _isAr
      ? 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني'
      : 'Password reset link sent to your email';

  // Navigation tabs
  String get favorites => _isAr ? 'المفضلة' : 'Favorites';
  String get profile => _isAr ? 'الملف الشخصي' : 'Profile';

  // Home screen
  String get welcomeBack => _isAr ? 'مرحبًا بك' : 'Welcome Back';
  String get userNamePlaceholder => _isAr ? 'جون صفوت' : 'Ali Tarek';
  String get userEmailPlaceholder => 'alitarek@gmail.com';
  String get cairoEgypt => _isAr ? 'القاهرة، مصر' : 'Cairo, Egypt';
  String get searchForEvent => _isAr ? 'البحث عن فعالية' : 'Search for Event';

  // Categories
  String get all => _isAr ? 'الكل' : 'All';
  String get sport => _isAr ? 'رياضة' : 'Sport';
  String get bookClub => _isAr ? 'نادي الكتاب' : 'Book Club';
  String get birthday => _isAr ? 'عيد ميلاد' : 'Birthday';
  String get meeting => _isAr ? 'اجتماع' : 'Meeting';
  String get exhibition => _isAr ? 'معرض' : 'Exhibition';

  // Events descriptions & titles
  String get birthdayPartyTitle =>
      _isAr ? 'حفلة عيد ميلاد مميزة' : 'This is a Birthday Party';
  String get meetingTitle => _isAr
      ? 'اجتماع لمناقشة تطوير المشروع'
      : 'Meeting for updating the development method';
  String get exhibitionTitle => _isAr
      ? 'معرض فنون فريد من نوعه لعشاق الإبداع'
      : 'Exhibition unique art for everyone';
  String get bookClubTitle => _isAr
      ? 'نادي القراءة لمناقشة الكتب المميزة'
      : 'Book club meeting for reading enthusiasts';
  String get sportEventTitle =>
      _isAr ? 'يوم رياضي وبطولة كرة قدم' : 'Sports day and football tournament';

  // Favorites screen
  String get noFavoritesYet =>
      _isAr ? 'لا توجد فعاليات في المفضلة بعد' : 'No favorite events yet';
  String get noFavoritesSub => _isAr
      ? 'انقر على رمز القلب في أي فعالية لإضافتها إلى المفضلة'
      : 'Tap the heart icon on any event to add it to your favorites';
  String get searchFavoriteEvents =>
      _isAr ? 'البحث في الفعاليات المفضلة' : 'Search for Event';
  String get noEventsFound => _isAr
      ? 'لم يتم العثور على أي فعاليات'
      : 'No events found matching your search';

  // Profile screen
  String get darkMode => _isAr ? 'الوضع الداكن' : 'Dark Mode';
  String get logout => _isAr ? 'تسجيل الخروج' : 'Logout';
  String get arabic => _isAr ? 'العربية' : 'Arabic';
  String get english => _isAr ? 'الإنجليزية' : 'English';

  // Add Event Screen
  String get createEvent => _isAr ? 'إنشاء فعالية' : 'Create Event';
  String get eventTitle => _isAr ? 'عنوان الفعالية' : 'Event Title';
  String get enterEventTitle =>
      _isAr ? 'أدخل عنوان الفعالية' : 'Enter event title';
  String get eventTitleRequired =>
      _isAr ? 'يرجى إدخال عنوان الفعالية' : 'Please enter event title';
  String get description => _isAr ? 'الوصف' : 'Description';
  String get enterDescription =>
      _isAr ? 'أدخل وصف الفعالية' : 'Enter event description';
  String get descriptionRequired =>
      _isAr ? 'يرجى إدخال وصف الفعالية' : 'Please enter event description';
  String get eventDate => _isAr ? 'تاريخ الفعالية' : 'Event Date';
  String get chooseDate => _isAr ? 'اختر التاريخ' : 'Choose Date';
  String get dateRequired =>
      _isAr ? 'يرجى اختيار التاريخ' : 'Please choose a date';
  String get eventTime => _isAr ? 'وقت الفعالية' : 'Event Time';
  String get chooseTime => _isAr ? 'اختر الوقت' : 'Choose Time';
  String get location => _isAr ? 'الموقع' : 'Location';
  String get chooseEventLocation =>
      _isAr ? 'اختر موقع الفعالية' : 'Choose Event Location';
  String get locationRequired =>
      _isAr ? 'يرجى اختيار موقع الفعالية' : 'Please choose event location';
  String get category => _isAr ? 'الفئة' : 'Category';
  String get selectEventImage =>
      _isAr ? 'صورة الفعالية' : 'Event Image';
  String get eventCreatedSuccessfully =>
      _isAr ? 'تم إنشاء الفعالية بنجاح' : 'Event created successfully';

  // Authentication error messages
  String get emailAlreadyInUse => _isAr
      ? 'هذا البريد الإلكتروني مستخدم بالفعل'
      : 'This email is already registered';
  String get weakPassword => _isAr
      ? 'كلمة المرور ضعيفة جدًا'
      : 'The password provided is too weak';
  String get invalidEmailOrPassword => _isAr
      ? 'البريد الإلكتروني أو كلمة المرور غير صحيحة'
      : 'Invalid email or password';
  String get userNotFound => _isAr
      ? 'لم يتم العثور على حساب بهذا البريد'
      : 'No account found with this email';
  String get userDisabled =>
      _isAr ? 'تم تعطيل هذا الحساب' : 'This account has been disabled';
  String get tooManyRequests => _isAr
      ? 'محاولات كثيرة خاطئة، يرجى المحاولة لاحقًا'
      : 'Too many attempts, please try again later';
  String get networkError => _isAr
      ? 'حدث خطأ في الاتصال بالشبكة'
      : 'A network error occurred. Please check your connection';
  String get googleSignInFailed =>
      _isAr ? 'فشل تسجيل الدخول عبر Google' : 'Google Sign-In failed';
  String get googleSignInCancelled =>
      _isAr ? 'تم إلغاء تسجيل الدخول عبر Google' : 'Google Sign-In was cancelled';
  String get signOutFailed =>
      _isAr ? 'فشل تسجيل الخروج، يرجى المحاولة مرة أخرى' : 'Sign out failed, please try again';
  String get authenticationFailed =>
      _isAr ? 'فشلت عملية المصادقة، يرجى المحاولة مرة أخرى' : 'Authentication failed, please try again';
}






import 'package:flutter/material.dart';

import 'app_settings.dart';

class AppStrings {
  AppStrings(this.locale);

  final Locale locale;

  bool get _isAr => locale.languageCode == 'ar';

  factory AppStrings.of(BuildContext context) {
    return AppStrings(SettingsScope.of(context).locale);
  }

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
}



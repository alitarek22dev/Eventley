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
}

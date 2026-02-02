// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get onboarding_1_title => 'مرحباً بك في LifeLink';

  @override
  String get onboarding_1_subTitle => 'تطبيق ذكي للتبرع بالدم';

  @override
  String get onboarding_1_desc_1 =>
      'ربط المتبرعين بالمحتاجين، وإنقاذ الأرواح من خلال كل تبرع.';

  @override
  String get onboarding_2_title => 'المشكلة';

  @override
  String get onboarding_2_subTitle => 'التحديات الحالية';

  @override
  String get onboarding_2_desc_1 =>
      'صعوبة العثور على المتبرعين بسرعة في حالات الطوارئ';

  @override
  String get onboarding_2_desc_2 => 'لا يوجد قاعدة بيانات مركزية للمتبرعين';

  @override
  String get onboarding_2_desc_3 => 'نقص الحافز للتبرع المتكرر';

  @override
  String get onboarding_3_title => 'الحل';

  @override
  String get onboarding_3_subTitle => 'مميزاتنا';

  @override
  String get onboarding_3_desc_1 => 'مطابقة المتبرعين بسرعة باستخدام GPS';

  @override
  String get onboarding_3_desc_2 => 'إشعارات فورية للطوارئ';

  @override
  String get onboarding_3_desc_3 => 'نظام مكافآت للمتبرعين';

  @override
  String get onboarding_4_title => 'اصنع فرقاً';

  @override
  String get onboarding_4_subTitle => 'انضم إلى مجتمعنا';

  @override
  String get onboarding_4_desc_1 =>
      'كل تبرع يمكن أن ينقذ حتى 3 أرواح. كن بطلاً في مجتمعك.';

  @override
  String get button_skip => 'تخطي';

  @override
  String get button_back => 'رجوع';

  @override
  String get button_next => 'التالي';

  @override
  String get button_get_started => 'ابدأ الآن';

  @override
  String get choose_role_title => 'اختر دورك';

  @override
  String get choose_role_subTitle => 'كيف تريد استخدام LifeLink؟';

  @override
  String get role_blood_donor_title => 'متبرع بالدم';

  @override
  String get role_blood_donor_desc =>
      'سجل كمتبرع، تتبع التبرعات، واحصل على مكافآت';

  @override
  String get role_blood_donor_button => 'استمر كمتبرع بالدم';

  @override
  String get role_hospital_title => 'مستشفى / مريض';

  @override
  String get role_hospital_desc =>
      'اطلب الدم، اعثر على المتبرعين القريبين، إدارة الطلبات';

  @override
  String get role_hospital_button => 'استمر كمستشفى / مريض';

  @override
  String get role_admin_title => 'المسؤول';

  @override
  String get role_admin_desc =>
      'إدارة المستخدمين، متابعة التبرعات، الإشراف على النظام';

  @override
  String get role_admin_button => 'استمر كمسؤول';
}

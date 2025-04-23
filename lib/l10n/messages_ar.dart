// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SAr extends S {
  SAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Book Listing App';

  @override
  String get an_error_occurred => 'حدث خطأ أثناء تحميل التطبيق';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get no_books_found => 'لا توجد كتب متاحة';

  @override
  String get search => 'بحث';

  @override
  String get search_books => 'ابحث عن كتب';

  @override
  String get see_more => 'عرض المزيد';

  @override
  String get see_less => 'عرض أقل';
}

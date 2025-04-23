// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'messages.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Book Listing App';

  @override
  String get an_error_occurred => 'An error occurred while loading the app';

  @override
  String get retry => 'Retry';

  @override
  String get no_books_found => 'No books available';

  @override
  String get search => 'Search';

  @override
  String get search_books => 'Search for books';

  @override
  String get see_more => 'See more';

  @override
  String get see_less => 'See less';
}

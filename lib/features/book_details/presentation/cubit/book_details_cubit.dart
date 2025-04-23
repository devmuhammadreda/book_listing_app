import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitial());
}

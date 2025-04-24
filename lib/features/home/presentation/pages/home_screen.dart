import 'package:book_listing_app/core/extensions/build_context.dart';
import 'package:book_listing_app/core/extensions/widget.dart';
import 'package:book_listing_app/core/widgets/app_spacer.dart';
import 'package:book_listing_app/core/widgets/custom_error_widget.dart';
import 'package:book_listing_app/core/widgets/custom_text_field.dart';
import 'package:book_listing_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/debouncer.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../domain/entities/results_entity.dart';
import '../cubit/home_cubit.dart';
import '../widgets/book_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _searchDebouncer =
      Debouncer(delay: const Duration(milliseconds: 500));
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _setupScrollController();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      final state = context.read<HomeCubit>().state;
      bool hasMorePages = false;

      if (state is BooksLoaded) {
        hasMorePages = state.hasMorePages;
      }
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          hasMorePages) {
        context.read<HomeCubit>().loadMoreBooks();
      }
    });
  }

  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; 
      } else {
        _expandedIndex = index;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _searchDebouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.appName),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: _searchController,
            hint: context.translate.search_books,
            onChange: (value) {
              _searchDebouncer.call(() {
                context.read<HomeCubit>().searchBooks(value);
              });
            },
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<HomeCubit>().clearFilters();
              },
            ),
          ).paddingAll(20.sp),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial || state is BooksLoading) {
                  return const LoadingWidget(withMaterial: true);
                }

                if (state is BooksError) {
                  return CustomErrorWidget(
                    error: state.message,
                    withMaterial: true,
                    onPressed: () {
                      context.read<HomeCubit>().refreshBooks();
                    },
                  );
                }

                List<ResultsEntity> books = [];
                bool isLoadingMore = false;
                String? error;

                if (state is BooksLoaded) {
                  books = state.books;
                  error = state.error;
                } else if (state is BooksLoadingMore) {
                  books = state.books;
                  isLoadingMore = true;
                }

                if (books.isEmpty && state is! BooksLoadingMore) {
                  return EmptyWidget(
                    msg: context.translate.no_books_found,
                    withMaterial: true,
                  );
                }

                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    await context.read<HomeCubit>().refreshBooks();
                  },
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp,
                      vertical: 10.sp,
                    ),
                    separatorBuilder: (context, index) => AppSpacer(),
                    itemCount: books.length +
                        (isLoadingMore ? 1 : 0) +
                        (error != null ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < books.length) {
                        return BookItem(
                          book: books[index],
                          isExpanded: _expandedIndex == index,
                          onToggle: () => _toggleExpansion(index),
                          heroTag: 'book_item_${books[index].id}',
                        );
                      } else if (isLoadingMore && index == books.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0.sp),
                          child: const LoadingWidget(),
                        );
                      } else if (error != null) {
                        return CustomErrorWidget(
                          error: error,
                          showImage: false,
                          onPressed: () {
                            context.read<HomeCubit>().loadMoreBooks();
                          },
                        );
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

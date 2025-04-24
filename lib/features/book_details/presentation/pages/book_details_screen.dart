// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_listing_app/core/extensions/build_context.dart';
import 'package:book_listing_app/core/theme/text_styles.dart';
import 'package:book_listing_app/core/widgets/app_spacer.dart';
import 'package:book_listing_app/core/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/domain/entities/results_entity.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.book,
    required this.heroTag,
  });
  final ResultsEntity book;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title ?? "",
          style: TextStyles.regular14.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: heroTag,
              child: MainNetworkImage(
                imageUrl: book.formats?.imageJpeg ?? "",
                width: context.screenWidth,
                height: context.screenHeight / 4,
                fit: BoxFit.cover,
              ),
            ),
            AppSpacer(),
            Text(book.title ?? '', style: TextStyles.bold16),
            AppSpacer(heightRatio: .5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    book.authors
                            ?.map((author) =>
                                "${author.name ?? ''} (${author.birthYear ?? ""} - ${author.deathYear ?? ""})")
                            .join(', ') ??
                        '',
                    style: TextStyles.medium10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppSpacer(widthRatio: .3),
                Row(
                  children: [
                    Text(
                      book.downloadCount?.toString() ?? '',
                      style: TextStyles.medium10,
                    ),
                    AppSpacer(widthRatio: .5),
                    const Icon(
                      Icons.download,
                      size: 16,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
            ...book.summaries
                    ?.map((summary) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "$summary\n",
                            style: TextStyles.regular12,
                            textAlign: TextAlign.justify,
                          ),
                        ))
                    .toList() ??
                [],
          ],
        ),
      ),
    );
  }
}

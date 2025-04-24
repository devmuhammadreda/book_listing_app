import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlTextWidget extends StatelessWidget {
  final String htmlContent;
  final TextStyle? defaultTextStyle;
  final double? width;
  final TextAlign textAlign;
  final Color linkColor;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;

  const HtmlTextWidget({
    super.key,
    required this.htmlContent,
    this.defaultTextStyle,
    this.width,
    this.textAlign = TextAlign.start,
    this.linkColor = Colors.blue,
    this.shrinkWrap = true,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      padding: padding,
      child: Html(
        data: htmlContent,
        style: {
          "body": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: defaultTextStyle?.fontSize != null
                ? FontSize(defaultTextStyle!.fontSize!)
                : FontSize.medium,
            fontWeight: defaultTextStyle?.fontWeight,
            color: defaultTextStyle?.color ?? theme.textTheme.bodyMedium?.color,
            textAlign: textAlign,
          ),
          "a": Style(
            color: linkColor,
            textDecoration: TextDecoration.underline,
          ),
          "h1": Style(
            fontSize: FontSize.larger,
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 8.0),
          ),
          "h2": Style(
            fontSize: FontSize.large,
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 6.0),
          ),
          "h3": Style(
            fontSize: FontSize.medium,
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 4.0),
          ),
          "p": Style(
            margin: Margins.only(top: 2.0, bottom: 2.0),
          ),
          "ul": Style(
            margin: Margins.only(left: 16.0),
          ),
          "ol": Style(
            margin: Margins.only(left: 16.0),
          ),
          "li": Style(
            margin: Margins.only(bottom: 2.0),
          ),
          "blockquote": Style(
            backgroundColor: Colors.grey.shade200,
            padding: HtmlPaddings.all(8.0),
            margin: Margins.symmetric(vertical: 8.0),
            border: Border(
              left: BorderSide(
                color: theme.colorScheme.primary,
                width: 3.0,
              ),
            ),
          ),
          "code": Style(
            backgroundColor: Colors.grey.shade200,
            fontFamily: 'monospace',
            padding: HtmlPaddings.all(2.0),
          ),
          "pre": Style(
            backgroundColor: Colors.grey.shade900,
            color: Colors.white,
            padding: HtmlPaddings.all(8.0),
            margin: Margins.symmetric(vertical: 8.0),
            fontFamily: 'monospace',
            display: Display.block,
            whiteSpace: WhiteSpace.pre,
          ),
        },
        onLinkTap: (url, attributes, element) async {
          if (url != null) {
            final Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          }
        },
        shrinkWrap: shrinkWrap,
      ),
    );
  }
}

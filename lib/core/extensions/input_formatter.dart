// ignore_for_file: unused_local_variable

import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '-');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';
    for (int i = 0; i < math.min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class HourMinsFormatter extends TextInputFormatter {
  late RegExp pattern;

  HourMinsFormatter() {
    pattern = RegExp(r'^[0-9:]+$');
  }

  String pack(String value) {
    if (value.length != 4) return value;
    return '${value.substring(0, 2)}:${value.substring(2, 4)}';
  }

  String unpack(String value) {
    return value.replaceAll(':', '');
  }

  String complete(String value) {
    if (value.length >= 4) return value;
    final multiplier = 4 - value.length;
    return ('0' * multiplier) + value;
  }

  String limit(String value) {
    if (value.length <= 4) return value;
    return value.substring(value.length - 4, value.length);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!pattern.hasMatch(newValue.text)) return oldValue;

    TextSelection newSelection = newValue.selection;

    String toRender;
    String newText = newValue.text;

    toRender = '';
    if (newText.length < 5) {
      if (newText == '00:0') {
        toRender = '';
      } else {
        toRender = pack(complete(unpack(newText)));
      }
    } else if (newText.length == 6) {
      toRender = pack(limit(unpack(newText)));
    }

    newSelection = newValue.selection.copyWith(
      baseOffset: math.min(toRender.length, toRender.length),
      extentOffset: math.min(toRender.length, toRender.length),
    );

    return TextEditingValue(
      text: toRender,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove any non-digit characters
    final digitsOnly = text.replaceAll(RegExp(r'[^\d]'), '');

    // Apply the formatting logic
    final formattedText = _applyFormatting(digitsOnly);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _applyFormatting(String digitsOnly) {
    if (digitsOnly.length <= 3) {
      return digitsOnly;
    } else if (digitsOnly.length <= 6) {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}';
    } else if (digitsOnly.length <= 10) {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    } else {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, 10)}';
    }
  }
}

class LinkTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _formatText(newValue.text);
    return newValue.copyWith(
      text: formattedText,
      selection: _updateCursorPosition(newValue, formattedText),
    );
  }

  String _formatText(String text) {
    final RegExp linkRegex = RegExp(r'(https?://\S+)');
    final List<String> links = linkRegex
        .allMatches(text)
        .map((Match match) => match.group(0)!)
        .toList();

    for (String link in links) {
      final formattedLink = _formatLink(link);
      text = text.replaceFirst(link, formattedLink);
    }

    return text;
  }

  String _formatLink(String link) {
    return '<a href="$link">$link</a>';
  }

  TextSelection _updateCursorPosition(
      TextEditingValue newValue, String formattedText) {
    final int offset = newValue.selection.baseOffset +
        (formattedText.length - newValue.text.length);
    return TextSelection.collapsed(offset: offset);
  }
}

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit and non-decimal point characters
    String cleanedText = newValue.text.replaceAll(RegExp('[^0-9.]'), '');

    // Split the text into whole number and decimal parts
    List<String> parts = cleanedText.split('.');
    String wholeNumber = parts[0];
    String decimal = parts.length > 1 ? parts[1] : '';

    // Format the whole number part with commas as thousands separators
    String formattedText = '';
    if (wholeNumber.isNotEmpty) {
      final wholeNumberWithCommas =
          _formatWithCommas(int.parse(wholeNumber)).toString();
      formattedText += wholeNumberWithCommas;
    }

    // Add the decimal part if present
    if (decimal.isNotEmpty) {
      formattedText += '.$decimal';
    }

    // Create and return the updated TextEditingValue
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  int _formatWithCommas(int number) {
    final formatter = NumberFormat('#,###');
    return int.parse(formatter.format(number));
  }
}

class SaudiArabiaRiyalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove any non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Insert commas for thousands separator
    final formatter = NumberFormat('#,###.##', 'en_US');
    String formattedText = formatter.format(double.parse(newText));

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

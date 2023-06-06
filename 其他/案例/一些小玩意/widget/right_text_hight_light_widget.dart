import 'package:flutter/material.dart';

class RichHightLightKeyWordsWidget extends StatelessWidget {
  final String text;
  final List<String>? keywords;
  final TextStyle highlightStyle;
  final TextStyle defaultStyle;
  final TextOverflow overflow;
  final int? maxLines;

  RichHightLightKeyWordsWidget({
    required this.text,
    this.keywords,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.highlightStyle = const TextStyle(color: Colors.red),
    this.defaultStyle = const TextStyle(color: Colors.black),
  });

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = [];
    if (keywords?.isNotEmpty == true) {
      String taggedString = '';
      List<String> sortedKeywords = List.from(keywords ?? []);
      sortedKeywords.sort(((a, b) => b.length.compareTo(a.length)));
      String patternString =
          (sortedKeywords).map((word) => RegExp.escape(word)).join('|');
      String dividerSymbol = _generateDivideSymbol();
      RegExp pattern = RegExp(patternString);
      taggedString = text.replaceAllMapped(
          pattern, (match) => '$dividerSymbol${match[0]}$dividerSymbol');

      final List<String> substrings = taggedString.split(dividerSymbol);
      for (int i = 0; i < substrings.length; i++) {
        String substring = substrings[i];
        if (keywords?.contains(substring) == true) {
          spans.add(TextSpan(text: substring, style: highlightStyle));
        } else {
          spans.add(TextSpan(text: substring, style: defaultStyle));
        }
      }
    } else {
      spans.add(TextSpan(text: text, style: defaultStyle));
    }

    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(children: spans),
    );
  }

  /// 生成分割标记
  String _generateDivideSymbol() {
    return 'dt${DateTime.now().millisecondsSinceEpoch.toString()}';
  }
}

import 'package:flutter/material.dart';

TextSpan highlightText(String text, String query) {
  if (query.isEmpty) {
    return TextSpan(text: text, style: const TextStyle(color: Colors.black));
  }

  final List<TextSpan> spans = [];
  final String lowerText = text.toLowerCase();
  final String lowerQuery = query.toLowerCase();

  int start = 0;
  int index = lowerText.indexOf(lowerQuery);

  while (index != -1) {
    if (index > start) {
      spans.add(TextSpan(
          text: text.substring(start, index),
          style: const TextStyle(color: Colors.black)));
    }

    spans.add(TextSpan(
      text: text.substring(index, index + query.length),
      style:
          const TextStyle(backgroundColor: Colors.yellow, color: Colors.black),
    ));

    start = index + query.length;
    index = lowerText.indexOf(lowerQuery, start);
  }

  if (start < text.length) {
    spans.add(TextSpan(
        text: text.substring(start),
        style: const TextStyle(color: Colors.black)));
  }

  return TextSpan(children: spans);
}

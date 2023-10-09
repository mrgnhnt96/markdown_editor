import 'package:flutter_app/objects/bold_element.dart';
import 'package:flutter_app/objects/header_element.dart';
import 'package:flutter_app/objects/highlight_element.dart';
import 'package:flutter_app/objects/italic_element.dart';
import 'package:flutter_app/objects/link_element.dart';
import 'package:flutter_app/objects/ordered_list.dart';
import 'package:flutter_app/objects/unordered_list.dart';

String convertMarkdownToHtml(String input) {
  var text = input.trim();

  const elements = [
    BoldElement(),
    ItalicElement(),
    HeaderElement(),
    HighlightElement(),
    OrderedList(),
    UnorderedList(),
    LinkElement(),
  ];

  for (final element in elements) {
    text = element.toHtml(text);
  }

  text = text.replaceAll('\n', '<br>');

  return text;
}
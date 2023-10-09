import 'package:flutter_app/objects/html_element.dart';

class UnorderedList extends HtmlElement {
  const UnorderedList();

  @override
  String toHtml(String input) {
    final pattern = RegExp(r'^(?:\s*)[-*](?: (.*))$', multiLine: true);

    var text = input.replaceAllMapped(pattern, (match) {
      final text = match.group(1) ?? '';

      return '<li>$text</li>';
    });

    final buffer = StringBuffer();

    final segments = text.split('\n');

    var inOtherGroup = false;
    var inGroup = false;
    for (var i = 0; i < segments.length; i++) {
      final segment = segments[i];

      if (segment.startsWith('<ol>')) {
        inOtherGroup = true;
      }

      if (!inOtherGroup) {
        if (segment.startsWith('<li>')) {
          if (inGroup) {
            buffer.write(segment);
          } else {
            inGroup = true;

            buffer
              ..write('<ul>')
              ..write(segment);
          }
        } else if (inGroup) {
          inGroup = false;

          buffer
            ..write('</ul>')
            ..write(segment);
        } else {
          buffer.write(segment);
        }

        if (i == segments.length - 1 && inGroup) {
          buffer.writeln('</ul>');
        } else {
          buffer.writeln();
        }
      }

      if (inOtherGroup) {
        buffer.writeln(segment);
      }

      if (inOtherGroup && segment.contains('</ol>')) {
        inOtherGroup = false;
      }
    }

    return buffer.toString();
  }

  @override
  String toMarkdown(String input) {
    final unorderedListPattern =
        RegExp(r'<ul>([\s\S]*?)<\/ul>', multiLine: true);

    return input.replaceAllMapped(unorderedListPattern, (match) {
      final list = match.group(1);

      final segments = list!.split('<li>');

      final buffer = StringBuffer();

      for (var i = 1; i < segments.length; i++) {
        var segment = segments[i];

        segment = segment.replaceAll('</li>', '');

        buffer
          ..write('* ')
          ..write(segment);
      }

      return buffer.toString();
    });
  }
}

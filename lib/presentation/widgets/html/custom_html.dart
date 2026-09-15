import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class StyledHtmlContent extends StatelessWidget {
  final String? content;
  final Future<bool> Function(String)? onTapUrl;


  const StyledHtmlContent({
    Key? key,
    required this.content,
    this.onTapUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cleanedContent = _cleanHtmlContent(content ?? '');
    return HtmlWidget(
      enableCaching: true,
      cleanedContent,
      onTapUrl: onTapUrl,
      textStyle: TextStyle(color: context.textPrimary, fontSize: 16,
        height: 1.2,),
      customStylesBuilder: _customStylesBuilder,
      customWidgetBuilder: _customWidgetBuilder,
    );
  }

  Map<String, String>? _customStylesBuilder(element) {
    // Rasmlar uchun stil
    if (element.localName == 'img') {
      return {
        'border-radius': '12px',
        'width': '100%',
        'height': 'auto',
        'object-fit': 'cover',
      };
    }

    // Figure elementi uchun (rasm konteyner)
    if (element.localName == 'figure') {
      return {
        'margin': '16px 0',
        'padding': '0',
      };
    }

    // Figcaption elementlari uchun (rasm tavsifi)
    if (element.localName == 'figcaption') {
      // figcaption-1 klassi bor bo'lsa (asosiy sarlavha)
      if (element.classes.contains('figcaption-1')) {
        return {
          'text-align': 'start',
          'margin-top': '8px',
          'font-size': '16px',
          'font-weight': '500',
          'color': '#333333',
        };
      }

      // figcaption-2 klassi bor bo'lsa (manba)
      if (element.classes.contains('figcaption-2')) {
        return {
          'text-align': 'start',
          'font-size': '14px',
          'color': '#666666',
          'margin-top': '4px',
        };
      }

      // Umumiy figcaption
      return {
        'text-align': 'start',
        'margin-top': '8px',
      };
    }

    return null;
  }

  Widget? _customWidgetBuilder(element) {
    // Agar rasm juda katta bo'lsa, qo'shimcha container ichiga o'rash
    if (element.localName == 'img') {
      final src = element.attributes['src'];
      if (src != null) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            src,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              );
            },
          ),
        );
      }
    }
    return null;
  }

  String _cleanHtmlContent(String html) {
    // Bo'sh paragraph teglarni olib tashlash
    html = html.replaceAll(RegExp(r'<p[^>]*>\s*<br\s*/?>\s*</p>'), '');
    html = html.replaceAll(RegExp(r'<p[^>]*>\s*</p>'), '');

    // Boshidagi va oxiridagi bo'sh joylarni olib tashlash
    html = html.trim();

    return html;
  }
}



class HtmlLimitedText extends StatelessWidget {
  final String data;

  const HtmlLimitedText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Html renderidan faqat textni ajratamiz
        return Html(
          data: data,
          style: {
            "*": Style(
              maxLines: 3,
              textOverflow: TextOverflow.ellipsis,
              display: Display.block,
            ),
          },
        );
      },
    );
  }
}





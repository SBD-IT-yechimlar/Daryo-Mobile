import 'package:daryo/core/gen/localization/strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class AdfoxConfig {
  final String containerId;
  final String p1;
  final String p2;
  /// Fallback height while the ad is loading / if onRender never fires.
  final double defaultHeight;

  const AdfoxConfig({
    required this.containerId,
    required this.p1,
    required this.p2,
    this.defaultHeight = 100,
  });
}

// Mobile UZ — Top
const adfoxMobileUzTop = AdfoxConfig(
  containerId: 'adfox_176776908037543187',
  p1: 'dlyhn',
  p2: 'p',
  defaultHeight: 100,
);

// Mobile UZ — Content
const adfoxMobileUzContent = AdfoxConfig(
  containerId: 'adfox_176776892735093187',
  p1: 'dlyhm',
  p2: 'p',
  defaultHeight: 177,
);

// Mobile UZ — Bottom
const adfoxMobileUzBottom = AdfoxConfig(
  containerId: 'adfox_176776994312043187',
  p1: 'dlyho',
  p2: 'p',
  defaultHeight: 100,
);

// Mobile — Fullscreen (all languages)
const adfoxMobileFullscreen = AdfoxConfig(
  containerId: 'adfox_176776848793363187',
  p1: 'dlyhk',
  p2: 'hiuq',
  defaultHeight: 600,
);

// Mobile RU — Top
const adfoxMobileRuTop = AdfoxConfig(
  containerId: 'adfox_176795166524883187',
  p1: 'dlyow',
  p2: 'p',
  defaultHeight: 100,
);

// Mobile RU — Content
const adfoxMobileRuContent = AdfoxConfig(
  containerId: 'adfox_176795176647973187',
  p1: 'dlyox',
  p2: 'p',
  defaultHeight: 177,
);

// Mobile RU — Bottom
const adfoxMobileRuBottom = AdfoxConfig(
  containerId: 'adfox_176795206039033187',
  p1: 'dlyoy',
  p2: 'p',
  defaultHeight: 100,
);

// Desktop RU — Top
const adfoxDesktopRuTop = AdfoxConfig(
  containerId: 'adfox_176777070110133187',
  p1: 'dlyhr',
  p2: 'p',
  defaultHeight: 100,
);

// Desktop RU — Content
const adfoxDesktopRuContent = AdfoxConfig(
  containerId: 'adfox_176777067158783187',
  p1: 'dlyhq',
  p2: 'p',
  defaultHeight: 250,
);

// Desktop RU — Bottom
const adfoxDesktopRuBottom = AdfoxConfig(
  containerId: 'adfox_176777077816483187',
  p1: 'dlyhs',
  p2: 'p',
  defaultHeight: 100,
);

// Mobile EN — Top
const adfoxMobileEnTop = AdfoxConfig(
  containerId: 'adfox_176795304915223187',
  p1: 'dlypa',
  p2: 'p',
  defaultHeight: 100,
);

// Mobile EN — Content
const adfoxMobileEnContent = AdfoxConfig(
  containerId: 'adfox_176795315959123187',
  p1: 'dlypb',
  p2: 'p',
  defaultHeight: 177,
);

// Mobile EN — Bottom
const adfoxMobileEnBottom = AdfoxConfig(
  containerId: 'adfox_176795323297463187',
  p1: 'dlypc',
  p2: 'p',
  defaultHeight: 100,
);

// Desktop EN — Top
const adfoxDesktopEnTop = AdfoxConfig(
  containerId: 'adfox_176777070110133187',
  p1: 'dlyhr',
  p2: 'p',
  defaultHeight: 100,
);

// Desktop EN — Content
const adfoxDesktopEnContent = AdfoxConfig(
  containerId: 'adfox_176777067158783187',
  p1: 'dlyhq',
  p2: 'p',
  defaultHeight: 250,
);

// Desktop EN — Bottom
const adfoxDesktopEnBottom = AdfoxConfig(
  containerId: 'adfox_176777077816483187',
  p1: 'dlyhs',
  p2: 'p',
  defaultHeight: 100,
);

AdfoxConfig adfoxMobileTop() {
  switch (Strings.localeHeaderV2) {
    case 'ru':
      return adfoxMobileRuTop;
    case 'en':
      return adfoxMobileEnTop;
    case 'uz':
    case 'oz':
    default:
      return adfoxMobileUzTop;
  }
}

AdfoxConfig adfoxMobileContent() {
  switch (Strings.localeHeaderV2) {
    case 'ru':
      return adfoxMobileRuContent;
    case 'en':
      return adfoxMobileEnContent;
    case 'uz':
    case 'oz':
    default:
      return adfoxMobileUzContent;
  }
}

AdfoxConfig adfoxMobileBottom() {
  switch (Strings.localeHeaderV2) {
    case 'ru':
      return adfoxMobileRuBottom;
    case 'en':
      return adfoxMobileEnBottom;
    case 'uz':
    case 'oz':
    default:
      return adfoxMobileUzBottom;
  }
}



// ---------------------------------------------------------------------------
// Reusable banner widget
// ---------------------------------------------------------------------------

class AdfoxBanner extends StatefulWidget {
  final AdfoxConfig config;

  const
  AdfoxBanner({super.key, required this.config});

  @override
  State<AdfoxBanner> createState() => _AdfoxBannerState();
}

class _AdfoxBannerState extends State<AdfoxBanner> {
  late final WebViewController _controller;
  double _height = 0;
  bool _rendered = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'AdHeight',
        onMessageReceived: (msg) {
          final h = double.tryParse(msg.message);
          if (h != null && h > 0 && mounted) {
            setState(() {
              _height = h;
              _rendered = true;
            });
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);
            if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
              launchUrl(uri, mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    // Android-specific: allow mixed content so Yandex sub-resources load.
    if (_controller.platform is AndroidWebViewController) {
      (_controller.platform as AndroidWebViewController)
          .setMixedContentMode(MixedContentMode.alwaysAllow);
    }

    // baseUrl is critical: without it Android uses loadData() from a null
    // origin, which blocks cross-origin scripts like context.js.
    _controller.loadHtmlString(
      _buildHtml(widget.config),
      baseUrl: 'https://yandex.ru',
    );
  }

  String _buildHtml(AdfoxConfig cfg) => '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    html, body {
      background: transparent;
      width: 100%;
      overflow: hidden;
    }

    .ad-wrapper {
      border-radius: 16px;
      overflow: hidden; /* MUHIM: ichidagi banner ham kesiladi */
    }
  </style>

  <script>window.yaContextCb = window.yaContextCb || [];</script>
  <script src="https://yandex.ru/ads/system/context.js" async></script>
</head>
<body>
  <div class="ad-wrapper">
    <div id="${cfg.containerId}"></div>
  </div>

  <script>
    window.yaContextCb.push(function () {
      Ya.adfoxCode.create({
        ownerId: 13283051,
        containerId: '${cfg.containerId}',
        params: { p1: '${cfg.p1}', p2: '${cfg.p2}' },
        onRender: function () {
          var h = document.getElementById('${cfg.containerId}').offsetHeight;
          if (window.AdHeight) { AdHeight.postMessage(String(h)); }
        }
      });
    });
  </script>
</body>
</html>
''';
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !_rendered,
      child: SizedBox(
        width: double.infinity,
        height: _rendered ? _height : widget.config.defaultHeight,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Fullscreen ad dialog helper
// ---------------------------------------------------------------------------

Future<void> showAdfoxFullscreen(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.black87,
      child: Stack(
        children: [
          const AdfoxBanner(config: adfoxMobileFullscreen),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    ),
  );
}

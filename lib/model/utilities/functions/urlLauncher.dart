


import '../../imports/generalImport.dart';

Future<void> launchInWebViewOrVC(String url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw 'Could not launch $url';
  }
}
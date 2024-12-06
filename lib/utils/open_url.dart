import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(
  String url, {
  LaunchMode launchMode = LaunchMode.externalApplication,
}) async {
  final Uri uri = Uri.parse(url);

  if (url.startsWith('tel:')) {
    // Handle telephone numbers
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  } else {
    // Handle URLs
    if (!await launchUrl(uri, mode: launchMode)) {
      throw Exception('Could not launch $url');
    }
  }
}

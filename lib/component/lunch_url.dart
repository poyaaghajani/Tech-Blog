import 'package:url_launcher/url_launcher.dart';

Future<void> mylaunchUrl(String url) async {
  var uri = Uri.parse(url);

  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}

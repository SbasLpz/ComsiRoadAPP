part of 'settings_screen.dart';

ThemeManager themeManager = ThemeManager();

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
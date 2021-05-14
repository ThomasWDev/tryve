import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;

bool isDesktop() {
  if (!kIsWeb)
    return false;
  
  final String iPhone = "iPhone";
  final String android = "Android";
  final userAgent = html.window.navigator.userAgent.toString().toLowerCase();
  
  if (userAgent.contains("iphone"))
    return false;
  if (userAgent.contains("android"))
    return false;
  return true;
}

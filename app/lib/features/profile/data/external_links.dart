import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ExternalLinks {
  Future<bool> openMail(String email);
}

class UrlLauncherLinks implements ExternalLinks {
  @override
  Future<bool> openMail(String email) {
    return launchUrl(Uri.parse('mailto:$email'));
  }
}

class MemoryExternalLinks implements ExternalLinks {
  String? mailed;

  @override
  Future<bool> openMail(String email) async {
    mailed = email;
    return true;
  }
}

final externalLinksProvider = Provider<ExternalLinks>(
  (ref) => UrlLauncherLinks(),
);

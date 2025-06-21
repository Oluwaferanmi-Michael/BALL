

import 'package:ball/state/models/utils/ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'url_launch_provider.g.dart';

@riverpod
Future<void> urlLaunchProvider (Ref ref, {required String uri}) async {
  final url = Uri.parse(uri);

  await canLaunchUrl(url).then((bool canLaunch) async {
    if (canLaunch) {
      await launchUrl(url);
    } else {
      'Cannot launch URL'.debugLog();
    }
  });
} 
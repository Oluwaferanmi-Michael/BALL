

import 'package:ball/shared/libraries.dart';
import 'package:ball/state/data/check_internet_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_internet_connection_provider.g.dart';

@riverpod
Future<bool> checkInternetConnection(Ref ref) async {
  final checkInternet =  CheckInternetConnection();

  final hasInternet = await checkInternet.checkInternet();

  return hasInternet;
}
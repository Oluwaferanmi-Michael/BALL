import 'package:ball/state/models/utils/ext.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class CheckInternetConnection {
  final connectivity = Connectivity();

  Future<bool> checkInternet() async {
    final connection = await connectivity.checkConnectivity();
    final data = _checkMobileData(connection);
    final wifi = _checkWifi(connection);

    final client = http.Client();

    try {
      if (data != ConnectivityResult.none || wifi != ConnectivityResult.none) {
        final req = await client.get(Uri.parse('https://google.com/'));

        req.body.debugLog(message: 'INTERNET CONNECTION::');
        req.headers.toString().debugLog(message: 'PING HEADERS::');

        if (req.statusCode != 200) return false;

        return true;
      }
      return false;
    } catch (e) {
      e.debugLog(message: 'CHECK INTERNET CONNECTION ERROR::');
      return false;
    }
  }

  ConnectivityResult _checkWifi(List<ConnectivityResult> connectivity) {
    if (connectivity.contains(ConnectivityResult.wifi)) {
      return ConnectivityResult.wifi;
    }

    return ConnectivityResult.none;
  }

  ConnectivityResult _checkMobileData(List<ConnectivityResult> connectivity) {
    if (connectivity.contains(ConnectivityResult.mobile)) {
      return ConnectivityResult.mobile;
    }

    return ConnectivityResult.none;
  }
}

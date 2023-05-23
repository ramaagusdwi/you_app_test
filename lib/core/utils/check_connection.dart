import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_you_app/core/utils/alert_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Connection {
  Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        return true;
      } else {
        AlertHelper.showSnackBar(
          'Koneksi Anda tidak stabil',
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } else {
      AlertHelper.showSnackBar(
        'Tidak ada koneksi',
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  }
}

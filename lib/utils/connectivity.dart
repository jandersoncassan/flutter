import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkOn() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    print('No Connectivity');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile) {
     print('Connectivity $connectivityResult');
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print('Connectivity $connectivityResult');
    return true;
  } 
    print('DefaultNo Connectivity');
    return false;  
}

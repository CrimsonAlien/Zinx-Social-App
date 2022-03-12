import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:zinx/enums/connectivity_status.dart';


class ConnectivityService{

  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();

 ConnectivityService(){
   
   Connectivity().onConnectivityChanged.listen(( ConnectivityResult result) {
var connectionStatus =_getStatusFromResult(result);
connectionStatusController.add(connectionStatus);
   });
 }

 ConnectivityStatus _getStatusFromResult(ConnectivityResult result){

   
   switch(result){
     case ConnectivityResult.mobile:
       return ConnectivityStatus.Cellular;
     case ConnectivityResult.wifi:
       return ConnectivityStatus.Cellular;
     case ConnectivityResult.none :
       return ConnectivityStatus.offline;

     default:
       return ConnectivityStatus.offline;
   }


 }


  getConnectionStatusFromResult(ConnectivityResult result) async{
    switch(result){
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.none :
        return ConnectivityStatus.offline;

      default:
        return ConnectivityStatus.offline;
    }


  }
}
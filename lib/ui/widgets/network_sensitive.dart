import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zinx/enums/connectivity_status.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;
  final String message;
  NetworkSensitive({
    required this.child,
    this.opacity = 0.5,  this.message='no internet',
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Wifi) {
      return child;
    }
if(connectionStatus == ConnectivityStatus.Cellular){
  return child;
}

    if (connectionStatus == ConnectivityStatus.offline) {
      return Opacity(
        opacity: opacity,
        child: child,
      );
    }

    return Opacity(
      opacity: 0.2,
      child: child,
    );
  }
}
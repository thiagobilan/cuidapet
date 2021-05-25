import 'package:cuida_pet/app/core/database/connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConnectionADM extends WidgetsBindingObserver with Disposable {
  var con = Connection();
  ConnectionADM() {
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        con.closeConnection();
        break;
      case AppLifecycleState.paused:
        con.closeConnection();
        break;
      case AppLifecycleState.detached:
        con.closeConnection();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}

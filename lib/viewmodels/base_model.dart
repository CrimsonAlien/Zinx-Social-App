

import 'package:flutter/widgets.dart';
import 'package:zinx/enums/view_state.dart';

class BaseModel extends ChangeNotifier{

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  ViewState _state=ViewState.idle;

  ViewState get state=>_state;

  void setState(ViewState viewState){

    _state=viewState;
    notifyListeners();

  }


}
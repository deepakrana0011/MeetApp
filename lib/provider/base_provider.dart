import 'package:flutter/widgets.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/service/Api.dart';


class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  Api api = locator<Api>();



  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

}

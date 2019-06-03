import 'package:closr_prototype/src/core/enums/view_state.dart';
import 'package:closr_prototype/src/core/services/user_repository.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class HomeModel extends ChangeNotifier {
  final UserRepository _userRepository = locator<UserRepository>();

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  UserRepository get user => _userRepository;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<void> signOut() async {
    return Future.wait([
      _userRepository.signOut(),
    ]);
  }

}

import 'package:closr_prototype/provider_3/core/enum/viewstate.dart';
import 'package:closr_prototype/provider_3/core/services/authentication_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  String errorMessage;



  Future<bool> signIn(String email, String password) async {
    setState(ViewState.Busy);

    // var userId = int.tryParse(userIdText);

    // if (userId == null){
    //   errorMessage = 'Value entered is not a number';
    //   setState(ViewState.Idle);
    //   return false;
    // }

    var success = await _authenticationService.signIn(email, password);

    setState(ViewState.Idle);
    return success;
  }
}
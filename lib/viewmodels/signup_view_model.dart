

import 'package:email_validator/email_validator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/viewmodels/base_model.dart';

class SignupViewModel extends BaseModel{
final AuthenticationService _authenticationService=locator<AuthenticationService>();
final NavigationService _navigationService=locator<NavigationService>();
final SnackbarService _snackbarService=locator<SnackbarService>();







Future<bool> emailChecker({required String email }) async{
  var result = await _authenticationService.checkEmailExist(email: email);

  if(result){

    return false;

  }
  else{

    return true;
  }


}



  Future<bool> checker({required String displayName }) async{



    if(displayName.trim().length>30){

      return false;

    }
    else{

      return true;
    }







  }




}




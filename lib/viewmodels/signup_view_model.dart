




import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';

import 'package:zinx/enums/view_state.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';

import 'package:zinx/viewmodels/base_model.dart';




class SignupViewModel extends BaseModel{


  final AuthenticationService _authenticationService = locator<
      AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();


Future<bool?> sendOtp(String email) async{
    var result =await _authenticationService.sendOtp(email);
    if(result){
      _navigationService.navigateTo(Routes.verifyEmail,arguments: VerifyEmailArguments(email: email));


    }else{
      _snackbarService.showSnackbar(message:"Something went wrong,check connection and try again" );
    }

}

  Future<bool?> finalizeCheck(String email) async{
    var result= await _authenticationService.checkIfEmailInUse(email);

    if(result is bool){



      if(result==true){


        _snackbarService.showSnackbar(message:"Email is used by another user" );

      }
      else{

   sendOtp(email);

      }
    }
    else{
      _snackbarService.showSnackbar(message:"Something went wrong,check connection and try again" );
    }

  }


  Future<String?> checkEmail(String email) async{

if(email.isEmpty){
  setState(ViewState.idle);

  return 'email cannot be empty';
}
if(!EmailValidator.validate(email)){
  setState(ViewState.idle);

  return 'enter a valid email';


}
if(EmailValidator.validate(email)){
  setState(ViewState.idle);
}

    var result= await _authenticationService.checkIfEmailInUse(email);


      if(result is bool){



        if(result==true){


      return "email is taken";

    }
else{
setState(ViewState.isEnabled);
print("hop");
print(email);
    }
    }
    else{
      _snackbarService.showSnackbar(message:"Something went wrong,check connection and try again" );
    }

  }


  Future<String?> usernameValidator(String value) async {

    if(value.isEmpty){

      return null;

    }
    if(value.trim().length>50){

      return 'must have 50 characters or less';
    }

    return value;

  }



}






import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/enums/connectivity_status.dart';
import 'package:zinx/enums/view_state.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/services/connectivity_service.dart';
import 'package:zinx/viewmodels/base_model.dart';




class SignupViewModel extends BaseModel{


  final AuthenticationService _authenticationService = locator<
      AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
final ConnectivityService _connectivityService= locator<ConnectivityService>();



Future<bool?> sendOtp(email) async{
    var result =await _authenticationService.sendOtp(email);
    if(result){
      _navigationService.navigateTo(Routes.verifyEmail);

    }else{
      _snackbarService.showSnackbar(message:"Something went wrong,check connection and try again" );
    }

}


  Future<String?> checkEmail(String email) async{

    var result= await _authenticationService.checkIfEmailInUse(email);

    if(email.isEmpty){
return 'email cannot be empty';
}
if(!EmailValidator.validate(email)){
  return 'enter a valid email';

}


if(result is bool){
    if(result==true){


      return "email is taken";

    }
    else{
      return null;
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



  }



}




import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
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
bool _enabled=true;
       String _errorMessage='';
  Future<String?> checkEmail({required String email}) async{

    var result= await _authenticationService.checkIfEmailInUse(email);

    if(result is bool){
    if(result==true){


      return "email is in use";

    }
    else{
      return null;
    }
    }
    else{
      _snackbarService.showSnackbar(message:"Something went wrong,check connection and try again" );
    }

  }



}


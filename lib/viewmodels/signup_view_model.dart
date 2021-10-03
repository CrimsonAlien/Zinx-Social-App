

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/viewmodels/base_model.dart';



enum ViewState {idle,busy}


class SignupViewModel extends ChangeNotifier {


  final AuthenticationService _authenticationService = locator<
      AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();


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



import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/viewmodels/base_model.dart';

class CreateAccountModel extends BaseModel{
  final NavigationService _navigationService=locator<NavigationService>();
  final SnackbarService _snackbarService=locator<SnackbarService>();
  final AuthenticationService _authenticationService=locator<AuthenticationService>();



Future signUpA({required String email,required String password,required photoUrl,required username,required displayName,required bio }) async{

  var result = await _authenticationService.signupWithEmail(email: email, password: password, photoUrl: photoUrl, username: username, displayName: displayName, bio: bio);

  if(result is bool){

    if(result){

     _authenticationService.sendVerificationLink().then((value) => _navigationService.navigateTo(Routes.userMainScreen));

    }
else{
   _snackbarService.showSnackbar(message:"Something went wrong,check connection and try again" );
    }

  }
  else{

  _snackbarService.showSnackbar(message:result);
  }







}

void checkEmail({required String email}) async{

  String result= await _authenticationService.checkEmail(email);

  if(result.length==1){
    print("yes");
  }
  else{
    _snackbarService.showSnackbar(message:result);
  }

}


}

















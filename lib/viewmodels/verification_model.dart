import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/viewmodels/base_model.dart';

class VerificationModel extends BaseModel{

  final AuthenticationService _authenticationService = locator<
      AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  Future<bool?> verifyOtp(String email,String userOtp) async{
    var result =await _authenticationService.VerifyOtp(email,userOtp);
    if(result is bool){

      if(result){
        _navigationService.navigateTo(Routes.createAccount);
      }
else{
        _snackbarService.showSnackbar(message:"invalid OTP" );
      }

    }else{
      _snackbarService.showSnackbar(message:"Something went wrong,check connection and try again" );
    }

  }




}
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/viewmodels/base_model.dart';

class LoadingScreenModel extends BaseModel{
  final AuthenticationService _authenticationService=locator<AuthenticationService>();
  final NavigationService _navigationService=locator<NavigationService>();


  Future handleLoginLogic() async{


    var hasUserLoggedIn =  await _authenticationService.isUserLoggedin();

   if(hasUserLoggedIn){

  _navigationService.navigateTo(Routes.loginViewPage);


   }
   else{
     _navigationService.replaceWith(Routes.startPage);
   }

  }



}





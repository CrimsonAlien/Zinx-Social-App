import 'package:stacked/stacked_annotations.dart';
import 'package:zinx/ui/views/Loading_screen.dart';
import 'package:zinx/ui/views/create_account_view.dart';
import 'package:zinx/ui/views/create_profile.dart';
import 'package:zinx/ui/views/login_view.dart';
import 'package:zinx/ui/views/set_password.dart';
import 'package:zinx/ui/views/signup_page.dart';
import 'package:zinx/ui/views/startup_view.dart';
import 'package:zinx/ui/views/user/user_main_screen.dart';
import 'package:zinx/ui/views/verify_email.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoadingScreen, initial: true),
    MaterialRoute(page: StartPage),
    MaterialRoute(page: LoginViewPage),
    MaterialRoute(page: SignupPage),
    MaterialRoute(page: CreateAccount),
    MaterialRoute(page: VerifyEmail),
    MaterialRoute(page: SetAccountPassword),
    MaterialRoute(page: CreateProfile),
    MaterialRoute(page: UserMainScreen),

  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
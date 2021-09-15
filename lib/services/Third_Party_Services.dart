
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/services/firestore_service.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
 NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  SnackbarService get snackbarService;

  @lazySingleton
  AuthenticationService get aut3henticationService;

  @lazySingleton
  FirestoreService get firestoreService;
}
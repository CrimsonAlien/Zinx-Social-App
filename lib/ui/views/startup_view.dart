import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/ui/shared/app_colors.dart';
import 'package:zinx/ui/shared/ui_helpers.dart';
import 'package:zinx/viewmodels/startup_view_model.dart';
import '';

import 'package:zinx/viewmodels/signup_view_model.dart';

import '../../locator.dart';



class StartPage extends StatelessWidget {
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupPageViewModel>.reactive(
        builder: (context,model,child){
          final size = MediaQuery.of(context).size;
          final height = MediaQuery.of(context).size.height;
          print(height);


          return ResponsiveBuilder(
            builder: (context, sizingInformation) {

              if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                return Container(color:Colors.blue);
              }

              if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                return Container(color:Colors.red);
              }

              if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
                return Container(color:Colors.yellow);
              }

              return SafeArea(
              child: Scaffold(
                backgroundColor: AppColor.backgroundBlack,

                body:Container(
                  color: AppColor.backgroundBlack,
                  padding: EdgeInsets.all(30),
                  width: size.width,

                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
children: [
  Center(
    child: Container(

      width: 40,
      height: 40,
      child: Center(
        child:   Image.asset(
          'assets/images/zinx.png',



        ),
      ),

    ),
  ),
  SizedBox(height: 40,),
  Text("We bring you closer to the things you love",style: TextStyle(fontFamily: 'Poppins',fontSize: 37.0,fontWeight:FontWeight.bold ,height: 1.1,color: AppColor.textWhite) ,),
  SizedBox(height: 100,),

  Row(

    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[

      Text('Already have an account?',style: TextStyle(color: AppColor.textWhite),),

      SizedBox(width: 5.0),

      InkWell(

        onTap: (){},

        child: Text("Login",style: TextStyle(color: AppColor.textWhite),),



      ),
    ],


  ),

SizedBox(height: 23,),
  InkWell(
    onTap: (){


    },

    child: Container(

      height: 55,

      decoration: BoxDecoration(

        border: Border.all(

          color: AppColor.tintedWhite,

          style: BorderStyle.solid,

          width: 1.0,

        ),

        borderRadius: BorderRadius.circular(50),
        color: AppColor.backgroundBlack,

      ),


      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[


          Text("Sign up with Number",style: TextStyle(color: AppColor.textWhite),)



        ],




      ),



    ),







  ),
  SizedBox(height: 23,),
  InkWell(
    onTap: (){

      _navigationService.navigateTo(Routes.signupPage);
    },
    child: Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color:AppColor.purpleBrush,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Sign up with Email",style: TextStyle(color:AppColor.textWhite),)

        ],


      ),



    ),

  ),
  SizedBox(height: 60,)

],

                  ),
                )
              ),


              );
            },


          );
        }
,
        viewModelBuilder: () =>StartupPageViewModel(),
    );
  }
}

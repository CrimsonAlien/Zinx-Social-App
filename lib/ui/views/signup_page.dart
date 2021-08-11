

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/ui/shared/app_colors.dart';
import 'package:zinx/viewmodels/signup_view_model.dart';
import 'package:zinx/viewmodels/startup_view_model.dart';

import '../../locator.dart';

class SignupPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupPageViewModel>.reactive(
      builder: (context,model,child){
        final size = MediaQuery.of(context).size;
        final height = MediaQuery.of(context).size.height;
        final _navigationService = locator<NavigationService>();
        final textContoller= new TextEditingController();
        final scaffoldkey= new GlobalKey<ScaffoldState>();
        final formkey= new GlobalKey<FormState>();
        

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
                key: scaffoldkey,

                  backgroundColor: AppColor.backgroundBlack,

                  body:SingleChildScrollView(
                    child: Container(
                      color: AppColor.backgroundBlack,
                      padding: EdgeInsets.all(30),
                      width: size.width,

                      height: size.height,
                      child: Form(
               key: formkey,
                        child: Column(


                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Hello, \nTell Us your Name",style: TextStyle(fontFamily: 'Poppins',fontSize: 37.0,fontWeight:FontWeight.bold ,height: 1.1,color: AppColor.textWhite) ,),

SizedBox(height: height/5,),
                Center(
                    child:new TextFormField(
controller: textContoller,

                         decoration: new InputDecoration(


                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                          color: AppColor.textWhite,
                        )
                    ),
                           hintText: "Name",
                           hintStyle: TextStyle(color: AppColor.tintedWhite),
                         )

                    )
                ),
SizedBox(height: height/6,),
                            Padding(
                              padding: const EdgeInsets.only(left:50,right: 50 ),
                              child: InkWell(
                                onTap: (){


                                  _navigationService.navigateTo(

                                    Routes.createAccount,
                                  );


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
                                      Text("Next",style: TextStyle(color:AppColor.textWhite),)

                                    ],


                                  ),



                                ),

                              ),
                            ),


                          ],



                        ),
                      ),
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

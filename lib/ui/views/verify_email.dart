

import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:zinx/ui/shared/app_colors.dart';
import 'package:zinx/ui/widgets/email_field_widget.dart';
import 'package:zinx/viewmodels/create_account_model.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final formKey = GlobalKey<FormState>();
 late final Timer timer;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAccountModel>.reactive(
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

                  body:SingleChildScrollView(
                    child: Container(
                      color: AppColor.backgroundBlack,
                      padding: EdgeInsets.all(30),
                      width: size.width,

                      height: size.height,
                      child: Form(
                        key:formKey,
                        child: Column(


                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(


                                child: Text("Verify Email",style: TextStyle(fontFamily: 'Poppins',fontSize: 37.0,fontWeight:FontWeight.bold ,height: 1.1,color: AppColor.textWhite) ,)),

                            SizedBox(height: height/6,),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:30,right: 30 ),
                                child: InkWell(
                                  onTap:() {

model.checkIsVerified();
                                  },
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color:AppColor.purpleBrush,
                                    ),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Verify Email",style: TextStyle(color:AppColor.textWhite),)

                                      ],


                                    ),



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
      viewModelBuilder: () =>CreateAccountModel(),
    );
  }

}


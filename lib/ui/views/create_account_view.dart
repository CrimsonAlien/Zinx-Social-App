

import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_text_field/password_text_field.dart';


import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:zinx/locator.dart';
import 'package:zinx/services/authentication_services.dart';
import 'package:zinx/ui/shared/app_colors.dart';
import 'package:zinx/ui/widgets/email_field_widget.dart';

import 'package:zinx/viewmodels/create_account_model.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final formKey = GlobalKey<FormState>();
  final  _emailController = TextEditingController();
  final  _passwordController = TextEditingController();


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


                                child: Text("Create Account",style: TextStyle(fontFamily: 'Poppins',fontSize: 37.0,fontWeight:FontWeight.bold ,height: 1.1,color: AppColor.textWhite) ,)),


                            SizedBox(height: height/5,),
                            Center(

                            ),
                            SizedBox(height: 15.0,),
                          Center(
                              child:PasswordTextFormField(
                                autovalidate: true,
                              controller: _passwordController,

                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(

                                        color: AppColor.textWhite,
                                      )
                                  ),
                                  labelStyle:TextStyle(color: AppColor.tintedWhite),
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: AppColor.tintedWhite),
                                ),
                                validator: (value) {
                                  if ((value?.length ?? 0) < 8) {
                                    return 'Password must be at least 8 characters';
                                  }

                                  return null;
                                },
                              )
                            ),
                            SizedBox(height: height/6,),
                            Padding(
                              padding: const EdgeInsets.only(left:50,right: 50 ),
                              child: InkWell(
                                onTap:() {


                                  final form = formKey.currentState!;

                                  if (form.validate()) {

model.signUpA(email: _emailController.text, password: _passwordController.text , photoUrl: 'sed', username: 'jude', displayName: 'crimson', bio: 'God is good');
                                  }


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
      viewModelBuilder: () =>CreateAccountModel(),
    );
  }

}


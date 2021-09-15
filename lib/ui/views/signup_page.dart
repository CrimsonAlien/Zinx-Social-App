

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'package:zinx/ui/shared/app_colors.dart';

import 'package:zinx/ui/widgets/email_field_widget.dart';
import 'package:zinx/ui/widgets/textformfield.dart';
import 'package:zinx/viewmodels/signup_view_model.dart';


import '../../locator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final  _userName = TextEditingController();
  final  _email = TextEditingController();
  final bool _enabled=false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context,model,child){
        final size = MediaQuery.of(context).size;
        final height = MediaQuery.of(context).size.height;



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


                                child: Text("Create your account",style: TextStyle(fontFamily: 'Poppins',fontSize: 37.0,fontWeight:FontWeight.bold ,height: 1.1,color: AppColor.textWhite) ,)),


                            SizedBox(height: height/5,),

                            SizedBox(height: 15.0,),
                            Center(

                                child: GeneralAsyncTextFormField(


                                  controller: _userName,
                                  validationDebounce: Duration(milliseconds: 500),
                                  validator:(_value){

                                 return   model.checker(displayName: _userName.text);
                                  },

                                  hintText: 'Username',


                                ),

                            ),
                         SizedBox(height: 35,),
                            Center(

                              child: AsyncTextFormField(



                                controller: _email,
                                validationDebounce: Duration(milliseconds: 500),
                                validator:(value){


                                    return model.emailChecker(email: _email.text);


                                },

                                hintText: 'email',


                              ),

                            ),

                            SizedBox(height: height/6,),
                            Padding(
                              padding: const EdgeInsets.only(left:50,right: 50 ),
                              child: InkWell(
                                onTap:() {


                                  final form = formKey.currentState!;

                                  if (form.validate()) {

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

      viewModelBuilder: () =>SignupViewModel(),
    );


  }


}



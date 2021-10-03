

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:zinx/enums/connectivity_status.dart';

import 'package:zinx/ui/shared/app_colors.dart';
import 'package:zinx/ui/widgets/deactivatable_button.dart';

import 'package:zinx/ui/widgets/email_field_widget.dart';
import 'package:zinx/ui/widgets/network_sensitive.dart';
import 'package:zinx/ui/widgets/textformfield.dart';
import 'package:zinx/viewmodels/signup_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../locator.dart';

class SignupPage extends StatefulWidget {

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _email = TextEditingController();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _usernameFormKey = GlobalKey<
      FormFieldState>();
  bool _isEnabled = false;
  bool _isValid = false;




  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, model, child) {

        var connectionStatus = Provider.of<ConnectivityStatus>(context);
        return new Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor.backgroundBlack,
              body: SafeArea(
                  maintainBottomViewPadding: false,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    reverse: true,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 52.h,
                        ),
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 37.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textWhite,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),

                        SizedBox(
                          height: 24.h,
                        ),
                        AsyncTextFormField(

                            key: _usernameFormKey,
                            maxLength: 40,
                            controller: _userName,
                            validationDebounce: Duration(milliseconds: 500),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: AppColor.textWhite),
                              hintText: 'Name',

                            ),
                            validator: (String? value) async {

                              if(value==null||value.isEmpty){
                                setState(() {
                                  _isValid=false;
                                });
                                return null;
                              }
                              if(value.trim().length>40){
                                setState(() {
                                  _isValid=false;
                                });
                                return 'must have 50 characters or less';
                              }
                              else{
                                setState(() {
                                  _isValid=true;
                                });
                              }



                            }



                        ),
                        SizedBox(
                          height: 16.h,
                        ),


                        AsyncTextFormField(

                            key: _emailFormKey,
                            controller: _email,
                            validationDebounce: Duration(milliseconds: 500),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: AppColor.textWhite),
                              hintText: 'Email',

                            ),
                            validator: (String? value) async {

                              if(value==null||value.isEmpty){
                                setState(() {
                                  _isEnabled=false;
                                });
                                return null;
                              }
                              if(!EmailValidator.validate(_email.text)){

                                Future.delayed(Duration.zero);
                                setState(() {
                                  _isEnabled=false;
                                });
                                return 'Enter a valid email';
                              }
                              if(connectionStatus==ConnectivityStatus.offline){
                                Future.delayed(Duration.zero);
                                setState(() {
                                  _isEnabled=false;
                                });
                                return 'Please check internet connection';
                              }else{
                                Future.delayed(Duration.zero);

                                return model.checkEmail(email: _email.text).then((onValue) {
                                  if(onValue!=null && onValue.isNotEmpty){
                                    setState(() {
                                      _isEnabled=false;
                                    });
                                    return "email is already in use";
                                  }else{
                                    setState(() {
                                      _isEnabled=true;
                                    });
                                  }
                                }).catchError((onError) {
                                  print(onError);
                                });






                                }
                              }





                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                         SizedBox(
                            width: double.infinity,
                            child: deactivatableWidget(),
                          ),

                        SizedBox(height: 16.h,),
                        Wrap(
                          children: [
                            Center(
                              child: Text(
                                "By signing up to Zinx you agree to our ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.textWhite,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "terms and conditions",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.purpleBrush,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                      ],
                    ),
                  )
              ),

            );
          },



      viewModelBuilder: () => SignupViewModel(),
    );
  }

  void _onPressed() {
    print('Hello Reactive Forms!!!');
  }

 Widget deactivatableWidget(){
   var connectionStatus = Provider.of<ConnectivityStatus>(context);
   if( connectionStatus != ConnectivityStatus.offline  && _isEnabled==true && _isValid==true){
return TextButton(
  onPressed:_onPressed,
  style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColor.purpleBrush),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 14.h)),
      textStyle: MaterialStateProperty.all(TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ))),
  child: Text("Create Account"),
);

   }
  return  Opacity(
    opacity: 0.2,
    child: TextButton(
       onPressed:(){

       },
       style: ButtonStyle(
           backgroundColor: MaterialStateProperty.all(AppColor.purpleBrush),
           foregroundColor: MaterialStateProperty.all(Colors.white),
           padding: MaterialStateProperty.all(
               EdgeInsets.symmetric(vertical: 14.h)),
           textStyle: MaterialStateProperty.all(TextStyle(
             fontSize: 14.sp,
             fontWeight: FontWeight.w700,
           ))),
       child: Text("Create Account"),
     ),
  );

 }

}


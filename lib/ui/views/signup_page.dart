

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:zinx/enums/connectivity_status.dart';
import 'package:zinx/enums/view_state.dart';

import 'package:zinx/ui/shared/app_colors.dart';

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
                    GeneralAsyncTextFormField(

                      key: _usernameFormKey,
                      maxLength: 50,
                      controller: _userName,
                      validationDebounce: Duration(milliseconds: 500),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: AppColor.textWhite),
                        hintText: 'Name',

                      ),
                      validator:(value)=>model.usernameValidator(_userName.text).then((onValue) {
                        if(onValue!=null && onValue.isNotEmpty){
model.setState(ViewState.isEnabled);
                          _isValid=true;

                        }else{

                          model.setState(ViewState.idle);

                          _isValid=false;
                        }
                      }).catchError((onError) {
                        print(onError);
                      }),
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
                        validator:(value)=>model.checkEmail(_email.text).whenComplete(() {
                      if(model.state==ViewState.isEnabled){
                       _isEnabled=true;
                      }
                      else{
                        _isEnabled=false;
                      }
                        }).catchError((onError) {
                          print(onError);
                        }),


                    ),







                    SizedBox(
                      height: 16.h,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: deactivatableWidget(model),
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



  Widget deactivatableWidget(SignupViewModel model){
    var connectionStatus = Provider.of<ConnectivityStatus>(context);


    if( _isValid==true && _isEnabled==true && connectionStatus!= ConnectivityStatus.offline){
        return TextButton(
          onPressed:() async => await model.finalizeCheck(_email.text),
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


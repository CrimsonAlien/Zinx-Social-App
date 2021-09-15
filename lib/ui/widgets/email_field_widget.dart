import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:provider/provider.dart';
import 'package:zinx/enums/connectivity_status.dart';
import 'package:zinx/ui/shared/app_colors.dart';

class AsyncTextFormField extends StatefulWidget {
  final Future<bool> Function(String) validator;
  final Duration validationDebounce;
  final TextEditingController controller;
  final String hintText;
  final String isValidatingMessage;
  final String valueIsEmptyMessage;
  final String valueIsInvalidMessage;
  final String invalidEmail;
  final String connectionErrorMessage;
  const AsyncTextFormField(
      {Key? key,
        required this.validator,
        required this.validationDebounce,
        required this.controller,
        this.isValidatingMessage = " ",
        this.valueIsEmptyMessage = ' ',
        this.valueIsInvalidMessage = 'Email is already taken',
        this.invalidEmail='Enter a valid email address',
        this.hintText = '', this.connectionErrorMessage='Please check your network connection'})
      : super(key: key);

  @override
  _AsyncTextFormFieldState createState() => _AsyncTextFormFieldState();
}

class _AsyncTextFormFieldState extends State<AsyncTextFormField> {
  Timer? _debounce;
  var isValidating = false;
  var isValid = false;
  var isDirty = false;
  var isWaiting = false;

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (isValidating) {
          return widget.isValidatingMessage;
        }
        if (value?.isEmpty ?? false) {

          return null;
        }
        if( value != null && !EmailValidator.validate(value)){

          return widget.invalidEmail;
        }
        if(connectionStatus ==ConnectivityStatus.offline){
          return widget.connectionErrorMessage;
        }
        if (!isWaiting && !isValid) {
          return widget.valueIsInvalidMessage;
        }
        return null;
      },
      onChanged: (text) async {
        isDirty = true;
        if (text.isEmpty ) {
          setState(() {

            isValid = false;

            print('is empty');
          });
          cancelTimer();
          return;
        }
        else if(!EmailValidator.validate(text)){
          setState(() {

            isValid = false;

            print('is empty');
          });
          cancelTimer();
          return;
        }

        isWaiting = true;
        cancelTimer();
        _debounce = Timer(widget.validationDebounce, () async {
          isWaiting = false;
          isValid = await validate(text);
          print(isValid);
          setState(() {});
          isValidating = false;
        });
      },
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email],
      textAlign: TextAlign.start,
      controller: widget.controller,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          suffix: SizedBox(height: 20, width: 20, child: _getSuffixIcon()),
      hintStyle: TextStyle(color: AppColor.textWhite),
          hintText: widget.hintText,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.purpleBrush)
          )

      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }

  Future<bool> validate(String text) async {
    setState(() {
      isValidating = true;
    });
    final isValid = await widget.validator(text);
    isValidating = false;
    return isValid;
  }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      );
    } else {
      if (!isValid && isDirty) {
        return Container();
      } else if (isValid) {
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return Container();
      }
    }
  }
}














/*class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _EmailFieldWidgetState createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: widget.controller,
    style: TextStyle(color: AppColor.tintedWhite),
autovalidate: true,

    decoration: InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(

            color: AppColor.textWhite,
          )
      ),
      labelStyle:TextStyle(color: AppColor.tintedWhite),
      hintText: "Email",
      hintStyle: TextStyle(color: AppColor.tintedWhite),
    ),

    keyboardType: TextInputType.emailAddress,
    autofillHints: [AutofillHints.email],
    validator: (email) => email != null && !EmailValidator.validate(email)
        ? 'Enter a valid email'
        : null,
  );
}*/
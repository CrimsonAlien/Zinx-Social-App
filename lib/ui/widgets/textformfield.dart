import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zinx/ui/shared/app_colors.dart';

class GeneralAsyncTextFormField extends StatefulWidget {
  final Future<bool> Function(String) validator;
  final Duration validationDebounce;
  final TextEditingController controller;
  final String hintText;
  final String isValidatingMessage;
  final String valueIsEmptyMessage;
  final String valueIsInvalidMessage;
  final String invalidEmail;


  const GeneralAsyncTextFormField({Key? key,
    required this.validator,
    required this.validationDebounce,
    required this.controller,
    this.isValidatingMessage = " ",
    this.valueIsEmptyMessage = ' ',
    this.valueIsInvalidMessage = 'Must be 30 characters or fewer',
    this.invalidEmail='Enter a valid email address',
    this.hintText = '',
  }) : super(key: key);

  @override
  _GeneralAsyncTextFormFieldState createState() => _GeneralAsyncTextFormFieldState();
}

class _GeneralAsyncTextFormFieldState extends State<GeneralAsyncTextFormField> {
  Timer? _debounce;
  var isValidating = false;
  var isValid = false;
  var isDirty = false;
  var isWaiting = false;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (isValidating) {
          return widget.isValidatingMessage;
        }
        if (value?.isEmpty ?? false) {

          return null;
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

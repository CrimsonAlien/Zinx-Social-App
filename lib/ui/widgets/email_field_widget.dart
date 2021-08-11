import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:zinx/ui/shared/app_colors.dart';

class EmailFieldWidget extends StatefulWidget {
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
}
import 'package:flutter/material.dart';
import './form_signup.dart';
import './form_signin.dart';

class FormCart extends StatefulWidget {
  const FormCart({super.key});

  @override
  State<FormCart> createState() => _FormCartState();
}

class _FormCartState extends State<FormCart> {
  String statusForm = "signin";

  void changeStatusForm(String newStatus) {
    setState(() {
      statusForm = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: (statusForm == "signin")
            ? FormSignin(changeStatusForm: changeStatusForm)
            : FormSignup(changeStatusForm: changeStatusForm));
  }
}

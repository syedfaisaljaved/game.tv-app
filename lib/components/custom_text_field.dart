import 'package:flutter/material.dart';
import 'package:game_tv/utils/constants/color_const.dart';

Widget customTextFieldWithController(
    {BuildContext context,
    String labelText,
    String hintText,
    TextEditingController controller,
    bool passwordVisible = false,
    VoidCallback callback,
    bool hasError = false}) {
  return TextField(
    decoration: InputDecoration(
      suffixIcon: labelText == "Password"
          ? IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                !passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: colorBlack,
              ),
              onPressed: () {
                callback();
              },
            )
          : null,
      labelText: controller.text.isEmpty ? null : labelText,
      labelStyle: TextStyle(
        color: colorBlack,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.only(left: 20),
      hintText: hintText,
      hintStyle: TextStyle(
        color: colorBlack,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[800], width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[800], width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorBlack, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[400], width: 2.0),
      ),
      errorText: hasError
              ? labelText == "Password" ? "Wrong password entered" : "Username doesn't exist"
              : null,
      errorBorder: hasError
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                )
              : null,
    ),
    textInputAction: TextInputAction.done,
    obscureText: passwordVisible,
    style: TextStyle(
      color: colorBlack,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    keyboardType: TextInputType.text,
    controller: controller,
  );
}

String validateEmail(String value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value))
    return 'Enter a valid email address';
  else
    return null;
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_tv/bloc/login_bloc.dart';
import 'package:game_tv/components/custom_text_field.dart';
import 'package:game_tv/ui/home/home_screen.dart';
import 'package:game_tv/utils/constants/color_const.dart';
import 'package:game_tv/utils/constants/img_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController;
  TextEditingController _passController;
  bool _passwordVisible = true;
  bool _buttonEnabled = false;
  bool _invalidUsername = false;
  bool _invalidPass = false;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();

    _userNameController = TextEditingController();
    _passController = TextEditingController();

    _userNameController.addListener(() {
      setState(() {
        if (_userNameController.text
            .trim()
            .length >= 10) {
          _buttonEnabled = true;
        } else {
          _buttonEnabled = false;
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowGlow();
              return;
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      gameTvLogo,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    customTextFieldWithController(
                        context: context,
                        labelText: "Username",
                        hintText: "Enter Username",
                        controller: _userNameController,
                        hasError: _invalidUsername,
                        callback: () {}),
                    SizedBox(
                      height: 20,
                    ),
                    customTextFieldWithController(
                        context: context,
                        labelText: "Password",
                        hintText: "Enter password",
                        hasError: _invalidPass,
                        controller: _passController,
                        callback: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        passwordVisible: _passwordVisible),
                    SizedBox(
                      height: 20,
                    ),
                    BlocProvider(
                      create: (context) => _loginBloc,
                      child: BlocListener(
                        cubit: _loginBloc,
                        listener: (context, state) {
                          if (state is SuccessLoginUser)
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                          if(state is ErrorUsernameState)
                            setState(() {
                              _invalidUsername = true;
                            });
                          if(state is ErrorPasswordState)
                            setState(() {
                              _invalidUsername = false;
                              _invalidPass = true;
                            });
                        },
                        child: FlatButton(
                          minWidth: double.maxFinite,
                          disabledColor: colorBlue.withOpacity(0.5),
                          onPressed: _buttonEnabled
                              ? () {
                                  _loginBloc.add(LoginUser(
                                      username: _userNameController.text.trim(),
                                      pass: _passController.text.trim()));
                                }
                              : null,
                          child: Text("Login"),
                          textColor: colorWhite,
                          color: colorBlue,
                          padding: EdgeInsets.all(16),
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

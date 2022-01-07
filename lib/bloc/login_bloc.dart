
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_tv/db/hive_provider.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(InitLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      /// not connected to internet
      Fluttertoast.showToast(msg: "No Internet Connection", toastLength: Toast.LENGTH_SHORT);
      return;
    }

    if(event is LoginUser){
      if(!["9898989898", "9876543210"].contains(event.username)){
        yield ErrorUsernameState();
        return;
      }
      if("password123" != event.pass){
        yield ErrorPasswordState();
        return;
      }

      HiveProvider.isLoggedIn = true;
      yield SuccessLoginUser();
    }
    
  }
}


abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUser extends LoginEvent {
  final String username;
  final String pass;
  LoginUser({this.username, this.pass});

  @override
  List<Object> get props => [username, pass];
}

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitLoginState extends LoginState {
  const InitLoginState();

  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {
  const LoadingLoginState();

  @override
  List<Object> get props => [];
}

class ErrorPasswordState extends LoginState {
  const ErrorPasswordState();

  @override
  List<Object> get props => [];
}


class ErrorUsernameState extends LoginState {
  const ErrorUsernameState();

  @override
  List<Object> get props => [];
}

class SuccessLoginUser extends LoginState {
  const SuccessLoginUser();

  @override
  List<Object> get props {}
}

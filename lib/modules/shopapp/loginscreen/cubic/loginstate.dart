import '../../../../models/shopApp/Login.dart';

abstract class LoginStates {}

class IntilState extends LoginStates {}

class LoginSucessState extends LoginStates {
  late LoginDate Data;
  LoginSucessState(this.Data);
}

class LoginErrorState extends LoginStates {}

class loadingState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates{}
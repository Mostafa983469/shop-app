import '../../../../models/shopApp/Login.dart';

abstract class SignInStates {}

class SignInIntilState extends SignInStates {}

class SignInSucessState extends SignInStates {
  late LoginDate Data;
  SignInSucessState(this.Data);
}

class SignInErrorState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class ChangePasswordSignInVisibilityState extends SignInStates{}
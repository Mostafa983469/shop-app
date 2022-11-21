import 'package:bloc/bloc.dart';
import 'package:firstapp/modules/shopapp/signInScreen/cubic/signInStates.dart';
import 'package:firstapp/shared/network/remote/Dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/shopApp/Login.dart';

class SignInCubit extends Cubit<SignInStates>{

  SignInCubit() : super(SignInIntilState());
  
  static SignInCubit get(context) => BlocProvider.of(context);

  late LoginDate data ;

  void SignIn(
      {
        required String email,
        required String password,
        required String name,
        required String phone,
      }
      )
  {
    emit(SignInLoadingState());
    DioHelper.postData(
        url:'register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        }
    ).then((value) {
      data = LoginDate(value.data);
      emit(SignInSucessState(data));
    }).catchError((Error) {
      emit(SignInErrorState());
    });
  }

  bool IsPassword = true;
  IconData icon = Icons.visibility_outlined;
  void ChangeVisiplitiy(){
    IsPassword = ! IsPassword;
    icon = IsPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ChangePasswordSignInVisibilityState());
  }
}
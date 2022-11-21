import 'package:bloc/bloc.dart';
import 'package:firstapp/modules/shopapp/loginscreen/cubic/loginstate.dart';
import 'package:firstapp/shared/components/constans.dart';
import 'package:firstapp/shared/network/remote/Dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/shopApp/Login.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(IntilState());
  
  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginDate data ;

  void Login({required String email, required String password,})
  {
    emit(loadingState());
    DioHelper.postData(
        url:'login',
        data: {
          'email': email,
          'password': password,
        }
    ).then((value) {
      data = LoginDate(value.data);
      Token = data.data!.token!;
      emit(LoginSucessState(data));
    }).catchError((Error) {
      emit(LoginErrorState());
    });
  }

  bool IsPassword = true;
  IconData icon = Icons.visibility_outlined;
  void ChangeVisiplitiy(){
    IsPassword = ! IsPassword;
    icon = IsPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ChangePasswordVisibilityState());
  }
}
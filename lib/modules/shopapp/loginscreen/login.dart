import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstapp/layout/shopapp/home.dart';
import 'package:firstapp/modules/shopapp/loginscreen/cubic/logincubic.dart';
import 'package:firstapp/modules/shopapp/loginscreen/cubic/loginstate.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/network/local/sharred.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/constans.dart';
import '../signInScreen/Signin.dart';


class Login extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit,LoginStates>(
            builder: (context , state) {
              return Scaffold(
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            textAlign : TextAlign.start,
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          textfield(
                            ontap: (){},
                            InputType: TextInputType.emailAddress,
                            Controller: emailController,
                            labeltext: 'EMAIL',
                            labelStyle: Colors.blue,
                            prefixicon: Icons.email,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          textfield
                            (
                              ontap: (){},
                              InputType: TextInputType.visiblePassword,
                              Controller: passwordController,
                              labeltext: 'PASSWORD',
                              labelStyle: Colors.blue,
                              isPassword: LoginCubit.get(context).IsPassword,
                              prefixicon: Icons.lock,
                              sufixicon: LoginCubit.get(context).icon,
                              suffixPressed: () {
                                LoginCubit.get(context).ChangeVisiplitiy();
                              },
                            ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! loadingState,
                            builder: (context) => buttom(
                                  onpressed: () {if (formKey.currentState!.validate()) {
                                   LoginCubit.get(context).Login(
                                      email: emailController.text,
                                       password: passwordController.text
                                   );
                                 }},
                                 text: 'login'
                              ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'not register yet',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signin(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'create new account',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

              );
            },
            listener: (context , state) {
              if(state is LoginSucessState){
                if(state.Data.status){
                  toast(massage: state.Data.massage, IsError: false);
                  Sharred.put(key: 'Token', value: state.Data.data!.token).
                  then(
                      (value) {
                        Token = state.Data.data!.token!;
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute
                              (builder: (context) => ShopHome()),
                                (route) => false);
                      }
                  );
                }else{
                  toast(massage: state.Data.massage, IsError: true);
                }
              }
            }
        ),
    );
  }
}

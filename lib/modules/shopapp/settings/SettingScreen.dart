import 'package:firstapp/layout/shopapp/cubit/cubit.dart';
import 'package:firstapp/layout/shopapp/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    BlocConsumer<HomeCubit,HomeStates>(
        builder: (BuildContext context,state)  {
           emailController.text = HomeCubit.get(context).userDate!.data!.email!;
           nameController.text = HomeCubit.get(context).userDate!.data!.name!;
           phoneController.text = HomeCubit.get(context).userDate!.data!.phone!;
          return Form(
            key: formKey,
              child: Padding(
              padding: const EdgeInsetsDirectional.all(20.0),
              child :Column(
                children: [
                  if(state is LoadingUpdateUserDataState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
              textfield(
                  InputType: TextInputType.name,
                  Controller: nameController,
                  labeltext: 'Name',
                  labelStyle: Colors.blue,
                  prefixicon: Icons.person,
              ),
              SizedBox(
                height: 30.0,
              ),
              textfield(
                  InputType: TextInputType.emailAddress,
                  Controller: emailController,
                  labeltext: 'Email',
                  labelStyle: Colors.blue,
                prefixicon: Icons.email,
              ),
              SizedBox(
                height: 30.0,
              ),
              textfield(
                  InputType: TextInputType.phone,
                  Controller: phoneController,
                  labeltext: 'phone',
                  labelStyle: Colors.blue,
                prefixicon: Icons.phone,

              ),
              SizedBox(
                height: 30.0,
              ),
              buttom(
                  onpressed: (){
                    if(formKey.currentState!.validate()){
                      HomeCubit.get(context).updateData(
                          name: nameController.text,
                          email:emailController.text ,
                          phone:phoneController.text );
                    }
              },
                  text: 'Update'
              ),
              SizedBox(
                height: 30.0,
              ),
              buttom(
                  onpressed: (){
                SignOut(context);
              },
                  text: 'Sign out'
              ),
            ],
              )
              )
          );
        },
        listener: (context,state)  {},
    );
  }
}

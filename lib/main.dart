import 'package:bloc/bloc.dart';
import 'package:firstapp/layout/shopapp/cubit/cubit.dart';
import 'package:firstapp/shared/bloc_observer.dart';
import 'package:firstapp/shared/components/constans.dart';
import 'package:firstapp/shared/network/local/sharred.dart';
import 'package:firstapp/shared/network/remote/Dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/shopapp/cubit/states.dart';
import 'layout/shopapp/home.dart';
import 'modules/shopapp/loginscreen/login.dart';
import 'modules/shopapp/onBoarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Sharred.init();
  bool onBoarding = Sharred.Get(key: 'OnBoarding');
  Token = Sharred.Get(key: 'Token');
  runApp(
      MyApp(
          select(
              onBoarding: onBoarding,
              Token: Token
          )
     )
  );
}

class MyApp extends StatelessWidget {
  final Widget page ;
  MyApp(this.page);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => HomeCubit()..getData()..getCategoriesData()..getFavouriteData()..getUserData()
          ),
        ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightTheme,
            themeMode: ThemeMode.light,
            home: page,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

Widget select({required bool onBoarding,required String Token}){
  if(onBoarding != null){
    if(Token != null)
      return ShopHome();
    else
      return Login();
  }else{
    return OnBoardingScreen();
  }
}

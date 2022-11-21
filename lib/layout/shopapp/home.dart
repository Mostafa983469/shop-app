import 'package:firstapp/layout/shopapp/cubit/cubit.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/shopapp/search/SearchScreen.dart';
import 'cubit/states.dart';

class ShopHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        builder: (context , state) {
          var Cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Hallo',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              actions: [
                TextButton(
                    onPressed:(){
                      NavigatorPush(context: context, page: SearchScreen());
                    },
                    child: Icon(Icons.search)
                ),
              ],
            ),
            body: Cubit.pages[Cubit.currentState],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: Cubit.currentState,
                onTap: (index){
                  Cubit.changeBottomNav(index);
                },
                items:
                [
                  BottomNavigationBarItem(icon: Icon(Icons.home) , label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.category) , label: 'Categories'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite) , label: 'favorites'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings) , label: 'settings'),
                ]
            ),
          );
        },
        listener: (context , state) {},

    );
  }
}

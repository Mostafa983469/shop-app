import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shopapp/cubit/cubit.dart';
import '../../../layout/shopapp/cubit/states.dart';

class favoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeStates>(
      builder: (context,state) {
        return ConditionalBuilder(
          condition: state != LoadingFavouriteDataState() ,
          builder: (context) => ListView.separated(
              itemBuilder: (context,index) => BuildItem(
                  HomeCubit.get(context).favouriteModel!.data.favouriteData[index].product,
                  context),
              separatorBuilder: (context,index) => Container(
                width: double.infinity,
                height: 2.0,
                color: Colors.black,
              ),
              itemCount: HomeCubit.get(context).favouriteModel!.data.favouriteData.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context,state) {
        if (state is SuccessChangeFavouriteDataState ){
          if(!state.changeFavoritesModel.status){
            toast(massage: state.changeFavoritesModel.message.toString(), IsError: true);
          }
        }
      },
    );

  }


}

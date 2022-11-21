import 'package:firstapp/layout/shopapp/cubit/cubit.dart';
import 'package:firstapp/layout/shopapp/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/shopApp/categories.dart';

class CatgouriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      builder: (context,state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.separated(
                itemBuilder: (context,index) => BuildItem(HomeCubit.get(context).categoriesData!.data.Data[index]),
                separatorBuilder: (context,index) => Container(
                  width: double.infinity,
                  height: 2.0,
                  color: Colors.black,
                ),
                itemCount: HomeCubit.get(context).categoriesData!.data.Data.length
            ),
        );
      },
      listener: (context,state) {},
    );
  }
  Widget BuildItem(DataModel? model) => Container(
    width: double.infinity,
    height: 130.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
            image: NetworkImage('${model!.image}'),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
            model.name,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        TextButton(
            onPressed: (){},
            child: Icon(Icons.arrow_forward_ios)
        ),
      ],
    ),
  );
}

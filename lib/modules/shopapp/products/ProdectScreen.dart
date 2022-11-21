import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstapp/layout/shopapp/cubit/cubit.dart';
import 'package:firstapp/layout/shopapp/cubit/states.dart';
import 'package:firstapp/models/shopApp/homeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopApp/categories.dart';
import '../../../shared/components/components.dart';

class ProdectScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        builder: (context , state){
          return Scaffold(
          body: ConditionalBuilder(
              condition: HomeCubit.get(context).model != null && HomeCubit.get(context).categoriesData != null ,
              builder: (context) => BulidPage(HomeCubit.get(context).model,
                   HomeCubit.get(context).categoriesData,context),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
          );
        },
        listener: (context , state) {
          if (state is SuccessChangeFavouriteDataState ){
            if(!state.changeFavoritesModel.status){
              toast(massage: state.changeFavoritesModel.message.toString(), IsError: true);
            }
          }
        },
    );
  }
  Widget BulidPage(HomeModel? Model,CategoriesModel? categoriesModel ,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children :
          [
            CarouselSlider(
              items: Model!.data!.banners.map(
                    (e) => Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                ),
              ).toList(),
              options: CarouselOptions(
                height: 250.0,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                reverse: false,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => BuildCategories(categoriesModel!.data.Data[index]),
                      separatorBuilder:  (context,index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data.Data.length,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'products',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.63,
                crossAxisCount: 2,
                children:
                List.generate(Model.data!.products.length,
                        (index) => BuildItem(Model.data!.products[index],context)
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget BuildItem(ProductModel Model,context) {
    bool? check = HomeCubit.get(context).favourite[Model.id];
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${Model.image}'),
                  width: double.infinity,
                  height: 200.0,
                ),
                if(Model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child :Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${Model.price.round()}',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blue
                        ),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      if (Model.discount != 0)
                        Text(
                          '${Model.oldPrice.round()}',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 15.0
                          ),
                        ),
                      Spacer(),
                      TextButton(
                          onPressed: (){
                            HomeCubit.get(context).ChangeFavourite(Model.id);
                          },
                          child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: check! ?
                              Colors.blue: Colors.grey,
                              child: Icon(Icons.favorite_border, size: 14.0,
                                color: Colors.white,)
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        )
    );
  }

  Widget BuildCategories(DataModel data) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage('${data.image}'),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          data.name,
          maxLines : 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
          ),
        ),
      ),
    ],
  );
}



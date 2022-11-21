import 'package:firstapp/layout/shopapp/cubit/states.dart';
import 'package:firstapp/models/shopApp/homeData.dart';
import 'package:firstapp/shared/network/remote/Dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/shopApp/Change_Favourite.dart';
import '../../../models/shopApp/Favourite_Model.dart';
import '../../../models/shopApp/Login.dart';
import '../../../models/shopApp/categories.dart';
import '../../../modules/shopapp/categories/catgouriesScreen.dart';
import '../../../modules/shopapp/favouite/FavouiteScreen.dart';
import '../../../modules/shopapp/products/ProdectScreen.dart';
import '../../../modules/shopapp/settings/SettingScreen.dart';
import '../../../shared/components/constans.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeModel? model ;
  CategoriesModel? categoriesData;
  FavouriteModel? favouriteModel;
  ChangeFavoritesModel? changeFavoritesModel;
  LoginDate? userDate ;
  Map<int,bool> favourite ={} ;
  int currentState =0 ;
  List<Widget> pages = [ProdectScreen(), CatgouriesScreen(), favoriteScreen(), SettingsScreen(),];

  void changeBottomNav(index){
    currentState = index;
    emit(ChangeBottomBarState());
  }

  void getData(){
    emit(LoadingDataState());
    DioHelper.getData(
      url: 'home',
      token: Token,
    ).
    then(
         (value) {
            model = HomeModel.fromJson(value.data);

            for (var element in model!.data!.products) {
              favourite.addAll({
                element.id: element.inFavorites,
              });
            }
            emit(SuccessDataState());
         }).catchError(
            (error) {
              if (kDebugMode) {
                print(error.toString());
              }
              emit(ErrorDataState());
            });
  }

  void getCategoriesData(){


    DioHelper.getData(
      url: 'categories',
    ).
    then(
            (value) {
              categoriesData = CategoriesModel(value.data);
          emit(SuccessCategoriesDataState());
        }).catchError(
            (error) {
          if (kDebugMode) {
            print(error.toString());
          }
          emit(ErrorCategoriesDataState());
        });
  }

  void getFavouriteData(){

    emit(LoadingFavouriteDataState());
    DioHelper.getData(
      url: 'favorites',
      token: Token,
    ).
    then(
            (value) {
              favouriteModel = FavouriteModel(value.data);
          emit(SuccessFavouriteDataState());
        }).catchError(
            (error) {
          if (kDebugMode) {
            print(error.toString());
          }
          emit(ErrorFavouriteDataState());
        });
  }

  void ChangeFavourite(int id){
      bool? c = favourite[id];
      favourite[id] = !c!;
      emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: 'favorites',
        data: {
          'product_id': id
        },
      token: Token
    )
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel(value.data);
      if(!changeFavoritesModel!.status){
        c = favourite[id];
        favourite[id] = !c!;
      }else{
        getFavouriteData();
      }
      emit(SuccessChangeFavouriteDataState(changeFavoritesModel!));
    })
        .catchError((error){
      c = favourite[id];
      favourite[id] = !c!;
      emit(ErrorChangeFavouriteDataState());
    });
  }

  void getUserData(){

    emit(LoadingUserDataState());
    DioHelper.getData(
      url: 'profile',
      token: Token,
    ).
    then(
            (value) {
              userDate = LoginDate(value.data);
          emit(SuccessUserDataState());
        }).catchError(
            (error) {
          if (kDebugMode) {
            print(error.toString());
          }
          emit(ErrorUserDataState());
        });
  }

  void updateData({
    required String name,
    required String email,
    required String phone,
}){
    emit(LoadingUpdateUserDataState());
    DioHelper.putData(
      url: 'update-profile',
      token: Token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).
    then(
            (value) {
          userDate = LoginDate(value.data);
          emit(SuccessUpdateUserDataState());
        }).catchError(
            (error) {
          emit(ErrorUpdateUserDataState());
        });
  }

}
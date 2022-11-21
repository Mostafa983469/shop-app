import '../../../models/shopApp/Change_Favourite.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class ChangeBottomBarState extends HomeStates{}

class LoadingDataState extends HomeStates{}

class SuccessDataState extends HomeStates{}

class ErrorDataState extends HomeStates{}

class SuccessCategoriesDataState extends HomeStates{}

class ErrorCategoriesDataState extends HomeStates{}

class LoadingFavouriteDataState extends HomeStates{}

class SuccessFavouriteDataState extends HomeStates{}

class ErrorFavouriteDataState extends HomeStates{}

class ShopChangeFavoritesState extends HomeStates{}

class SuccessChangeFavouriteDataState extends HomeStates{
  late ChangeFavoritesModel changeFavoritesModel ;
  SuccessChangeFavouriteDataState(this.changeFavoritesModel);
}

class ErrorChangeFavouriteDataState extends HomeStates{}

class LoadingUserDataState extends HomeStates{}

class SuccessUserDataState extends HomeStates{}

class ErrorUserDataState extends HomeStates{}

class LoadingUpdateUserDataState extends HomeStates{}

class SuccessUpdateUserDataState extends HomeStates{}

class ErrorUpdateUserDataState extends HomeStates{}
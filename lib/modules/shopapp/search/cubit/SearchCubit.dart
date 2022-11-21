import 'package:firstapp/modules/shopapp/search/cubit/SearchStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/shopApp/Search.dart';
import '../../../../shared/components/constans.dart';
import '../../../../shared/network/remote/Dio.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super (SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void getData(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: 'products/search',
        token: Token,
        data: {
          'text':text,
        },
    ).then((value) {
      searchModel = SearchModel(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

}
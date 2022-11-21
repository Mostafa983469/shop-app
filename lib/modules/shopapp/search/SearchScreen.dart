import 'package:firstapp/modules/shopapp/search/cubit/SearchCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import 'cubit/SearchStates.dart';
class SearchScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
      child :BlocConsumer<SearchCubit,SearchStates>(
            builder: (context ,state) {
              return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formkey,
                  child:Padding(
                      padding: const EdgeInsetsDirectional.all(20.0),
                      child: Column(
                        children: [
                          textfield(
                            onChange: (value){
                              if(formkey.currentState!.validate()){
                                SearchCubit.get(context).getData(value);
                              }
                            },
                            InputType: TextInputType.text,
                            Controller: searchController,
                            labeltext: 'Search',
                            labelStyle: Colors.blue,
                            prefixicon: Icons.search_outlined,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          if(state is SearchLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 20.0,
                          ),
                          if(state is SearchSuccessState)
                            Expanded(
                              child : ListView.separated(
                                itemBuilder: (context,index) =>
                                    BuildItem(SearchCubit.get(context).searchModel?.data.ProductData[index],
                                    context),
                                separatorBuilder: (context,index) => Container(
                                  width: double.infinity,
                                  height: 2.0,
                                  color: Colors.black,
                                ),
                                itemCount: SearchCubit.get(context).searchModel!.data.ProductData.length,
                              ),
                              )
                        ],
                      ),
                  ),
                ));
            },
            listener: (context ,state) {},

    ),
    );
  }
}

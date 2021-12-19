import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/search_cubit/states.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/widgets/shared/components/constant.dart';
import 'package:shop_app/widgets/shared/network/remote/dio_helper.dart';
import 'package:shop_app/widgets/shared/network/remote/end_points.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitalState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModels? searchModels;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: searchUrl, token: token, data: {
      'text': text,
    }).then((value) {
      searchModels = SearchModels.fromJson(value.data);
      emit(SearchSuccessgState());
    }).catchError((e) {
      emit(SearchErrorState(e.toString()));
    });
  }
}

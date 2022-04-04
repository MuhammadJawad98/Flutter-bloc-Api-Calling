import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';
import '../../resources/api_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostLoading()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetPostList>((event, emit) async{
      try {
        emit(PostLoading());
        final mList = await _apiRepository.fetchPostList();
        log('>>>><<><> $mList');
        emit(PostLoaded(mList));
        // if (mList.error != null) {
        //   emit(PostLoadingError(mList.error));
        // }
      } on NetworkError {
        emit(const PostLoadingError("Failed to fetch data. is your device online?"));
      }
    });
  }
}

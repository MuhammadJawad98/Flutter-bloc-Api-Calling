import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_example/model/post_model.dart';

import '../model/covid_model.dart';
class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.covid19api.com/summary';

  Future<CovidModel> fetchCovidList() async {
    try {
      Response response = await _dio.get(_url);
      log('>>> $response');
      return CovidModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CovidModel.withError("Data not found / Connection issue");
    }
  }

  Future<List<Post>> fetchPostList()async{
    try{
      Response response=await _dio.get('https://jsonplaceholder.typicode.com/posts');
      var list = <Post>[];


      response.data.forEach((element) {
        Post userProfile = Post.fromJson(element);
        list.add(userProfile);
      });
      log('list >>> ${list.length}');

      return list;
    }catch(error,stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }
}
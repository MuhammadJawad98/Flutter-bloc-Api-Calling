import '../model/covid_model.dart';
import '../model/post_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<CovidModel> fetchCovidList() {
    return _provider.fetchCovidList();
  }

  Future<List<Post>> fetchPostList(){
    return _provider.fetchPostList();
  }

}

class NetworkError extends Error {}
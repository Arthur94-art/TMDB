abstract class BaseParams<T> {
  Map<String, dynamic> get params;
  set setParams(Map<String, dynamic> params);
}

class MovieListParams extends BaseParams<int> {
  static final MovieListParams _instance = MovieListParams._internal();

  MovieListParams._internal();

  factory MovieListParams() {
    return _instance;
  }

  Map<String, dynamic> _params = {'page': 1};

  @override
  Map<String, dynamic> get params => _params;

  @override
  set setParams(Map<String, dynamic> params) {
    _params = params;
  }
}

class PeopleListParams extends BaseParams {
  static final PeopleListParams _instance = PeopleListParams._internal();

  PeopleListParams._internal();

  factory PeopleListParams() {
    return _instance;
  }

  Map<String, dynamic> _params = {'page': 1};

  @override
  Map<String, dynamic> get params => _params;

  @override
  set setParams(Map<String, dynamic> params) {
    _params = params;
  }
}

class MovieDetailParams extends BaseParams {
  static final MovieDetailParams _instance = MovieDetailParams._internal();

  MovieDetailParams._internal();

  factory MovieDetailParams() {
    return _instance;
  }

  Map<String, dynamic> _params = {'id': 0};

  @override
  Map<String, dynamic> get params => _params;

  @override
  set setParams(Map<String, dynamic> params) {
    _params = params;
  }
}

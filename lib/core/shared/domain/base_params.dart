abstract class BaseParams {
  Map<String, dynamic> get params;
}

class MovieListParams extends BaseParams {
  @override
  Map<String, dynamic> get params => {'page': 1};
}

class PeopleListParams extends BaseParams {
  @override
  Map<String, dynamic> get params => {'page': 1};
}

abstract class BaseParams {
  Map<String, dynamic> get params;
}

class MovieListParams extends BaseParams {
  final int _page;
  MovieListParams(this._page);
  @override
  Map<String, dynamic> get params => {'page': _page};
}

class PeopleListParams extends BaseParams {
  final int _page;
  PeopleListParams(this._page);

  @override
  Map<String, dynamic> get params => {'page': _page};
}

class MovieDetailParams extends BaseParams {
  final int _id;
  MovieDetailParams(this._id);
  @override
  Map<String, dynamic> get params => {'id': _id};
}

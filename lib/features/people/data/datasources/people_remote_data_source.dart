import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';

class PeopleRemoteDataSourceImpl extends BaseRemoteDataSourceImpl<PeopleModel> {
  PeopleRemoteDataSourceImpl(super.apiClient, super.fromJson);
}

import 'package:tmdb/features/people/domain/entities/people_entity.dart';

class PeopleModel extends PeopleEntity {
  final bool? adult;
  final int? gender;
  final String? knownForDepartment;
  final String? originalName;
  final String? profilePath;

  PeopleModel(
      {this.adult = false,
      this.gender = 0,
      required super.id,
      this.knownForDepartment = '',
      required super.name,
      this.originalName = '',
      required super.popularity,
      this.profilePath = '',
      required super.image});

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        popularity: json['popularity'],
        image: json['profile_path'],
        knownForDepartment: json['known_for_department'],
        originalName: json['original_name'],
        adult: json['adult']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;

    return data;
  }
}

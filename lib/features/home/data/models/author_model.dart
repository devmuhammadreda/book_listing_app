import '../../domain/entities/authors_entity.dart';

class AuthorModel extends AuthorEntity {
  AuthorModel({
    super.name,
    super.birthYear,
    super.deathYear,
  });

  AuthorModel.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["birth_year"] is num) {
      birthYear = (json["birth_year"] as num).toInt();
    }
    if (json["death_year"] is num) {
      deathYear = (json["death_year"] as num).toInt();
    }
  }

  static List<AuthorEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(AuthorModel.fromJson).toList();
  }
}

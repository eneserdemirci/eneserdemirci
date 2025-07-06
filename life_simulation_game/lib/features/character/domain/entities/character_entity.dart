import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_entity.freezed.dart';
part 'character_entity.g.dart';

/// Character entity representing a life simulation character
@freezed
class CharacterEntity with _$CharacterEntity {
  const factory CharacterEntity({
    required String id,
    required String userId,
    required String name,
    required Gender gender,
    required DateTime birthDate,
    required CharacterStats stats,
    required String career,
    required double money,
    required RelationshipStatus relationshipStatus,
    required List<String> achievements,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CharacterEntity;

  factory CharacterEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterEntityFromJson(json);
}

/// Character statistics
@freezed
class CharacterStats with _$CharacterStats {
  const factory CharacterStats({
    @Default(50) int health,
    @Default(50) int happiness,
    @Default(50) int intelligence,
    @Default(50) int fitness,
    @Default(50) int creativity,
    @Default(50) int socialSkills,
    @Default(0) int experience,
    @Default(1) int level,
  }) = _CharacterStats;

  factory CharacterStats.fromJson(Map<String, dynamic> json) =>
      _$CharacterStatsFromJson(json);
}

/// Character gender
enum Gender {
  male,
  female,
  other,
}

/// Relationship status
enum RelationshipStatus {
  single,
  dating,
  engaged,
  married,
  divorced,
  widowed,
}

/// Character age extension
extension CharacterAge on CharacterEntity {
  int get age {
    final now = DateTime.now();
    final age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      return age - 1;
    }
    return age;
  }
  
  String get ageGroup {
    final currentAge = age;
    if (currentAge < 13) return 'Child';
    if (currentAge < 20) return 'Teen';
    if (currentAge < 30) return 'Young Adult';
    if (currentAge < 50) return 'Adult';
    if (currentAge < 65) return 'Middle-aged';
    return 'Senior';
  }
}
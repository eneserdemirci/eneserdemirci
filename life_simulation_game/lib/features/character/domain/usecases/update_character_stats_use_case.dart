import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/features/character/domain/entities/character_entity.dart';
import 'package:life_simulation_game/features/character/domain/repositories/character_repository.dart';

/// Use case for updating character stats
@injectable
class UpdateCharacterStatsUseCase {
  final CharacterRepository _characterRepository;

  UpdateCharacterStatsUseCase(this._characterRepository);

  Future<CharacterEntity> call({
    required String characterId,
    required CharacterStats stats,
  }) async {
    if (characterId.isEmpty) {
      throw Exception('Character ID cannot be empty');
    }

    // Validate stats (0-100 range)
    if (stats.health < 0 || stats.health > 100 ||
        stats.happiness < 0 || stats.happiness > 100 ||
        stats.intelligence < 0 || stats.intelligence > 100 ||
        stats.fitness < 0 || stats.fitness > 100 ||
        stats.creativity < 0 || stats.creativity > 100 ||
        stats.socialSkills < 0 || stats.socialSkills > 100) {
      throw Exception('All stats must be between 0 and 100');
    }

    if (stats.experience < 0) {
      throw Exception('Experience cannot be negative');
    }

    if (stats.level < 1) {
      throw Exception('Level must be at least 1');
    }

    return await _characterRepository.updateCharacterStats(characterId, stats);
  }
}
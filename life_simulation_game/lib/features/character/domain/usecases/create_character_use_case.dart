import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/features/character/domain/entities/character_entity.dart';
import 'package:life_simulation_game/features/character/domain/repositories/character_repository.dart';
import 'package:uuid/uuid.dart';

/// Use case for creating a new character
@injectable
class CreateCharacterUseCase {
  final CharacterRepository _characterRepository;
  final Uuid _uuid = const Uuid();

  CreateCharacterUseCase(this._characterRepository);

  Future<CharacterEntity> call({
    required String userId,
    required String name,
    required Gender gender,
    required DateTime birthDate,
    String career = 'Student',
  }) async {
    // Validate input
    if (name.trim().isEmpty) {
      throw Exception('Character name cannot be empty');
    }

    if (name.length < 2 || name.length > 50) {
      throw Exception('Character name must be between 2 and 50 characters');
    }

    final now = DateTime.now();
    if (birthDate.isAfter(now)) {
      throw Exception('Birth date cannot be in the future');
    }

    // Calculate age
    final age = now.year - birthDate.year;
    if (age < 0 || age > 120) {
      throw Exception('Invalid age. Age must be between 0 and 120');
    }

    // Create character
    final character = CharacterEntity(
      id: _uuid.v4(),
      userId: userId,
      name: name.trim(),
      gender: gender,
      birthDate: birthDate,
      stats: const CharacterStats(),
      career: career,
      money: 100.0, // Starting money
      relationshipStatus: RelationshipStatus.single,
      achievements: [],
      createdAt: now,
      updatedAt: now,
    );

    return await _characterRepository.createCharacter(character);
  }
}
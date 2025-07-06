import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/features/character/domain/entities/character_entity.dart';
import 'package:life_simulation_game/features/character/domain/repositories/character_repository.dart';

/// Use case for getting user's characters
@injectable
class GetUserCharactersUseCase {
  final CharacterRepository _characterRepository;

  GetUserCharactersUseCase(this._characterRepository);

  Future<List<CharacterEntity>> call(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID cannot be empty');
    }

    return await _characterRepository.getUserCharacters(userId);
  }
}
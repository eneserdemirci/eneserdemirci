import 'package:life_simulation_game/features/character/domain/entities/character_entity.dart';

/// Character repository interface
abstract class CharacterRepository {
  /// Create a new character
  Future<CharacterEntity> createCharacter(CharacterEntity character);
  
  /// Get character by ID
  Future<CharacterEntity?> getCharacterById(String characterId);
  
  /// Get user's characters
  Future<List<CharacterEntity>> getUserCharacters(String userId);
  
  /// Update character
  Future<CharacterEntity> updateCharacter(CharacterEntity character);
  
  /// Delete character
  Future<void> deleteCharacter(String characterId);
  
  /// Get character stream for real-time updates
  Stream<CharacterEntity?> getCharacterStream(String characterId);
  
  /// Update character stats
  Future<CharacterEntity> updateCharacterStats(
    String characterId,
    CharacterStats stats,
  );
  
  /// Add achievement to character
  Future<CharacterEntity> addAchievement(
    String characterId,
    String achievement,
  );
  
  /// Update character money
  Future<CharacterEntity> updateCharacterMoney(
    String characterId,
    double amount,
  );
  
  /// Age character (called daily)
  Future<CharacterEntity> ageCharacter(String characterId);
}
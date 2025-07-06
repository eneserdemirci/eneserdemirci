import 'package:flutter_test/flutter_test.dart';
import 'package:life_simulation_game/features/character/domain/entities/character_entity.dart';
import 'package:life_simulation_game/features/character/domain/usecases/create_character_use_case.dart';
import 'package:life_simulation_game/features/character/domain/repositories/character_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'create_character_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CharacterRepository>()])
void main() {
  late CreateCharacterUseCase useCase;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    useCase = CreateCharacterUseCase(mockCharacterRepository);
  });

  group('CreateCharacterUseCase', () {
    const String tUserId = 'user123';
    const String tName = 'Test Character';
    const Gender tGender = Gender.male;
    final DateTime tBirthDate = DateTime(2000, 1, 1);
    const String tCareer = 'Student';

    final CharacterEntity tCharacter = CharacterEntity(
      id: 'char123',
      userId: tUserId,
      name: tName,
      gender: tGender,
      birthDate: tBirthDate,
      stats: const CharacterStats(),
      career: tCareer,
      money: 100.0,
      relationshipStatus: RelationshipStatus.single,
      achievements: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('should create character with valid data', () async {
      // Arrange
      when(mockCharacterRepository.createCharacter(any))
          .thenAnswer((_) async => tCharacter);

      // Act
      final result = await useCase(
        userId: tUserId,
        name: tName,
        gender: tGender,
        birthDate: tBirthDate,
        career: tCareer,
      );

      // Assert
      expect(result, isA<CharacterEntity>());
      expect(result.name, equals(tName));
      expect(result.gender, equals(tGender));
      expect(result.birthDate, equals(tBirthDate));
      expect(result.career, equals(tCareer));
      verify(mockCharacterRepository.createCharacter(any)).called(1);
    });

    test('should throw exception when name is empty', () async {
      // Act & Assert
      expect(
        () => useCase(
          userId: tUserId,
          name: '',
          gender: tGender,
          birthDate: tBirthDate,
        ),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockCharacterRepository.createCharacter(any));
    });

    test('should throw exception when name is too short', () async {
      // Act & Assert
      expect(
        () => useCase(
          userId: tUserId,
          name: 'A',
          gender: tGender,
          birthDate: tBirthDate,
        ),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockCharacterRepository.createCharacter(any));
    });

    test('should throw exception when name is too long', () async {
      // Act & Assert
      expect(
        () => useCase(
          userId: tUserId,
          name: 'A' * 51,
          gender: tGender,
          birthDate: tBirthDate,
        ),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockCharacterRepository.createCharacter(any));
    });

    test('should throw exception when birth date is in the future', () async {
      // Act & Assert
      expect(
        () => useCase(
          userId: tUserId,
          name: tName,
          gender: tGender,
          birthDate: DateTime.now().add(const Duration(days: 1)),
        ),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockCharacterRepository.createCharacter(any));
    });

    test('should throw exception when character would be too old', () async {
      // Act & Assert
      expect(
        () => useCase(
          userId: tUserId,
          name: tName,
          gender: tGender,
          birthDate: DateTime(1900, 1, 1),
        ),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockCharacterRepository.createCharacter(any));
    });
  });
}
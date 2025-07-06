import 'package:flutter_test/flutter_test.dart';
import 'package:life_simulation_game/features/authentication/domain/entities/user_entity.dart';
import 'package:life_simulation_game/features/authentication/domain/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:life_simulation_game/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'sign_in_with_email_and_password_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  late SignInWithEmailAndPasswordUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignInWithEmailAndPasswordUseCase(mockAuthRepository);
  });

  group('SignInWithEmailAndPasswordUseCase', () {
    const String tEmail = 'test@example.com';
    const String tPassword = 'password123';
    final UserEntity tUser = UserEntity(
      id: '1',
      email: tEmail,
      createdAt: DateTime.now(),
    );

    test('should sign in user with valid credentials', () async {
      // Arrange
      when(mockAuthRepository.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => tUser);

      // Act
      final result = await useCase(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result, equals(tUser));
      verify(mockAuthRepository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      )).called(1);
    });

    test('should throw exception when email is empty', () async {
      // Act & Assert
      expect(
        () => useCase(email: '', password: tPassword),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockAuthRepository.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ));
    });

    test('should throw exception when password is empty', () async {
      // Act & Assert
      expect(
        () => useCase(email: tEmail, password: ''),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockAuthRepository.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ));
    });

    test('should throw exception when email format is invalid', () async {
      // Act & Assert
      expect(
        () => useCase(email: 'invalid-email', password: tPassword),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockAuthRepository.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ));
    });

    test('should throw exception when password is too short', () async {
      // Act & Assert
      expect(
        () => useCase(email: tEmail, password: '12345'),
        throwsA(isA<Exception>()),
      );
      verifyNever(mockAuthRepository.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ));
    });
  });
}
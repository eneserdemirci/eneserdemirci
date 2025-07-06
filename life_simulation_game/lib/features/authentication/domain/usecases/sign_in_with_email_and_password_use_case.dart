import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/features/authentication/domain/entities/user_entity.dart';
import 'package:life_simulation_game/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for signing in with email and password
@injectable
class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _authRepository;

  SignInWithEmailAndPasswordUseCase(this._authRepository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    return await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}
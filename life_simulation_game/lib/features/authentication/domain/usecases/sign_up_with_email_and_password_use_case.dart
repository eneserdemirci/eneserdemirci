import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/features/authentication/domain/entities/user_entity.dart';
import 'package:life_simulation_game/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for signing up with email and password
@injectable
class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _authRepository;

  SignUpWithEmailAndPasswordUseCase(this._authRepository);

  Future<UserEntity> call({
    required String email,
    required String password,
    String? displayName,
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

    if (displayName != null && displayName.trim().isEmpty) {
      throw Exception('Display name cannot be empty');
    }

    return await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}
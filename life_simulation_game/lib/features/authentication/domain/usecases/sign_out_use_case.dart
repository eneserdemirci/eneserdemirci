import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for signing out
@injectable
class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  Future<void> call() async {
    await _authRepository.signOut();
  }
}
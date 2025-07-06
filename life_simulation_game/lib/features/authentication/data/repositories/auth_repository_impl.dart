import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/features/authentication/data/datasources/firebase_auth_data_source.dart';
import 'package:life_simulation_game/features/authentication/domain/entities/user_entity.dart';
import 'package:life_simulation_game/features/authentication/domain/repositories/auth_repository.dart';

/// Implementation of AuthRepository using Firebase
@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Stream<UserEntity?> get authStateChanges {
    return _authDataSource.authStateChanges
        .map((userModel) => userModel?.toEntity());
  }

  @override
  UserEntity? get currentUser {
    return _authDataSource.currentUser?.toEntity();
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userModel = await _authDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final userModel = await _authDataSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
    return userModel.toEntity();
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _authDataSource.resetPassword(email: email);
  }

  @override
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    await _authDataSource.updateProfile(
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _authDataSource.deleteAccount();
  }
}
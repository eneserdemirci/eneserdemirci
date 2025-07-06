import 'package:life_simulation_game/features/authentication/domain/entities/user_entity.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Stream of authentication state changes
  Stream<UserEntity?> get authStateChanges;
  
  /// Get current user
  UserEntity? get currentUser;
  
  /// Sign in with email and password
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Sign up with email and password
  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });
  
  /// Sign out
  Future<void> signOut();
  
  /// Reset password
  Future<void> resetPassword({
    required String email,
  });
  
  /// Update user profile
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
  });
  
  /// Delete account
  Future<void> deleteAccount();
}
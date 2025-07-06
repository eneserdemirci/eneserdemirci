import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_simulation_game/core/injection/injection.dart';
import 'package:life_simulation_game/features/authentication/domain/entities/user_entity.dart';
import 'package:life_simulation_game/features/authentication/domain/repositories/auth_repository.dart';
import 'package:life_simulation_game/features/authentication/domain/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:life_simulation_game/features/authentication/domain/usecases/sign_up_with_email_and_password_use_case.dart';
import 'package:life_simulation_game/features/authentication/domain/usecases/sign_out_use_case.dart';

/// Auth state provider
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final authRepository = getIt<AuthRepository>();
  return authRepository.authStateChanges;
});

/// Auth controller provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    signInUseCase: getIt<SignInWithEmailAndPasswordUseCase>(),
    signUpUseCase: getIt<SignUpWithEmailAndPasswordUseCase>(),
    signOutUseCase: getIt<SignOutUseCase>(),
  );
});

/// Auth controller state
class AuthState {
  final bool isLoading;
  final String? error;
  final bool isSignUpMode;

  const AuthState({
    this.isLoading = false,
    this.error,
    this.isSignUpMode = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isSignUpMode,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSignUpMode: isSignUpMode ?? this.isSignUpMode,
    );
  }
}

/// Auth controller
class AuthController extends StateNotifier<AuthState> {
  final SignInWithEmailAndPasswordUseCase _signInUseCase;
  final SignUpWithEmailAndPasswordUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthController({
    required SignInWithEmailAndPasswordUseCase signInUseCase,
    required SignUpWithEmailAndPasswordUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        super(const AuthState());

  /// Toggle between sign in and sign up modes
  void toggleMode() {
    state = state.copyWith(
      isSignUpMode: !state.isSignUpMode,
      error: null,
    );
  }

  /// Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _signInUseCase(
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Sign up with email and password
  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _signUpUseCase(
        email: email,
        password: password,
        displayName: displayName,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _signOutUseCase();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_simulation_game/core/theme/app_theme.dart';
import 'package:life_simulation_game/features/authentication/presentation/providers/auth_provider.dart';

/// Authentication form widget
class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({super.key});

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
          ),
        );
        // Clear error after showing
        Future.microtask(() {
          ref.read(authControllerProvider.notifier).clearError();
        });
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Display Name field (only for sign up)
          if (authState.isSignUpMode) ...[
            TextFormField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                hintText: 'Enter your display name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (authState.isSignUpMode && 
                    (value == null || value.trim().isEmpty)) {
                  return 'Please enter your display name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],
          
          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          // Password field
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          
          // Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: authState.isLoading ? null : _onSubmit,
              child: authState.isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      authState.isSignUpMode ? 'Sign Up' : 'Sign In',
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final authState = ref.read(authControllerProvider);
      final authController = ref.read(authControllerProvider.notifier);
      
      if (authState.isSignUpMode) {
        authController.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _displayNameController.text.trim(),
        );
      } else {
        authController.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      }
    }
  }
}
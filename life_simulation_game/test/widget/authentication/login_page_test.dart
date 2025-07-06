import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_simulation_game/features/authentication/presentation/pages/login_page.dart';

void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('should display login form elements', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Verify app title
      expect(find.text('Life Simulation'), findsOneWidget);
      expect(find.text('Live your virtual life'), findsOneWidget);

      // Verify form fields
      expect(find.byType(TextFormField), findsAtLeast(2));
      
      // Verify email field
      expect(find.text('Email'), findsOneWidget);
      
      // Verify password field
      expect(find.text('Password'), findsOneWidget);
      
      // Verify submit button
      expect(find.text('Sign In'), findsOneWidget);
      
      // Verify mode toggle
      expect(find.text('Don\'t have an account? '), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('should toggle between sign in and sign up modes', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Initially should be in sign in mode
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Don\'t have an account? '), findsOneWidget);

      // Tap on sign up link
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Should switch to sign up mode
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Already have an account? '), findsOneWidget);
      
      // Should show display name field in sign up mode
      expect(find.text('Display Name'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty fields', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Tap submit button without entering data
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Should show validation errors
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('should show validation error for invalid email format', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      
      // Tap submit button
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Should show email validation error
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('should show validation error for short password', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Enter valid email but short password
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, '123');
      
      // Tap submit button
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Should show password validation error
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });
  });
}
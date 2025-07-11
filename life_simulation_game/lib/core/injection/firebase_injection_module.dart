# Firebase Auth injection
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @injectable
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
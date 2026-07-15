import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signup({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Authentication failed"));
    } catch (_) {
      emit(AuthFailure("Something went wrong"));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Authentication failed"));
    } catch (_) {
      emit(AuthFailure("Something went wrong"));
    }
  }
  Future<void> signOut()async{
    await firebaseAuth.signOut();
  }
}
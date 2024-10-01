
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_cubit_app/models/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      // Simulate login process
      await Future.delayed(Duration(seconds: 1));
      if (email == 'test@example.com' && password == 'password') {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Invalid credentials'));
      }
    } catch (e) {
      emit(AuthFailure('An error occurred'));
    }
  }

  void logout() {
    emit(AuthInitial());
  }
}


import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		blocTest<AuthCubit, AuthState>(
			'initial state is AuthInitial',
			build: () => AuthCubit(),
			verify: (cubit) => expect(cubit.state, AuthInitial())
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthSuccess] when login is successful',
			build: () => AuthCubit(),
			act: (cubit) {
				cubit.login('test@example.com', 'password');
			},
			expect: () => [AuthLoading(), AuthSuccess()]
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthFailure] when login fails',
			build: () => AuthCubit(),
			act: (cubit) {
				cubit.login('wrong@example.com', 'wrongpassword');
			},
			expect: () => [AuthLoading(), AuthFailure('Invalid credentials')]
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthInitial] when logout is called',
			build: () => AuthCubit(),
			act: (cubit) {
				cubit.logout();
			},
			expect: () => [AuthInitial()]
		);
	});
}

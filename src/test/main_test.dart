
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders MaterialApp with initial route set to login screen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(MaterialApp), findsOneWidget);
			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});

	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [] when nothing is called',
			build: () => authCubit,
			expect: () => [],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthSuccess] when login is called',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthLoading(), AuthSuccess(user: User(email: 'test@example.com', password: 'password'))],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthInitial] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [AuthInitial()],
		);
	});

	group('User Model', () {
		test('User can be serialized/deserialized correctly', () {
			final user = User(email: 'test@example.com', password: 'password');
			final userJson = user.toJson();
			final deserializedUser = User.fromJson(userJson);

			expect(deserializedUser.email, 'test@example.com');
			expect(deserializedUser.password, 'password');
		});
	});
}

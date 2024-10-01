
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/widgets/login_form.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart'; // Assuming this is the cubit used in login_form.dart

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('should display email and password fields and login button', (tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: authCubit,
					child: MaterialApp(home: Scaffold(body: LoginForm())),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
			expect(find.byType(ElevatedButton), findsOneWidget); // Login Button
		});

		testWidgets('should call login on AuthCubit when login button is pressed', (tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: authCubit,
					child: MaterialApp(home: Scaffold(body: LoginForm())),
				),
			);

			await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
			await tester.enterText(find.byType(TextFormField).last, 'password123');
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => authCubit.login('test@example.com', 'password123')).called(1);
		});
	});
}

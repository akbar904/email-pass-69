
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/widgets/logout_button.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('LogoutButton displays correctly', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (context) => mockAuthCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			expect(find.byType(RaisedButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('LogoutButton calls logout on AuthCubit when pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (context) => mockAuthCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			await tester.tap(find.byType(RaisedButton));
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}

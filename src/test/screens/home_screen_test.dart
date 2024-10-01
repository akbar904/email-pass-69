
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:your_package_name/screens/home_screen.dart';
import 'package:your_package_name/widgets/logout_button.dart'; // Assuming LogoutButton is needed for widget tests

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen', () {
		group('UI tests', () {
			testWidgets('Renders correct widgets', (WidgetTester tester) async {
				// Arrange
				await tester.pumpWidget(MaterialApp(home: HomeScreen()));

				// Act
				final logoutButton = find.byType(LogoutButton);
				final scaffold = find.byType(Scaffold);

				// Assert
				expect(scaffold, findsOneWidget);
				expect(logoutButton, findsOneWidget);
			});
		});

		group('Cubit interaction tests', () {
			late MockAuthCubit mockAuthCubit;

			setUp(() {
				mockAuthCubit = MockAuthCubit();
			});

			blocTest<MockAuthCubit, AuthState>(
				'Logout button triggers logout event',
				build: () => mockAuthCubit,
				act: (cubit) {
					when(() => mockAuthCubit.logout()).thenReturn(null);
					
					// Trigger the UI event
					tap(find.byType(LogoutButton));
				},
				verify: (_) {
					verify(() => mockAuthCubit.logout()).called(1);
				},
			);
		});
	});
}

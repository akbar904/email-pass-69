
import 'package:flutter/material.dart';
import 'package:your_package_name/widgets/logout_button.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
			),
			body: Center(
				child: LogoutButton(),
			),
		);
	}
}

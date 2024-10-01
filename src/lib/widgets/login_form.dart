
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class LoginForm extends StatefulWidget {
	const LoginForm({Key? key}) : super(key: key);

	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Form(
			key: _formKey,
			child: Column(
				children: [
					TextFormField(
						controller: _emailController,
						decoration: InputDecoration(labelText: 'Email'),
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your email';
							}
							return null;
						},
					),
					TextFormField(
						controller: _passwordController,
						obscureText: true,
						decoration: InputDecoration(labelText: 'Password'),
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your password';
							}
							return null;
						},
					),
					ElevatedButton(
						onPressed: () {
							if (_formKey.currentState!.validate()) {
								context.read<AuthCubit>().login(
									_emailController.text, 
									_passwordController.text
								);
							}
						},
						child: Text('Login'),
					),
				],
			),
		);
	}
}

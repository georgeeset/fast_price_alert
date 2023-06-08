import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/login_signup_cubit/cubit/login_signup_cubit.dart';
import '../../widgets/password_input.dart';
import '../../widgets/username_input.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const UserNameInput(),
        const SizedBox(height: 10),
        const PasswordInputField(),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
                onPressed: () {
                  context.read<LoginSignupCubit>().signupSelected();
                },
                child: const Text('Signup')),
            ElevatedButton(
                onPressed: () {
                  context.read<LoginSignupCubit>().loginSelected();
                },
                child: const Text('Login')),
          ],
        )
      ],
    );
  }
}

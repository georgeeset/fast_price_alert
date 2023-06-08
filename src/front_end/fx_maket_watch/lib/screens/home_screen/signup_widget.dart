import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/login_signup_cubit/cubit/login_signup_cubit.dart';
import 'package:fx_maket_watch/widgets/username_input.dart';

import '../../cubits/interest_select_cubit/interest_select_cubit.dart';
import '../../widgets/multiselect_dialog.dart';
import '../../widgets/name_input.dart';
import '../../widgets/password_input.dart';
import '../../widgets/surname_input.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const UserNameInput(),
        const SizedBox(height: 10),
        const PasswordInputField(),
        const SizedBox(height: 10),
        const NameInputField(),
        const SizedBox(height: 10),
        const SurnameInput(),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return multiSelect(context);
              },
            );
          },
          child: const Text('Add Interest'),
        ),
        BlocBuilder<InterestSelectCubit, List<String>>(
            builder: (context, state) {
          return Wrap(
            children: state
                .map((e) => TextButton(onPressed: () {}, child: Text(e)))
                .toList(),
          );
        }),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
                onPressed: () {
                  context.read<LoginSignupCubit>().loginSelected();
                },
                child: const Text('Login')),
            ElevatedButton(
                onPressed: () {
                  context.read<LoginSignupCubit>().signupSelected();
                },
                child: const Text('Signup')),
          ],
        )
      ],
    );
  }
}

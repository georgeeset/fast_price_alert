import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/email_textfield_cubit/email_text_field_cubit.dart';
import 'package:fx_maket_watch/cubits/password_textfield_cubit/password_textfield_cubit.dart';
import 'package:fx_maket_watch/widgets/email_input.dart';
import 'package:fx_maket_watch/widgets/password_input.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EmailTextfieldCubit()),
        BlocProvider(create: (_) => PasswordTextfieldCubit()),
      ],
      child: const SizedBox(
        height: 400,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailInputField(),
            SizedBox(
              height: 10,
            ),
            PasswordInputField(),
          ],
        ),
      ),
    );
  }
}

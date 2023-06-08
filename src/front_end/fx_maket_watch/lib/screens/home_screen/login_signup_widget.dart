import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/email_textfield_cubit/email_text_field_cubit.dart';
import 'package:fx_maket_watch/cubits/login_signup_cubit/cubit/login_signup_cubit.dart';
import 'package:fx_maket_watch/cubits/name_textfield_cubit/name_input_cubit.dart';
import 'package:fx_maket_watch/cubits/password_textfield_cubit/password_textfield_cubit.dart';
import 'package:fx_maket_watch/cubits/surname_textfield_cubit/surname_input_cubit.dart';
import 'package:fx_maket_watch/cubits/username_textfield_cubit/cubit/user_name_input_cubit.dart';
import 'login_widget.dart';
import 'signup_widget.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: 300,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => EmailTextfieldCubit()),
            BlocProvider(create: (_) => PasswordTextfieldCubit()),
            BlocProvider(create: (_) => NameInputCubit()),
            BlocProvider(create: (_) => SurnameInputCubit()),
            BlocProvider<UserNameInputCubit>(
                create: (_) => UserNameInputCubit()),
          ],
          child: BlocBuilder<LoginSignupCubit, LoginSignupState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                switchInCurve: Curves.bounceIn,
                switchOutCurve: Curves.bounceOut,
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 500),
                child: state is SignupState ? const Signup() : const Login(),
              );
            },
          )),
    );
  }
}

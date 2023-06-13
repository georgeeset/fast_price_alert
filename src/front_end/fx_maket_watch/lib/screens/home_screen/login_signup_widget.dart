import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/email_textfield_cubit/email_text_field_cubit.dart';
import 'package:fx_maket_watch/cubits/login_signup_cubit/cubit/login_signup_cubit.dart';
import 'package:fx_maket_watch/cubits/name_textfield_cubit/name_input_cubit.dart';
import 'package:fx_maket_watch/cubits/password_textfield_cubit/password_textfield_cubit.dart';
import 'package:fx_maket_watch/cubits/repeat_password_textfield_cubit/cubit/repeat_password_textfield_cubit.dart';
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
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(style: BorderStyle.solid),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => EmailTextfieldCubit()),
            BlocProvider(create: (context) => PasswordTextfieldCubit()),
            BlocProvider(create: (context) => NameInputCubit()),
            BlocProvider(create: (context) => SurnameInputCubit()),
            BlocProvider<RepeatPasswordTextfieldCubit>(
              create: (context) => RepeatPasswordTextfieldCubit(
                firstPassword: context.read<PasswordTextfieldCubit>(),
              ),
            ),
            BlocProvider<UserNameInputCubit>(
                create: (_) => UserNameInputCubit()),
          ],
          child: BlocBuilder<LoginSignupCubit, LoginSignupState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                switchInCurve: Curves.fastOutSlowIn,
                switchOutCurve: Curves.bounceOut,
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 800),
                child: state is SignupState ? const Signup() : const Login(),
              );
            },
          )),
    );
  }
}

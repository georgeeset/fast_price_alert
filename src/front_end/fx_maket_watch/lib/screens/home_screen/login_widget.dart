import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/cubits/password_textfield_cubit/password_textfield_cubit.dart';
import 'package:fx_maket_watch/cubits/username_textfield_cubit/cubit/user_name_input_cubit.dart';
import 'package:fx_maket_watch/widgets/snackbar_message_widget.dart';

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
        const PasswordInputField(
          showWarning: false,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
                onPressed: () {
                  context.read<LoginSignupCubit>().signupSelected();
                },
                child: const Text('Signup')),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, authState) {
                if (authState is AuthenticatedState) {
                  showSnackBar(context: context, message: "LogedIn");
                }
                if (authState is AuthenticationError) {
                  showSnackBar(
                      context: context, message: "Invalid Username / Password");
                }
              },
              child: ElevatedButton(
                onPressed: () {
                  var userNameInfo = context.read<UserNameInputCubit>().state;
                  var passwordInfo =
                      context.read<PasswordTextfieldCubit>().state;

                  if (userNameInfo is UserNameInputOk &&
                      passwordInfo is PasswordTextfieldOk) {
                    context.read<AuthenticationBloc>().add(
                          LoginEvent(
                            userName: userNameInfo.userName,
                            password: passwordInfo.password,
                          ),
                        );
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        )
      ],
    );
  }
}

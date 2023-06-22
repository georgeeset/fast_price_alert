import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/cubits/login_signup_cubit/cubit/login_signup_cubit.dart';
import 'package:fx_maket_watch/cubits/name_textfield_cubit/name_input_cubit.dart';
import 'package:fx_maket_watch/cubits/password_textfield_cubit/password_textfield_cubit.dart';
import 'package:fx_maket_watch/cubits/repeat_password_textfield_cubit/cubit/repeat_password_textfield_cubit.dart';
import 'package:fx_maket_watch/cubits/surname_textfield_cubit/surname_input_cubit.dart';
import 'package:fx_maket_watch/cubits/username_textfield_cubit/cubit/user_name_input_cubit.dart';
import 'package:fx_maket_watch/widgets/repeat_password_input.dart';
import 'package:fx_maket_watch/widgets/username_input.dart';

import '../../cubits/interest_select_cubit/interest_select_cubit.dart';
import '../../widgets/multiselect_dialog.dart';
import '../../widgets/name_input.dart';
import '../../widgets/password_input.dart';
import '../../widgets/snackbar_message_widget.dart';
import '../../widgets/surname_input.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Register',
            style: TextStyle(fontSize: 20.0, color: Colors.black87),
          ),
          const SizedBox(
            height: 15,
          ),
          const UserNameInput(),
          const SizedBox(height: 10),
          const PasswordInputField(),
          const SizedBox(height: 10),
          const RepeatPasswordInputField(),
          const SizedBox(height: 10),
          const NameInputField(),
          const SizedBox(height: 10),
          const SurnameInput(),
          const SizedBox(height: 20),
          BlocBuilder<InterestSelectCubit, List<String>>(
            builder: (context, state) {
              return OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: state.isEmpty
                        ? const MaterialStatePropertyAll(Colors.black45)
                        : const MaterialStatePropertyAll(Colors.white10)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return multiSelect(context);
                    },
                  );
                },
                child: const Text('Interests +'),
              );
            },
          ),
          BlocBuilder<InterestSelectCubit, List<String>>(
              builder: (context, state) {
            return Wrap(
              children: state
                  .map((e) => TextButton(
                        onPressed: () {},
                        child: Text(
                          e,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ))
                  .toList(),
            );
          }),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  context.read<UserNameInputCubit>().updateUserName(name: '');
                  context.read<PasswordTextfieldCubit>().updateText('');
                  context.read<LoginSignupCubit>().loginSelected();
                },
                child: const Text('Login'),
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is RegisteredState) {
                    showSnackBar(
                      context: context,
                      message: "Registeration Successful !",
                    );
                    context.read<LoginSignupCubit>().loginSelected();
                  } else {
                    if (state is AuthenticationError) {
                      showSnackBar(
                        context: context,
                        message: state.message,
                      );
                    }
                  }
                },
                child: ElevatedButton(
                    onPressed: () {
                      if (context.read<AuthenticationBloc>().state
                          is AuthenticationLoadingState) {
                        return;
                      }

                      var name = context.read<NameInputCubit>().state;
                      var password =
                          context.read<PasswordTextfieldCubit>().state;
                      var surname = context.read<SurnameInputCubit>().state;
                      var repeatPassword =
                          context.read<RepeatPasswordTextfieldCubit>().state;
                      var userName = context.read<UserNameInputCubit>().state;
                      var interests = context.read<InterestSelectCubit>().state;

                      if (name is NameInputOk &&
                          surname is SurnameInputOk &&
                          password is PasswordTextfieldOk &&
                          repeatPassword is RepeatPasswordTextfieldOk &&
                          userName is UserNameInputOk &&
                          interests.isNotEmpty) {
                        context.read<AuthenticationBloc>().add(RegisterEvent(
                            firstName: name.name,
                            surname: surname.surname,
                            userName: userName.userName,
                            password: password.password,
                            interests: interests));
                      }
                    },
                    child: const Text('Signup')),
              ),
            ],
          )
        ],
      ),
    );
  }
}

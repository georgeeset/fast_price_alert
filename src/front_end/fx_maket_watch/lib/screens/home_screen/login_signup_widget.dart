import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/email_textfield_cubit/email_text_field_cubit.dart';
import 'package:fx_maket_watch/cubits/interest_select_cubit/interest_select_cubit.dart';
import 'package:fx_maket_watch/cubits/name_textfield_cubit/name_input_cubit.dart';
import 'package:fx_maket_watch/cubits/password_textfield_cubit/password_textfield_cubit.dart';
import 'package:fx_maket_watch/cubits/surname_textfield_cubit/surname_input_cubit.dart';
import 'package:fx_maket_watch/widgets/email_input.dart';
import 'package:fx_maket_watch/widgets/multiselect_dialog.dart';
import 'package:fx_maket_watch/widgets/name_input.dart';
import 'package:fx_maket_watch/widgets/password_input.dart';
import 'package:fx_maket_watch/widgets/surname_input.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EmailTextfieldCubit()),
        BlocProvider(create: (_) => PasswordTextfieldCubit()),
        BlocProvider(create: (_) => NameInputCubit()),
        BlocProvider(create: (_) => SurnameInputCubit()),
      ],
      child: SizedBox(
        height: 800,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmailInputField(),
            const SizedBox(height: 10),
            const PasswordInputField(),
            const SizedBox(height: 10),
            const NameInputField(),
            const SizedBox(height: 10),
            const SurnameInput(),
            const SizedBox(height: 10),
            OutlinedButton(
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
                children: state.map((e) => Text(e)).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

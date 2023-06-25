import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/repeat_password_textfield_cubit/cubit/repeat_password_textfield_cubit.dart';

class RepeatPasswordInputField extends StatelessWidget {
  const RepeatPasswordInputField({Key? key, this.labelText = 'Repeat Password'})
      : super(key: key);

  final String labelText;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepeatPasswordTextfieldCubit,
        RepeatPasswordTextfieldState>(
      builder: (context, state) => TextField(
        keyboardType: TextInputType.text,
        obscureText: true,
        enabled: true,
        textAlign: TextAlign.justify,
        textInputAction: TextInputAction.done,
        onChanged: (val) {
          final cubitHandle = context.read<RepeatPasswordTextfieldCubit>();
          cubitHandle.updateText(password: val);
        },
        // onSubmitted: (val) async {
        //   final cubitHandle = context.read<PasswordTextfieldCubit>();
        //   if (cubitHandle.state is PasswordTextfieldOk) {
        //     // call the correct function and padd val
        //     context.read<AuthenticationCubit>().verifyPhoneNumber(val);
        //   }
        // },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          //enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
          errorText:
              state is RepeatPasswordTextfieldError ? state.message : null,
          hintText: '*******',
          labelText: labelText,
          isDense: true,
          prefixIcon: const Icon(
            Icons.lock,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

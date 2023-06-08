import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/username_textfield_cubit/cubit/user_name_input_cubit.dart';

class UserNameInput extends StatelessWidget {
  const UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserNameInputCubit, UserNameInputState>(
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.text,
          enabled: true,
          textInputAction: TextInputAction.done,
          onChanged: (val) {
            final cubitHandle = context.read<UserNameInputCubit>();
            cubitHandle.updateUserName(name: val);
          },
          // onSubmitted: (val) async {
          //   final cubitHandle = context.read<PhoneTextfieldCubit>();
          //   if (cubitHandle.state is PhoneTextfieldOk) {
          //     // call the correct function and padd val
          //     context.read<AuthenticationCubit>().verifyPhoneNumber(val);
          //   }
          // },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            //enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
            errorText: state is UserNameInputError ? state.message : null,
            hintText: 'user.name or email',
            labelText: 'Login Name',
            isDense: true,
            prefixIcon: const Icon(Icons.person),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        );
      },
    );
  }
}

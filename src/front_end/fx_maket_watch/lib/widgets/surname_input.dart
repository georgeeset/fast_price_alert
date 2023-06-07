import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/surname_textfield_cubit/surname_input_cubit.dart';

class SurnameInput extends StatelessWidget {
  const SurnameInput({super.key, this.labelText = 'Surname'});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurnameInputCubit, SurnameInputState>(
        builder: (context, state) {
      return TextField(
        keyboardType: TextInputType.name,
        onChanged: (val) {
          final cubitHandle = context.read<SurnameInputCubit>();
          cubitHandle.updateText(val);
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorText: state is SurnameInputError ? state.message : null,
            hintText: 'FamilyName',
            labelText: labelText,
            prefixIcon: const Icon(
              Icons.person,
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(5),
            ))),
      );
    });
  }
}

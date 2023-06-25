import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/name_textfield_cubit/name_input_cubit.dart';

class NameInputField extends StatelessWidget {
  const NameInputField({super.key, this.labelText = 'Name'});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameInputCubit, NameInputState>(
        builder: (context, state) {
      return TextField(
        keyboardType: TextInputType.name,
        onChanged: (val) {
          final cubitHandle = context.read<NameInputCubit>();
          cubitHandle.updateText(val);
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorText: state is NameInputError ? state.message : null,
            hintText: 'Balablue',
            labelText: labelText,
            isDense: true,
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

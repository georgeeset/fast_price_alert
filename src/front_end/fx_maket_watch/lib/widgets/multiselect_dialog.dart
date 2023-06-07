import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/interest_select_cubit/interest_select_cubit.dart';

/// Select multiple items from list ofinterests
///

multiSelect(BuildContext context) {
  final List<String> interests = [
    'Forex',
    'Crypto Currency',
    'Indices',
    'Deriv index',
  ];
  return DialogScreen(interests: interests);
}

class DialogScreen extends StatelessWidget {
  final List<String> interests;

  const DialogScreen({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Interests'),
      content: SizedBox(
        height: 400,
        width: 300,
        child: BlocBuilder<InterestSelectCubit, List<String>>(
          builder: (context, selectedList) {
            return ListView(
              children: interests.map(
                (item) {
                  return CheckboxListTile(
                    onChanged: (isSelected) {
                      if (isSelected == true) {
                        context.read<InterestSelectCubit>().addSelected(item);
                      } else {
                        context
                            .read<InterestSelectCubit>()
                            .removeSelected(item);
                      }
                    },
                    value: selectedList.contains(item),
                    title: Text(item),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Done'),
        ),
      ],
    );
  }
}

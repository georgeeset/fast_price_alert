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

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key, required this.interests});
  final List<String> interests;

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
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
              children: widget.interests.map(
                (item) {
                  return CheckboxListTile(
                    onChanged: (isSelected) {
                      setState(() {
                        if (isSelected == true) {
                          context.read<InterestSelectCubit>().addSelected(item);
                        } else {
                          context
                              .read<InterestSelectCubit>()
                              .removeSelected(item);
                        }
                      });
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
        TextButton(
          onPressed: () {},
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

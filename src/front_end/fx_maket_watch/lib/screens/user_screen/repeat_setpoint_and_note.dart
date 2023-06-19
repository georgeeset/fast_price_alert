import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/edit_alert_bloc/edit_alert_bloc.dart';

class RepeatSetpointAndNote extends StatelessWidget {
  const RepeatSetpointAndNote({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(
        text: context
            .read<EditAlertBloc>()
            .state
            .myAlert
            .repeatSetpoint
            .toString());
    final TextEditingController noteController = TextEditingController(
      text: context.read<EditAlertBloc>().state.myAlert.note,
    );
    return Container(
      width: 600,
      child: BlocBuilder<EditAlertBloc, EditAlertState>(
        builder: (context, state) {
          return Column(children: [
            const Text("Repeat Alert"),
            Card(
              child: Container(
                width: 120,
                child: SizedBox(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    enabled: true,
                    controller: controller,
                    maxLength: 1,
                    onChanged: (val) {
                      context
                          .read<EditAlertBloc>()
                          .add(UpdateRepeatSetpoint(repeatSetpoint: val));
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorText: state.expirationOk ? null : 'max 9',
                      // labelText: ,
                      isDense: true,
                      // isCollapsed: true,
                      prefixIcon: const Icon(
                        Icons.repeat,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: noteController,
                  maxLines: 6,
                  maxLength: 200,
                  onChanged: (val) {
                    context.read<EditAlertBloc>().add(UpdateNote(note: val));
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorText: state.noteError != '' ? state.noteError : null,
                      hintText:
                          'A short note to help remind you what your plan is',
                      labelText: 'NOTE',
                      isDense: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ))),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}

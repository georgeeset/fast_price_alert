import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/edit_alert_bloc/edit_alert_bloc.dart';

class ExpirationSelector extends StatelessWidget {
  const ExpirationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 600,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text("Expiration Date"),
                BlocBuilder<EditAlertBloc, EditAlertState>(
                  builder: (context, state) {
                    final mycontext = context.read<EditAlertBloc>();
                    return OutlinedButton(
                      onPressed: () async {
                        var selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (selectedDate != null) {
                          if (state.expirationOk) {
                            mycontext.add(
                              UpdateExpiration(
                                selectedDate: mycontext
                                    .state.myAlert.expirationInDate!
                                    .copyWith(
                                  day: selectedDate.day,
                                  month: selectedDate.month,
                                  year: selectedDate.year,
                                ),
                              ),
                            );
                          } else {
                            mycontext.add(
                                UpdateExpiration(selectedDate: selectedDate));
                          }
                        }
                      },
                      child: Text(state.myAlert.expirationInDate != null
                          ? "${state.myAlert.expirationInDate?.month.toString()}/${state.myAlert.expirationInDate?.day.toString()}/${state.myAlert.expirationInDate?.year.toString()}"
                          : "MM/dd/YY"),
                    );
                  },
                )
              ],
            ),
            Column(
              children: [
                const Text("Expiration Time"),
                BlocBuilder<EditAlertBloc, EditAlertState>(
                  builder: (context, state) {
                    final mycontext = context.read<EditAlertBloc>();
                    return OutlinedButton(
                      onPressed: () async {
                        var selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (selectedTime != null) {
                          if (state.expirationOk) {
                            mycontext.add(
                              UpdateExpiration(
                                selectedDate:
                                    state.myAlert.expirationInDate!.copyWith(
                                  hour: selectedTime.hour,
                                  minute: selectedTime.minute,
                                ),
                              ),
                            );
                          } else {
                            mycontext.add(
                              UpdateExpiration(
                                selectedDate: DateTime.now().copyWith(
                                  hour: selectedTime.hour,
                                  minute: selectedTime.minute,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        state.myAlert.expirationInDate != null
                            ? "${state.myAlert.expirationInDate!.hour.toString()}:${state.myAlert.expirationInDate!.minute.toString()}"
                            : '${TimeOfDay.now().hour} : ${TimeOfDay.now().minute}',
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

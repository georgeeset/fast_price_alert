import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/constants.dart' as constants;

import '../../blocs/edit_alert_bloc/edit_alert_bloc.dart';
import 'alert_condition.dart';
import 'currency_nd_timeframe.dart';
import '../../services/api_calls.dart';
import 'price_and_alert_medium.dart';

class AlertForm extends StatelessWidget {
  const AlertForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAlertBloc(),
      child: const Column(
        children: [
          CurrencyTimeFrame(),
          AlertCondition(),
          PriceAndMedium(),
          ExpirationSelector(),
        ],
      ),
    );
  }
}

class ExpirationSelector extends StatelessWidget {
  const ExpirationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 600,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
                          mycontext.add(
                              UpdateExpiration(selectedDate: selectedDate));
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
                    return OutlinedButton(
                      onPressed: () async {
                        var selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (selectedTime != null) {
                          print(selectedTime);
                        } else {
                          print("wahala");
                        }
                      },
                      child: const Text("7:45AM"),
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

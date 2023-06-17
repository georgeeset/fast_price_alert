import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/edit_alert_bloc/edit_alert_bloc.dart';
import 'package:fx_maket_watch/constants.dart' as constants;

class AlertCondition extends StatelessWidget {
  const AlertCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 600,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Alarm Condition'),
            ),
            BlocBuilder<EditAlertBloc, EditAlertState>(
              builder: (context, state) {
                return DropdownButton(
                  iconEnabledColor: Colors.purple,
                  // isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  value: state.myAlert.condition == ''
                      ? constants.conditionList[0]
                      : state.myAlert.condition,
                  onChanged: (newValue) {
                    context
                        .read<EditAlertBloc>()
                        .add(UpdateCondition(condition: newValue!));
                  },
                  items: constants.conditionList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

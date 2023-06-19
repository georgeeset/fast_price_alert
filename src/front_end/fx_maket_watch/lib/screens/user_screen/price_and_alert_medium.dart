import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';

import '../../blocs/edit_alert_bloc/edit_alert_bloc.dart';
import '../../services/api_calls.dart';
import 'package:fx_maket_watch/constants.dart' as constants;

class PriceAndMedium extends StatelessWidget {
  const PriceAndMedium({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(
        text: context.read<EditAlertBloc>().state.myAlert.setpoint.toString());
    var authState = context.read<AuthenticationBloc>().state;
    String token = '';
    if (authState is AuthenticatedState) token = authState.apiKey;
    // print(token);

    return Card(
      child: Container(
        width: 600,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.topRight, child: Text('Price')),
                SizedBox(
                  width: 120,
                  child: BlocBuilder<EditAlertBloc, EditAlertState>(
                    builder: (context, state) {
                      return TextField(
                        keyboardType: TextInputType.number,
                        enabled: true,
                        controller: controller,
                        onChanged: (val) {
                          context
                              .read<EditAlertBloc>()
                              .add(UpdateSetpoint(setpoint: val));
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorText: state.setpointOk ? null : 'Number',
                          labelText: '0.2334',
                          isDense: true,
                          // isCollapsed: true,
                          prefixIcon: const Icon(
                            Icons.price_check_sharp,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Alert Method"),
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: getUserAlerMedium(token: token),
                      builder: (context, data) {
                        if (data.hasData) {
                          var draft = data.data!;

                          // print(draft[0]['address']);
                          // for (var i = 0; i < draft.length; i++) {
                          //   var smallList = draft[i]
                          //       .values
                          //       .map((e) => e as List<dynamic>)
                          //       .toList();
                          //   for (var j = 0; j < smallList.length; j++) {
                          //     assetList.addAll(smallList[j]
                          //         .map((e) => e.toString())
                          //         .toList());
                          //   }
                          var mediumList = [
                            constants.alertMediumTitle,
                          ];
                          mediumList.addAll(
                              draft.map((e) => e['alert'].toString()).toList());

                          return BlocBuilder<EditAlertBloc, EditAlertState>(
                            builder: (context, state) {
                              return DropdownButton<String>(
                                iconEnabledColor: Colors.purple,
                                alignment: AlignmentDirectional.center,
                                value: state.myAlert.alertMedium == ''
                                    ? mediumList[0]
                                    : state.myAlert.alertMedium,
                                onChanged: (newValue) {
                                  context.read<EditAlertBloc>().add(
                                      UpdateAlertMedium(
                                          alertMedium: newValue.toString()));
                                },
                                items: mediumList
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          );
                        }
                        if (data.hasError) {
                          return IconButton(
                              onPressed: () {
                                getUserAlerMedium(token: token);
                              },
                              icon: const Icon(Icons.refresh));
                        } else {
                          return const LinearProgressIndicator();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

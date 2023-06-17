import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/services/api_calls.dart';
import 'package:fx_maket_watch/constants.dart' as constants;

import '../../blocs/edit_alert_bloc/edit_alert_bloc.dart';

class CurrencyTimeFrame extends StatelessWidget {
  const CurrencyTimeFrame({super.key});

  get onChanged => null;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 600,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Commodity'),
                ),
                SizedBox(
                  width: 110,
                  height: 35,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: getSupportedAssets(),
                      builder: (context, data) {
                        if (data.hasData) {
                          // print('data received ${data.data}');
                          List<String> assetList = [
                            constants.commodityTitle,
                          ];
                          var draft = data.data!;
                          for (var i = 0; i < draft.length; i++) {
                            var smallList = draft[i]
                                .values
                                .map((e) => e as List<dynamic>)
                                .toList();
                            for (var j = 0; j < smallList.length; j++) {
                              assetList.addAll(smallList[j]
                                  .map((e) => e.toString())
                                  .toList());
                            }
                          }

                          return BlocBuilder<EditAlertBloc, EditAlertState>(
                            builder: (context, state) {
                              return DropdownButton(
                                iconEnabledColor: Colors.purple,
                                alignment: AlignmentDirectional.center,
                                value: state.myAlert.commodity == ''
                                    ? assetList[0]
                                    : state.myAlert.commodity,
                                onChanged: (newValue) {
                                  context.read<EditAlertBloc>().add(
                                      UpdateCommodity(commodity: newValue!));
                                },
                                items: assetList.map<DropdownMenuItem<String>>(
                                    (String value) {
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
                                getSupportedAssets();
                              },
                              icon: const Icon(Icons.refresh));
                        } else {
                          return const LinearProgressIndicator();
                        }
                      }),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.topRight, child: Text('Time Frame')),
                SizedBox(
                  width: 120,
                  height: 30,
                  child: BlocBuilder<EditAlertBloc, EditAlertState>(
                    builder: (context, state) {
                      return DropdownButton(
                        iconEnabledColor: Colors.purple,
                        alignment: AlignmentDirectional.center,
                        value: state.myAlert.timeFrame == ''
                            ? constants.timeFrame[0]
                            : state.myAlert.timeFrame,
                        onChanged: (newValue) {
                          context
                              .read<EditAlertBloc>()
                              .add(UpdateTimeFrame(timeFrame: newValue!));
                        },
                        items: constants.timeFrame
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

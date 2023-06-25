import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/blocs/edit_alert_bloc/edit_alert_bloc.dart';
import 'package:fx_maket_watch/cubits/alert_list_cubit/cubit/alert_list_cubit.dart';
import 'package:fx_maket_watch/cubits/delete_alert_cubit/cubit/delete_alert_cubit.dart';
import 'package:fx_maket_watch/models/alert_model.dart';
import 'package:intl/intl.dart';

import '../../widgets/snackbar_message_widget.dart';

class AlertList extends StatelessWidget {
  const AlertList({super.key, required this.deviceSize});
  final Size deviceSize;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceAlertListCubit, PriceAlertListState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: deviceSize.height * .685,
              child: state is AlertLoaded
                  ? ListView.builder(
                      itemCount: state.alertList.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        return BlocProvider<DeleteAlertCubit>(
                          create: (context) => DeleteAlertCubit(),
                          child: PriceAlertItem(
                            item: state.alertList[index],
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
            SizedBox(
              height: 6.0,
              child: state is AlertLoading
                  ? const LinearProgressIndicator()
                  : Container(),
            ),
          ],
        );
      },
    );

    // return FutureBuilder(
    //   future: getAllAlerts(token: token),
    //   builder: (context, data) {
    //     if (data.hasData) {
    //       // var stringedList = data.data;
    //       // var dynaList = jsonDecode(stringedList!) as List<dynamic>;
    //       // print(dynaList);

    //       Iterable l = json.decode(data.data!);
    //       List<PriceAlert> alerts = List<PriceAlert>.from(
    //         l.map(
    //           (item) => PriceAlert.fromJson(json: item),
    //         ),
    //       );

    //       print(alerts.length);

    //       // var mappedList = dynaList.map(
    //       //   (e) {
    //       //     var mystr = e.toString();
    //       //     return jsonDecode(mystr) as Map<String, dynamic>;
    //       //   },
    //       // );
    //       // print('here you go $mappedList');

    //       return;
    //     }
    //     if (data.hasError) {
    //       return Container(width: 10, height: 10);
    //     }
    //     return const LinearProgressIndicator();
    //   },
    // );
  }
}

class PriceAlertItem extends StatelessWidget {
  const PriceAlertItem({super.key, required this.item});

  final PriceAlert item;

  @override
  Widget build(BuildContext context) {
    final DateTime timeCreated = DateTime.fromMillisecondsSinceEpoch(
        item.timeCreated! * 1000,
        isUtc: false);

    final authState = context.read<AuthenticationBloc>().state;
    String token = authState is AuthenticatedState ? authState.apiKey : '';

    // final DateTime expiry = DateTime.fromMillisecondsSinceEpoch(
    //     item.timeCreated! * 60 * 60 * item.expirationInHrs!.abs() * 1000);

    return Card(
      color: Colors.white54,
      child: InkWell(
        hoverColor: Colors.purple[50],
        splashColor: Colors.purple[100],
        onTap: () {
          context.read<EditAlertBloc>().add(LoadNewAlert(alert: item));
        },
        child: Container(
          height: 135,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10,
                color: Colors.yellow,
              ),
              Container(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3.0),
                        child: Text(
                            '${item.commodity} Crated ${DateFormat.yMMMEd().format(timeCreated)}'),
                      ),
                      Expanded(
                        child: Container(
                          width: 280,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 3.0),
                          child: Text(
                            'Triggered If: ${item.condition} => ${item.setpoint.toString()} on  the ${item.timeFrame} timeframe \n Alert medium => ${item.alertMedium} alert, Expires: in ${item.expirationInHrs}hours',
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                width: 40.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocConsumer<DeleteAlertCubit, DeleteAlertState>(
                      listener: (context, delState) {
                        if (delState is AlertDeleted) {
                          showSnackBar(
                              context: context, message: 'Deleted !!!');
                          context.read<PriceAlertListCubit>().reloadAlert();
                        }
                        if (delState is DeleteFailed) {
                          showSnackBar(
                              context: context,
                              message: 'Delete Failed ! ${delState.message}');
                        }
                      },
                      builder: (context, state) {
                        return state is DeleteLoading
                            ? Container(
                                width: 40,
                                height: 40,
                                child: const CircularProgressIndicator(),
                              )
                            : IconButton(
                                onPressed: () {
                                  context
                                      .read<DeleteAlertCubit>()
                                      .deleteOneAlert(
                                          alertId: item.alertId!,
                                          apiKey: token);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

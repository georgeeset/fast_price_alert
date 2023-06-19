import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/cubits/alert_list_cubit/cubit/alert_list_cubit.dart';
import 'package:fx_maket_watch/models/alert_model.dart';
import 'package:fx_maket_watch/services/api_calls.dart';

class AlertList extends StatelessWidget {
  const AlertList({super.key});

  @override
  Widget build(BuildContext context) {
    var authData = context.read<AuthenticationBloc>().state;
    var token = authData is AuthenticatedState ? authData.apiKey : '';
    // return BlocBuilder<PriceAlertListCubit, PriceAlertListState>(
    //   builder: (context, state) {
    //     return state is AlertLoaded
    //         ? ListView.builder(
    //             itemBuilder: (BuildContext context, int index) {
    //               return Container();
    //             },
    //           )
    //         : const LinearProgressIndicator();
    //   },
    // );

    return FutureBuilder(
      future: getAllAlerts(token: token),
      builder: (context, data) {
        if (data.hasData) {
          // var stringedList = data.data;
          // var dynaList = jsonDecode(stringedList!) as List<dynamic>;
          // print(dynaList);

          Iterable l = json.decode(data.data!);
          List<PriceAlert> alerts = List<PriceAlert>.from(
            l.map(
              (item) => PriceAlert.fromJson(json: item),
            ),
          );

          print(alerts.length);

          // var mappedList = dynaList.map(
          //   (e) {
          //     var mystr = e.toString();
          //     return jsonDecode(mystr) as Map<String, dynamic>;
          //   },
          // );
          // print('here you go $mappedList');

          return Container();
        }
        if (data.hasError) {
          return Container(width: 10, height: 10);
        }
        return const LinearProgressIndicator();
      },
    );
  }
}

class PriceAlertItem extends StatelessWidget {
  const PriceAlertItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          child: Row(
        children: [
          Container(width: 10, height: double.infinity, color: Colors.red)
        ],
      )),
    );
  }
}

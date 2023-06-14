import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/alert_list_cubit/cubit/alert_list_cubit.dart';

class AlertList extends StatelessWidget {
  const AlertList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceAlertListCubit, PriceAlertListState>(
      builder: (context, state) {
        return state is AlertLoaded
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                },
              )
            : const LinearProgressIndicator();
      },
    );
  }
}

class PriceAlertItem extends StatelessWidget {
  const PriceAlertItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(child: Row(children: [Container(width: 10,height: double.infinity,color: Colors.red)],)),
    )
  }
}

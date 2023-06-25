import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/blocs/edit_alert_bloc/edit_alert_bloc.dart';
import 'package:fx_maket_watch/cubits/alert_list_cubit/cubit/alert_list_cubit.dart';
import 'package:fx_maket_watch/screens/user_screen/alert_form.dart';
import 'package:fx_maket_watch/screens/user_screen/menu_widget.dart';
import 'package:fx_maket_watch/screens/user_screen/price_alert_list.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.deviceSize});
  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthenticationBloc>().state;
    final myToken = authState is AuthenticatedState ? authState.apiKey : '';
    return Container(
      height: deviceSize.height * 0.7,
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EditAlertBloc>(create: (context) => EditAlertBloc()),
          BlocProvider(
              create: (context) => PriceAlertListCubit(token: myToken)),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: deviceSize.width * 0.2,
              color: Colors.grey[50],
              child: Menu(),
            ),
            SizedBox(
              width: deviceSize.width * 0.05,
            ),
            Row(
              children: [
                Container(
                  width: deviceSize.width * 0.3,
                  height: double.infinity,
                  color: Colors.white,
                  child: AlertList(deviceSize: deviceSize),
                ),
                SizedBox(
                  width: deviceSize.width * 0.4,
                  // color: Colors.blue,
                  child: const AlertForm(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

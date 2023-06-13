import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/active_menu_cubit/cubit/active_menu_cubit.dart';
import 'package:fx_maket_watch/screens/user_screen/menu_widget.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.deviceSize});
  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSize.height * 0.7,
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: double.infinity,
            width: deviceSize.width * 0.2,
            child: BlocProvider<ActiveMenuCubit>(
              create: (context) => ActiveMenuCubit(),
              child: Menu(),
            ),
          ),
          SizedBox(
            width: deviceSize.width * 0.05,
          ),
          Row(
            children: [
              Container(
                width: deviceSize.width * 0.3,
                height: double.infinity,
                color: Colors.green,
              ),
              Container(
                width: deviceSize.width * 0.4,
                color: Colors.blue,
              )
            ],
          ),
        ],
      ),
    );
  }
}

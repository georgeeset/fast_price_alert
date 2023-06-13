import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/active_menu_cubit/cubit/active_menu_cubit.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final List<String> menuItems = [
    'Price Alerts',
    'News Alerts',
    'Indicators Alert',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveMenuCubit, int>(
      builder: (context, state) {
        return ListView(
          children: menuItems
              .map(
                (item) => MenuItem(
                  isActive: menuItems[state] == item,
                  titleString: item,
                  itemIndex: menuItems.indexOf(item),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.isActive,
      required this.titleString,
      required this.itemIndex});

  final bool isActive;
  final String titleString;
  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: InkWell(
        hoverColor: Colors.purple[100],
        onTap: () {
          if (isActive) return;
          context.read<ActiveMenuCubit>().setActiveMenu(itemIndex);
        },
        child: Container(
          height: 40.0,
          width: double.infinity,
          color: isActive ? Colors.black87 : Colors.white,
          child: Center(
            child: Text(
              titleString,
              style: TextStyle(
                fontSize: 18,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

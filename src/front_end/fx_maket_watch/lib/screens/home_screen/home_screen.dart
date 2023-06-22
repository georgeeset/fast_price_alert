import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/cubits/active_menu_cubit/cubit/active_menu_cubit.dart';
import 'package:fx_maket_watch/cubits/login_signup_cubit/cubit/login_signup_cubit.dart';
import 'package:fx_maket_watch/screens/home_screen/login_signup_widget.dart';
import 'package:fx_maket_watch/screens/home_screen/slide_show_widget.dart';
import 'package:fx_maket_watch/screens/user_screen/user_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "FX Market Watch";
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      //   title: Text(title,
      //       style: const TextStyle(
      //           color: Colors.white, fontWeight: FontWeight.bold)),
      // ),
      body: SizedBox(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: deviceSize.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              height: 60,
              color: Theme.of(context).colorScheme.inverseSurface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return state is AuthenticatedState
                          ? TextButton(
                              onPressed: () {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(LogoutEvent());
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          : const SizedBox();
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceSize.height * 0.1,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, authState) => authState
                            is AuthenticatedState
                        ? BlocProvider<ActiveMenuCubit>(
                            create: (context) => ActiveMenuCubit(),
                            child: UserScreen(deviceSize: deviceSize),
                          )
                        : Container(
                            height: deviceSize.height * 0.7,
                            width: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BlocProvider<LoginSignupCubit>(
                                    create: (context) => LoginSignupCubit(),
                                    child: const LoginSignup(),
                                  ),
                                  const Expanded(child: SlideShow()),
                                ]),
                          ),
                  ),
                ],
              ),
            ),
            Container(
              height: deviceSize.height * .1,
              width: deviceSize.width,
              color: Colors.black87,
              child: const Center(
                child: Text(
                    ' \u00a9 Fx Market Watch 2023. Powered by EsetAutomation.tech',
                    style: TextStyle(color: Colors.white, fontSize: 21)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

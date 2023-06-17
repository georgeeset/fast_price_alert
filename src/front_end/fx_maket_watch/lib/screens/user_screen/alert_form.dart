import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/constants.dart' as constants;

import '../../blocs/edit_alert_bloc/edit_alert_bloc.dart';
import 'alert_condition.dart';
import 'currency_nd_timeframe.dart';
import '../../services/api_calls.dart';
import 'expiration_selector.dart';
import 'price_and_alert_medium.dart';

class AlertForm extends StatelessWidget {
  const AlertForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAlertBloc(),
      child: const Column(
        children: [
          CurrencyTimeFrame(),
          AlertCondition(),
          PriceAndMedium(),
          ExpirationSelector(),
          RepeatSetpointAndNote(),
        ],
      ),
    );
  }
}

class RepeatSetpointAndNote extends StatelessWidget {
  const RepeatSetpointAndNote({super.key});

  @override
  Widget build(BuildContext context) {
    return 
  }
}


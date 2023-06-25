import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/blocs/auth_bloc/authentication_bloc.dart';
import 'package:fx_maket_watch/cubits/alert_list_cubit/cubit/alert_list_cubit.dart';
import 'package:fx_maket_watch/widgets/snackbar_message_widget.dart';

import '../../blocs/edit_alert_bloc/edit_alert_bloc.dart';
import '../../cubits/save_alaert_cubit/save_alert_cubit.dart';
import 'alert_condition.dart';
import 'currency_nd_timeframe.dart';
import 'expiration_selector.dart';
import 'price_and_alert_medium.dart';
import 'repeat_setpoint_and_note.dart';

class AlertForm extends StatelessWidget {
  const AlertForm({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          const CurrencyTimeFrame(),
          const AlertCondition(),
          const PriceAndMedium(),
          const ExpirationSelector(),
          const RepeatSetpointAndNote(),
          const SizedBox(height: 10),
          BlocProvider<SaveAlertCubit>(
            create: (context) => SaveAlertCubit(),
            child: const UploadButton(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    var authState = context.read<AuthenticationBloc>().state;
    return BlocConsumer<SaveAlertCubit, SaveAlertState>(
      listener: (context, saveState) {
        if (saveState is SaveAlertFailed) {
          showSnackBar(
              context: context, message: 'Upload failed! ${saveState.message}');
        } else {
          if (saveState is SaveAlertSuccess) {
            showSnackBar(context: context, message: 'Upload Successful');
            context.read<PriceAlertListCubit>().reloadAlert();
            context.read<EditAlertBloc>().add(ClearForm());
          }
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  var savior = context.read<EditAlertBloc>().state;

                  if (savior.commodityOk &&
                      savior.alertMediumOk &&
                      savior.conditionOk &&
                      savior.expirationOk &&
                      savior.repeatSetpointOk &&
                      savior.setpointOk &&
                      savior.timeframeOk &&
                      savior.noteError == '' &&
                      authState is AuthenticatedState) {
                    context.read<SaveAlertCubit>().saveAlert(
                          savior.myAlert,
                          authState.apiKey,
                        );
                  } else {
                    // print('precheck failed');
                    showSnackBar(
                        context: context, message: 'All Fields are mandatory');
                  }
                },
                child: state is SaveAlertLoading
                    ? const SizedBox(
                        width: 10.0,
                        height: 10.0,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Save')),
            const SizedBox(
              width: 30,
            ),
            OutlinedButton(
              onPressed: () {
                context.read<EditAlertBloc>().add(ClearForm());
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}

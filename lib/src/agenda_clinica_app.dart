import 'package:agenda_clinica/src/core/ui/clinica_theme.dart';
import 'package:agenda_clinica/src/core/ui/widgets/agenda_clinica_loader.dart';
import 'package:agenda_clinica/src/features/auth/login/login_page.dart';
import 'package:agenda_clinica/src/features/splash/splash_page.dart';
import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter/material.dart';

class AgendaClinicaApp extends StatelessWidget {

  const AgendaClinicaApp({ super.key });

   @override
   Widget build(BuildContext context) {
       return AsyncStateBuilder(
        customLoader: const AgendaClinicaLoader(),
        builder: (asyncNavigatorObserver) {
        return MaterialApp(
        title: 'Agenda Clinica',
        theme: ClinicaTheme.themeData,
        navigatorObservers: [asyncNavigatorObserver],
        routes: {
          '/': (_) => const SplashPage(),
          '/auth/login/' : (_) => const LoginPage(),
          '/home/adm/' : (_) => const Text('ADM'),
          '/home/employee/' : (_) => const Text('Employee'),
          },
        );
      },
    );
  }
}
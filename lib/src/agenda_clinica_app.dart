import 'package:agenda_clinica/src/core/ui/clinica_nav_global_key.dart';
import 'package:agenda_clinica/src/core/ui/clinica_theme.dart';
import 'package:agenda_clinica/src/core/ui/widgets/agenda_clinica_loader.dart';
import 'package:agenda_clinica/src/features/auth/login/login_page.dart';
import 'package:agenda_clinica/src/features/auth/register/clinica/clinica_register_page.dart';
import 'package:agenda_clinica/src/features/auth/register/user/user_register_page.dart';
import 'package:agenda_clinica/src/features/employee/register/employee_register_page.dart';
import 'package:agenda_clinica/src/features/employee/schedule/employee_schedule_page.dart';
import 'package:agenda_clinica/src/features/home/adm/home_adm_page.dart';
import 'package:agenda_clinica/src/features/schedule/schedule_page.dart';
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
        navigatorKey: ClinicaNavGlobalKey.instance.navKey,
        routes: {
          '/': (_) => const SplashPage(),
          '/auth/login' : (_) => const LoginPage(),
          '/auth/register/user' : (_) => const UserRegisterPage(),
          '/auth/register/clinica' : (_) => const ClinicaRegisterPage(),
          '/home/adm' : (_) => const HomeAdmPage(),
          '/home/employee' : (_) => const Text('Employee'),
          '/employee/register' : (_) => const EmployeeRegisterPage(),
          '/employee/schedule' : (_) => const EmployeeSchedulePage(),
          '/shedule': (_) => const SchedulePage(),
          },
        );
      },
    );
  }
}
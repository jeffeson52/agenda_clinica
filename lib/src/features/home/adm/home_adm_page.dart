import 'dart:developer';

import 'package:agenda_clinica/src/core/ui/clinica_icons.dart';
import 'package:agenda_clinica/src/core/ui/constants.dart';
import 'package:agenda_clinica/src/core/ui/widgets/agenda_clinica_loader.dart';
import 'package:agenda_clinica/src/features/home/adm/home_adm_state.dart';
import 'package:agenda_clinica/src/features/home/adm/home_adm_vm.dart';
import 'package:agenda_clinica/src/features/home/adm/widgets/home_employee_tile.dart';
import 'package:agenda_clinica/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () async {
          await Navigator.of(context).pushNamed('/employee/register');
          ref.invalidate(homeAdmVmProvider);
        },
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            ClinicaIcons.addEmployee,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: homeState.when(
        data: (HomeAdmState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeEmployeeTile(employee: data.employees[index]),
                  childCount: data.employees.length,
                ),
              )
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar colaboradores',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar página'),
          );
        },
        loading: () {
          return const AgendaClinicaLoader();
        },
      ),
    );
  }
}

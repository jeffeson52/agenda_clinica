import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/providers/application_providers.dart';
import 'package:agenda_clinica/src/features/home/adm/home_adm_state.dart';
import 'package:agenda_clinica/src/model/clinica_model.dart';
import 'package:agenda_clinica/src/model/user_model.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final ClinicaModel(id: clinicaId) =
        await ref.read(getMyClinicaProvider.future);
    final me = await ref.watch(getMeProvider.future);

    final employeesResult = await repository.getEmployees(clinicaId);

    switch (employeesResult) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];

        if (me case UserModelADM(workDays: _?, workHours: _?)) {//!não esta na documentação, estudar sobre aula 4 as 1:45 adiante
          employees.add(me);
        }

        employees.addAll(employeesData);

        return HomeAdmState(
            status: HomeAdmStateStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employees: []);
    }
  }

  Future<void> logout() =>
      ref.read(logoutProvider.future).asyncLoader(); //!cuidado
}

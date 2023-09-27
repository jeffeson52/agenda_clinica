import 'package:agenda_clinica/src/core/exceptions/repository_exception.dart';
import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/fp/nil.dart';
import 'package:agenda_clinica/src/core/providers/application_providers.dart';
import 'package:agenda_clinica/src/features/employee/register/employee_register_state.dart';
import 'package:agenda_clinica/src/model/clinica_model.dart';
import 'package:agenda_clinica/src/repositories/user/user_repository.dart';
import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterADM(bool isRegisterADM) {
    state = state.copyWith(registerADM: isRegisterADM);
  }

  void addOrRemoveWorkdays(String weekDay) {
    final EmployeeRegisterState(:workdays) = state;

    if (workdays.contains(weekDay)) {
      workdays.remove(weekDay);
    } else {
      workdays.add(weekDay);
    }
    state = state.copyWith(workdays: workdays);
  }

  void addOrRemoveWorkhours(int hour) {
    final EmployeeRegisterState(:workhours) = state;

    if (workhours.contains(hour)) {
      workhours.remove(hour);
    } else {
      workhours.add(hour);
    }
    state = state.copyWith(workhours: workhours);
  }

  Future<void> register({String? name, String? email, String? password}) async {
    final EmployeeRegisterState(:registerADM, :workdays, :workhours) = state;
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(:registerAdmAsEmployee, :registerEmployee) = 
    ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> resultRegister;

    if(registerADM){
      final dto = (
        workdays: workdays,
        workhours: workhours
      );

      resultRegister = await registerAdmAsEmployee(dto);
    }else{
      final ClinicaModel(:id) = await ref.watch(getMyClinicaProvider.future);
      final dto = (
        clinicaId: id,
        name: name!,
        email: email!,
        password: password!,
        workdays: workdays,
        workhours: workhours,
      );
      resultRegister = await registerEmployee(dto);
    }
    switch(resultRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }
    asyncLoaderHandler.close();
  }
}

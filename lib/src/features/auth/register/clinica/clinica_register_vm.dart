import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/providers/application_providers.dart';
import 'package:agenda_clinica/src/features/auth/register/clinica/clinica_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'clinica_register_vm.g.dart';

@riverpod
class ClinicaRegisterVm extends _$ClinicaRegisterVm {
  @override
  ClinicaRegisterState build() => ClinicaRegisterState.initial();

  void addOrRemoveOpenDay(String weekDay) {
    final openingDays = state.openingDays;

    if (openingDays.contains(weekDay)) {
      openingDays.remove(weekDay);
    } else {
      openingDays.add(weekDay);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHour(int hour) {
    final openingHours = state.openingHours;

    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  Future<void> register(String name, String email) async {
    final repository = ref.watch(clinicaRepositoryProvider);
    final ClinicaRegisterState(:openingDays, :openingHours) = state;

    final dto = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours,
    );
    final registerResult = await repository.save(dto);

    switch(registerResult) {
      case Success():
      ref.invalidate(getMyClinicaProvider);
      state = state.copyWith(status: ClinicaRegisterStateStatus.success);
      case Failure():
      state = state.copyWith(status: ClinicaRegisterStateStatus.error);

    }
  }
}

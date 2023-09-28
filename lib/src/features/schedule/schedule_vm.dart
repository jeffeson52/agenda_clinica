import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/providers/application_providers.dart';
import 'package:agenda_clinica/src/features/schedule/schedule_state.dart';
import 'package:agenda_clinica/src/model/clinica_model.dart';
import 'package:agenda_clinica/src/model/user_model.dart';
import 'package:agenda_clinica/src/repositories/schedule/schedule_repository.dart';
import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm{
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelect(int hour){
    if(hour == state.scheduleHour){
      state = state.copyWith(scheduleHour: () => null,);
    }else{
      state = state.copyWith(scheduleHour: () => hour,);
    }
  }

  void dateSelect(DateTime date){
    state = state.copyWith(scheduleDate: () => date,);
  }

  Future<void> register({required UserModel userModel, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();
    final ScheduleState(:scheduleDate, :scheduleHour) = state;
    final scheduleRepository = ref.read(scheduleRepositoryProvider);
    final ClinicaModel(id:clinicaId) = await ref.watch(getMyClinicaProvider.future);

    final dto = (
      clinicaId: clinicaId,
      userId: userModel.id,
      clientName: clientName,
      date: scheduleDate!,
      time: scheduleHour!, 
    );

    final scheduleResult = await scheduleRepository.scheduleClient(dto);

    switch(scheduleResult) {
      case Success():
        state = state.copyWith(status: ScheduleStateStatus.succcess);
      case Failure():
      state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
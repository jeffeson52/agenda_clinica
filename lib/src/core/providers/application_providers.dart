import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/restClient/rest_client.dart';
import 'package:agenda_clinica/src/model/clinica_model.dart';
import 'package:agenda_clinica/src/model/user_model.dart';
import 'package:agenda_clinica/src/repositories/clinica/clinica_repository.dart';
import 'package:agenda_clinica/src/repositories/clinica/clinica_repository_impl.dart';
import 'package:agenda_clinica/src/repositories/user/user_repository.dart';
import 'package:agenda_clinica/src/repositories/user/user_repository_impl.dart';
import 'package:agenda_clinica/src/services/user_login/user_login_service.dart';
import 'package:agenda_clinica/src/services/user_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)

RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => 
  UserRepositoryImpl(restClient: ref.read(restClientProvider));

  @Riverpod(keepAlive: true)
  UserLoginService userLoginService(UserLoginServiceRef ref) => 
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

  @Riverpod(keepAlive: true)
  Future<UserModel> getMe(GetMeRef ref) async {
    final result = await ref.watch(userRepositoryProvider).me();

    return switch (result) {
      Success(value: final userModel) => userModel,
      Failure(:final exception) => throw exception,
    };
  }
@Riverpod(keepAlive: true)
ClinicaRepository clinicaRepository(ClinicaRepositoryRef ref) => 
  ClinicaRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
  Future<ClinicaModel> getMyClinica(GetMyClinicaRef ref) async {
    final userModel = await ref.watch(getMeProvider.future);
    final clinicaRepository = ref.watch(clinicaRepositoryProvider);
    final result = await clinicaRepository.getMyClinica(userModel);

    return switch (result) {
      Success(value: final clinica) => clinica,
      Failure(:final exception) => throw exception
    };

  }
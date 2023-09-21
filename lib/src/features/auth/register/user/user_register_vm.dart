import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/providers/application_providers.dart';
import 'package:agenda_clinica/src/features/auth/register/user/user_register_providers.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';


enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm{
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register({
    required String name, 
    required String email, 
    required String password,
  }) async {
    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);
    final userDTO = (
      name: name,
      email: email,
      password: password,
    );
    
    final registerResult = await userRegisterAdmService.execute(userDTO);
    switch(registerResult){
      case Success():
      ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}
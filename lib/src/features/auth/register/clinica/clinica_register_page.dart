import 'package:agenda_clinica/src/core/ui/helpers/form_helper.dart';
import 'package:agenda_clinica/src/core/ui/helpers/messages.dart';
import 'package:agenda_clinica/src/core/ui/widgets/hours_panel.dart';
import 'package:agenda_clinica/src/core/ui/widgets/weekdays_panel.dart';
import 'package:agenda_clinica/src/features/auth/register/clinica/clinica_register_state.dart';
import 'package:agenda_clinica/src/features/auth/register/clinica/clinica_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class ClinicaRegisterPage extends ConsumerStatefulWidget {
  const ClinicaRegisterPage({super.key});

  @override
  ConsumerState<ClinicaRegisterPage> createState() =>
      _ClinicaRegisterPageState();
}

class _ClinicaRegisterPageState extends ConsumerState<ClinicaRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clinicaRegisterVM = ref.watch(clinicaRegisterVmProvider.notifier);

  ref.listen(clinicaRegisterVmProvider, (_, state) {
    switch(state.status) {
      case ClinicaRegisterStateStatus.initial:
      break;
      case ClinicaRegisterStateStatus.error:
      Messages.showError('Desculpe ocorreu um erro ao registrar clinica', context);
      case ClinicaRegisterStateStatus.success:
      Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
    }
  });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatorio'),
                  onTapOutside: (_) => context.unfocus(),
                  decoration: const InputDecoration(label: Text('Nome')),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  onTapOutside: (_) => context.unfocus(),
                  decoration: const InputDecoration(label: Text('Email')),
                ),
                const SizedBox(
                  height: 24,
                ),
                WeekdaysPanel(onDayPressed: (value) {
                  clinicaRegisterVM.addOrRemoveOpenDay(value);
                }),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (int value) {
                    clinicaRegisterVM.addOrRemoveOpenHour(value);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        clinicaRegisterVM.register(nameEC.text, emailEC.text);
                    }
                  },
                  child: const Text('CADASTRAR ESTABELECIMENTO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

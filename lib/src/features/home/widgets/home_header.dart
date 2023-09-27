import 'package:agenda_clinica/src/core/providers/application_providers.dart';
import 'package:agenda_clinica/src/core/ui/clinica_icons.dart';
import 'package:agenda_clinica/src/core/ui/constants.dart';
import 'package:agenda_clinica/src/core/ui/helpers/form_helper.dart';
import 'package:agenda_clinica/src/core/ui/widgets/agenda_clinica_loader.dart';
import 'package:agenda_clinica/src/features/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool hideFilter;

  const HomeHeader({super.key, this.hideFilter = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clinica = ref.watch(getMyClinicaProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(
            ImageConstants.backgroundChair,
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          clinica.maybeWhen(
            data: (clinicaData) {
              return
              Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xffbdbdbd),
                child: SizedBox.shrink(),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                child: Text(
                  clinicaData.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(
                child: Text(
                  'editar',
                  style: TextStyle(
                    color: ColorsConstants.brow,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ref.read(homeAdmVmProvider.notifier).logout();
                },
                icon: const Icon(
                  ClinicaIcons.exit,
                  color: ColorsConstants.brow,
                ),
              )
            ],
          );
            },
            orElse: () {
              return const Center(
                child: AgendaClinicaLoader(),
              );
            },
          ),
          
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Bem Vindo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Agende um Cliente',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: TextFormField(
              onTapOutside: (_) => context.unfocus(),
              decoration: const InputDecoration(
                label: Text('Buscar Colaborador'),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: Icon(
                    ClinicaIcons.search,
                    color: ColorsConstants.brow,
                    size: 26,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

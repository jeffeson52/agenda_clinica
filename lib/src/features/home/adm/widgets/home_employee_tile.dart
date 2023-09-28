import 'package:agenda_clinica/src/core/ui/clinica_icons.dart';
import 'package:agenda_clinica/src/core/ui/constants.dart';
import 'package:agenda_clinica/src/model/user_model.dart';
import 'package:flutter/material.dart';

class HomeEmployeeTile extends StatelessWidget {
  final UserModel employee;
  const HomeEmployeeTile({super.key, required this.employee});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsConstants.grey),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(ImageConstants.avatar)
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 5)
                      ),
                      onPressed: () {
                      Navigator.of(context).pushNamed('/shedule', arguments: employee);
                      }, 
                      child: const Text('AGENDAR')),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 5)
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/employee/schedule', arguments: employee);
                        
                      }, 
                      child: const Text('VER AGENDA'),
                      ),
                      const Icon(ClinicaIcons.penEdit, size: 14,
                      color: ColorsConstants.brow,),
                      const Icon(ClinicaIcons.trash, size: 14,
                      color: ColorsConstants.red,)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

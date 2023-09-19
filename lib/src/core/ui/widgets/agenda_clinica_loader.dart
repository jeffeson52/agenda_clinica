import 'package:agenda_clinica/src/core/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AgendaClinicaLoader extends StatelessWidget {

  const AgendaClinicaLoader({ super.key });

   @override
   Widget build(BuildContext context) {
       return Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: ColorsConstants.brow,  
          size: 60),
       );
  }
}
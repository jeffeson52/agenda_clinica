import 'dart:async';
import 'dart:developer';

import 'package:agenda_clinica/src/core/ui/constants.dart';
import 'package:agenda_clinica/src/core/ui/helpers/messages.dart';
import 'package:agenda_clinica/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  var endAnimation = false;
  Timer? redirectTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
    super.initState();
  }

  void _redirect(String routeName) {
    
    if(!endAnimation){
      redirectTimer?.cancel();
      redirectTimer = Timer(const Duration(milliseconds: 300), () {
        _redirect(routeName);
       });
    }else{
      redirectTimer?.cancel();
      Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar o login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar o login', context);
          _redirect('/auth/login');
//          Navigator.of(context)
//              .pushNamedAndRemoveUntil('/auth/login', (route) => false);
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedADM:
            _redirect('/home/adm');
//              Navigator.of(context)
//                  .pushNamedAndRemoveUntil('/home/adm', (route) => false);
            case SplashState.loggedEmployee:
            _redirect('/home/employee');
//              Navigator.of(context)
//                  .pushNamedAndRemoveUntil('/home/employee', (route) => false);
            case _:
            _redirect('/auth/login');
//              Navigator.of(context)
//                  .pushNamedAndRemoveUntil('/home/login', (route) => false);
          }
        },
      );
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ImageConstants.backgroundChair,
              ),
              opacity: 0.2,
              fit: BoxFit.cover),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            onEnd: () {
              setState(() {
                endAnimation = true;
              });
//              Navigator.of(context).pushAndRemoveUntil(
//                PageRouteBuilder(
//                  settings: const RouteSettings(name: '/auth/login'),
//                  pageBuilder: (
//                    context,
//                    animation,
//                    secondaryAnimation,
//                  ) {
//                    return const LoginPage();
//                  },
//                  transitionsBuilder: (_, animation, __, child) {
//                    return FadeTransition(
//                      opacity: animation,
//                      child: child,
//                    );
//                  },
//                ),
//                (route) => false,
//              );
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _logoAnimationWidth,
              height: _logoAnimationHeight,
              curve: Curves.linearToEaseOut,
              child: Image.asset(
                ImageConstants.imageLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

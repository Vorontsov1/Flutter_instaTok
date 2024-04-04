import 'package:flutter/material.dart';
import 'src/components/persistent_nav.dart';
import 'src/modules/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'src/modules/auth/views/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/modules/splash/splash_screen.dart';
import 'src/res/colors.dart';
import 'src/res/styles.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Extension',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: textTheme
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return PersistentTabScreen();
          } else if(state.status == AuthenticationStatus.unknown) {
            return SplashScreen();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
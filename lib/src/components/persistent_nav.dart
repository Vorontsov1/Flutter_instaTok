import '../extensions/context_extension.dart';
import '../modules/auth/blocs/authentication_bloc/authentication_bloc.dart';
import '../modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../modules/create/views/create_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/profile/views/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PersistentTabScreen extends StatefulWidget {
  const PersistentTabScreen({super.key});

  @override
  State<PersistentTabScreen> createState() => _PersistentTabScreenState();
}

class _PersistentTabScreenState extends State<PersistentTabScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      backgroundColor: context.primary,
      tabs: [
        PersistentTabConfig(
          screen: HomeScreen(),
          item: ItemConfig(
            icon: Icon(CupertinoIcons.house_fill),
            title: "Home",
            activeForegroundColor: context.secondary,
            inactiveForegroundColor: context.outline,
          ),
        ),
        PersistentTabConfig.noScreen(
          item: ItemConfig(
            icon: Icon(
              Icons.add_circle_outline,
            ),
            title: "Create",
            activeForegroundColor: context.secondary,
            inactiveForegroundColor: context.outline,
          ),
          onPressed: (context) async {
            await pushScreen(
              context,
              screen: CreateScreen(),
            );
          },
        ),
        PersistentTabConfig(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
              ),
            ],
            child: const ProfileScreen(),
          ),
          item: ItemConfig(
            icon: Icon(CupertinoIcons.person_fill),
            title: "Profile",
            activeForegroundColor: context.secondary,
            inactiveForegroundColor: context.outline,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
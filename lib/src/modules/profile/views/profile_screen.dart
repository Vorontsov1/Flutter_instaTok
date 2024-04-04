import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
        title: Text(
          'Profile'
        ),
				actions: [
					IconButton(
						onPressed: () {
							context.read<SignInBloc>().add(const SignOutRequired());
						}, 
						icon: const Icon(
							Icons.logout
						)
					)
				],
			),
			body: Container(),
		);
  }
}
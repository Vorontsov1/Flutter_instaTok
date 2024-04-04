import '../../../extensions/context_extension.dart';
import '../blocs/authentication_bloc/authentication_bloc.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
			onTap: () => FocusScope.of(context).unfocus(),
			child: Scaffold(
				backgroundColor: context.background,
				body: SingleChildScrollView(
					child: Container(
            color: Colors.black,
						height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: context.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, kToolbarHeight),
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: context.headlineMedium
                        ),
                        SizedBox(height: 30,),
                        Expanded(
                          child: BlocProvider<SignInBloc>(
                            create: (context) => SignInBloc(
                              userRepository: context.read<AuthenticationBloc>().userRepository
                            ),
                            child: const SignInScreen(),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => BlocProvider<SignUpBloc>(
                                    create: (context) => SignUpBloc(
                                      userRepository: context.read<AuthenticationBloc>().userRepository
                                    ),
                                    child: const SignUpScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: kToolbarHeight,
                              child: Center(
                                child: Text(
                                  "Don't have any account? Sign Up",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'F',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'K',
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        )
                      )
                    ),
                  ),
                )
              ],
            ),
					),
				),
			),
		);
  }
}
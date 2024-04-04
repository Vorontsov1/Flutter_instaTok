import '../../../extensions/string_extension.dart';
import '../../../extensions/context_extension.dart';
import '../../../res/strings.dart';
import '../blocs/authentication_bloc/authentication_bloc.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../components/textfield.dart';
import 'reset_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	String? _errorMsgEmail;
  String? _errorMsgPassword;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
				if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsgEmail = state.emailMessage;
            _errorMsgPassword = state.passwordMessage;
					});
				}
      },
      child: Form(
				key: _formKey,
				child: Column(
					children: [
						MyTextField(
							controller: emailController,
							hintText: 'Email',
							obscureText: false,
							keyboardType: TextInputType.emailAddress,
							prefixIcon: const Icon(CupertinoIcons.mail_solid),
							errorMsg: _errorMsgEmail,
							validator: (val) {
								if (val!.isEmpty) {
									return 'Please fill in this field';
								} else if (!val.isValidEmail) {
									return 'Please enter a valid email';
								}
								return null;
							}
						),
						const SizedBox(height: 20),
						MyTextField(
							controller: passwordController,
							hintText: 'Password',
							obscureText: obscurePassword,
							keyboardType: TextInputType.visiblePassword,
							prefixIcon: const Icon(CupertinoIcons.lock_fill),
							errorMsg: _errorMsgPassword,
							validator: (val) {
								if (val!.isEmpty) {
									return 'Please fill in this field';
								} else if (!passwordRexExp.hasMatch(val)) {
									return 'Please enter a valid password';
								}
								return null;
							},
							suffixIcon: IconButton(
								onPressed: () {
									setState(() {
										obscurePassword = !obscurePassword;
										if(obscurePassword) {
											iconPassword = CupertinoIcons.eye_fill;
										} else {
											iconPassword = CupertinoIcons.eye_slash_fill;
										}
									});
								},
								icon: Icon(iconPassword),
							),
						),
						const SizedBox(height: 10),
						Align(
							alignment: Alignment.centerRight,
								child: GestureDetector(
									onTap: () => Navigator.push(
										context, MaterialPageRoute(
											builder: (context) => BlocProvider(
												create: (context) => SignInBloc(
													userRepository: context.read<AuthenticationBloc>().userRepository
												),
												child: const ResetPasswordScreen(),
											)
										),
									),
									child: Text(
                    'Forgot Password ?',
                    style: context.bodySmall.copyWith(
                        color: context.outline
                      ),
									),
								),
							),
						const SizedBox(height: 30),
						!signInRequired
							? SizedBox(
									width: MediaQuery.of(context).size.width,
                  height: kToolbarHeight,
									child: TextButton(
										onPressed: () {
											if (_formKey.currentState!.validate()) {
												context.read<SignInBloc>().add(SignInRequired(
													emailController.text,
													passwordController.text)
												);
											}
										},
										style: TextButton.styleFrom(
											elevation: 3.0,
											backgroundColor: context.primary,
											foregroundColor: Colors.white,
											shape: RoundedRectangleBorder(
												borderRadius: BorderRadius.circular(12)
											)
										),
										child: const Padding(
											padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
											child: Text(
												'Login',
												textAlign: TextAlign.center,
												style: TextStyle(
													color: Colors.white,
													fontSize: 16,
												),
											),
										)
									),
								)
						: const CircularProgressIndicator(),
					],
				),
			),
    );
  }
}
import '../../../extensions/context_extension.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../components/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/src/res/strings.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
	final _formKey = GlobalKey<FormState>();
	final emailController = TextEditingController();
	
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if(state is ResetPasswordSuccess) {
					Navigator.pop(context);
				}
			},
			child: GestureDetector(
				onTap: () => FocusScope.of(context).unfocus(),
				child: Scaffold(
					backgroundColor: context.background,
          appBar: AppBar(
            backgroundColor: context.background,
            title: Text(
              'Forgot Password',
            ),
          ),
					body: SingleChildScrollView(
						child: SizedBox(
							height: MediaQuery.of(context).size.height,
							child: Stack(
								children: [
									Padding(
										 padding: const EdgeInsets.fromLTRB(30, 30, 30, kToolbarHeight),
										child: Form(
											key: _formKey,
											child: Column(
												children: [
													Text(
														"We will send you an email with a link to reset your password. Please enter the email associated with your account below.",
														textAlign: TextAlign.left,
														style: context.bodyMedium
													),
													const SizedBox(height: 20),
													MyTextField(
														controller: emailController,
														hintText: 'Email',
														obscureText: false,
														keyboardType: TextInputType.emailAddress,
														prefixIcon: const Icon(CupertinoIcons.mail_solid),
														validator: (val) {
															if (val!.isEmpty) {
																return 'Please fill in this field';
															} else if (!emailRexExp.hasMatch(val)) {
																return 'Please enter a valid email';
															} else {
																return null;
															}
														}
													),
													const SizedBox(height: 20),
													SizedBox(
														width: MediaQuery.of(context).size.width,
                            height: kToolbarHeight,
														child: TextButton(
															onPressed: () {
																if (_formKey.currentState!.validate()) {
																	context.read<SignInBloc>().add(ResetPassword(emailController.text));
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
																	'Send Reset Link',
																	textAlign: TextAlign.center,
																),
															)
														),
													)
												],
											),
										),
									),
								],
							),
						),
					),
				),
			),
		);
  }
}
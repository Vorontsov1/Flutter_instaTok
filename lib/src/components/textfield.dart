import '../extensions/context_extension.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
	final TextInputType keyboardType;
	final Widget? suffixIcon;
	final VoidCallback? onTap;
	final Widget? prefixIcon;
	final String? Function(String?)? validator;
	final FocusNode? focusNode;
	final String? errorMsg;
	final String? Function(String?)? onChanged;
  final int? maxLines;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
		required this.keyboardType,
		this.suffixIcon,
		this.onTap,
		this.prefixIcon,
		this.validator,
		this.focusNode,
		this.errorMsg,
		this.onChanged,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
			keyboardType: keyboardType,
			focusNode: focusNode,
			onTap: onTap,
			textInputAction: TextInputAction.next,
			onChanged: onChanged,
      maxLines : maxLines ?? 1,
      style: context.bodyMedium,
      decoration: InputDecoration(
				suffixIcon: suffixIcon,
				prefixIcon: prefixIcon,
				enabledBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(10),
					borderSide: const BorderSide(color: Colors.transparent),
				),
				focusedBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(20),
					borderSide: BorderSide(color: context.secondary),
				),
        errorBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(10),
					borderSide: BorderSide(color: context.error),
				),
        focusedErrorBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(20),
					borderSide: BorderSide(color: context.error),
				),
				fillColor: Colors.white,
				filled: true,
				hintText: hintText,
				hintStyle: context.bodySmall.copyWith(
          color: context.outline
        ),
				errorText: errorMsg,
			),
    );
  }
}
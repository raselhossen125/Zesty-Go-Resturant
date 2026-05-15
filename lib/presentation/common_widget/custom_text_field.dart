import 'package:flutter/material.dart';
import '../const/app_const_dimensions.dart';
import '../const/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? header;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isRequired;
  final Color? headerColor;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isEnabled;
  final int? maxLines;
  final Color? textColor;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.header,
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.isRequired = true,
    this.headerColor,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.textColor,
    this.isPassword = false,
    this.validator,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header != null) ...[
          RichText(
            text: TextSpan(
              text: widget.header,
              style: bodyMedium(context)!.copyWith(
                color: widget.headerColor ?? const Color(0xFF1F2C52),
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
              ),
              children: [
                if (widget.isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_SMALL),
        ],

        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          obscureText: widget.isPassword ? _obscureText : false,
          style: bodyMedium(
            context,
          )!.copyWith(color: widget.textColor ?? Colors.black87),
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          enabled: widget.isEnabled,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: caption(
              context,
            )?.copyWith(color: Colors.grey.withOpacity(0.6)),
            filled: true,
            fillColor: Colors.white,
             contentPadding: const EdgeInsets.symmetric(
               horizontal: Dimensions.PADDING_SIZE_DEFAULT,
               vertical: 14,
             ),

             border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              borderSide: const BorderSide(
                color: Color(0xFFFBB03B),
                width: 1.2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),

            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

typedef OnValidator = String? Function(String?)?;
typedef OnChanged = void Function(String)?;

class TextFieldWidget extends StatefulWidget {
  String hintText;
  int? maxLines;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool isPasswordField;
  TextInputType textInputType;
  TextEditingController? controller;
  OnValidator? validator;
  OnChanged? onChanged;
  TextFieldWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.isPasswordField = false,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.isPasswordField ? obscure : false,
      keyboardType: widget.textInputType,
      maxLines: widget.maxLines,
      style: Theme.of(context).textTheme.headlineMedium,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: AppColors.redColor, fontSize: 13),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: widget.hintText.tr(),
        hintStyle: Theme.of(context).textTheme.labelMedium,
        enabledBorder: buildOutlineInputBorder(
          color: Theme.of(context).dividerColor,
        ),
        focusedBorder: buildOutlineInputBorder(
          color: Theme.of(context).primaryColor,
        ),
        errorBorder: buildOutlineInputBorder(color: AppColors.redColor),
        focusedErrorBorder: buildOutlineInputBorder(color: AppColors.redColor),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPasswordField == true
            ? IconButton(
                onPressed: () {
                  obscure = !obscure;
                  setState(() {});
                },
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.disableColor,
                ),
              )
            : widget.suffixIcon,
      ),
      validator: widget.validator,
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}

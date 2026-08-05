import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  String hintText;
  String prefixIcon;
  bool isPasswordField;
  TextInputType textInputType;

  TextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.isPasswordField = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPasswordField ? obscure : false,
      keyboardType: widget.textInputType,
      style: Theme.of(context).textTheme.headlineMedium,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: widget.hintText.tr(),
        hintStyle: Theme.of(context).textTheme.labelMedium,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        prefixIcon: Image.asset(widget.prefixIcon),
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
            : SizedBox(),
      ),
    );
  }
}

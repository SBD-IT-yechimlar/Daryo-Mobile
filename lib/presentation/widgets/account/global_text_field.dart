import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalTextField extends StatefulWidget {
  const GlobalTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    required this.textInputType,
    required this.textInputAction,
    this.controller,
    this.onChanged,
    this.labelText,
    this.maxLine,
    this.formatter,
    this.textAlign,
    this.enabled = true,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
    this.onTap,
    this.borderColor,
    this.title,
    this.backgroundColor,
    this.fillColor, this.hintTextColor, this.fontSize, this.fontWeight, this.maxLength, this.contentPadding,
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final String? title;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int? maxLine;
  final List<TextInputFormatter>? formatter;
  final TextAlign? textAlign;
  final bool? enabled;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? fillColor;
  final Color? hintTextColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLength;
  final Color? backgroundColor; // 🆕 yangi field
  final EdgeInsets? contentPadding;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.backgroundColor ?? Colors.transparent,borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        onTap: widget.onTap,
        focusNode: widget.focusNode,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'error_empty_field'.tr();
          }
          return null;
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        maxLength: widget.maxLength,
        onEditingComplete: widget.onEditingComplete,
        enabled: widget.enabled,
        textAlign: widget.textAlign ?? TextAlign.start,
        inputFormatters: widget.formatter,
        maxLines: widget.maxLine ?? 1,
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        cursorColor: Color(0xFF1A1C1E),
        obscureText: widget.textInputType == TextInputType.visiblePassword &&
            !_isPasswordVisible,
        style: TextStyle(
          color: Color(0xFF1A1C1E),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white.withOpacity(0.15),
          suffixIcon: widget.textInputType == TextInputType.visiblePassword
              ? IconButton(
                  splashRadius: 1,
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: CupertinoColors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : widget.suffixIcon,
          alignLabelWithHint: true,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText?.tr(),
          hintStyle: TextStyle(
            color: widget.hintTextColor ?? CupertinoColors.white,
            fontSize: widget.fontSize ?? 14,
            fontWeight: widget.fontWeight ?? FontWeight.w400,
          ),
          labelText: widget.labelText?.tr(),
          labelStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: widget.fontSize ?? 14,
            fontWeight: widget.fontWeight ?? FontWeight.w400,
          ),
          contentPadding: widget.contentPadding ??
              EdgeInsets.only(left: 10, right: 6, top: 10, bottom: 10),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(color: Colors.white),
          errorBorder: _buildBorder(color: Colors.red),
          focusedErrorBorder: _buildBorder(color: Colors.red),
        ),
      ),
    );
  }
  OutlineInputBorder _buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1,
        color: color ?? widget.borderColor ?? CupertinoColors.transparent,
      ),
    );
  }
}

import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

import 'custom_form_field.dart';

typedef Validator = String? Function(String?)?;
typedef OnChanged = void Function(String)?;

class FormFieldWithHeader extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final OnChanged onChanged;
  final Validator validator;
  final String headerText;
  final String hintText;
  final Widget? trailing;
  final Widget? suffixIcon;
  final String? errorText;
  final int? maxLength;
  final int? maxLines;
  final bool enabled;
  final bool obscure;
  final bool autoValidate;

  const FormFieldWithHeader({
    Key? key,
    required this.controller,
    required this.textInputType,
    required this.headerText,
    required this.hintText,
    this.autoValidate = false,
    this.obscure = false,
    this.enabled = true,
    this.suffixIcon,
    this.errorText,
    this.trailing,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.maxLines,
  }) : super(key: key);

  @override
  State<FormFieldWithHeader> createState() => _FormFieldWithHeaderState();
}

class _FormFieldWithHeaderState extends State<FormFieldWithHeader> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: Styles.formFieldMargin,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.headerText,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.trailing != null)
                  widget.trailing!
              ],
            ),
          ),
          CustomFormField(
            hintText: widget.hintText,
            enabled: widget.enabled,
            obscureText: widget.obscure,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            textEditingController: widget.controller,
            textInputType: widget.textInputType,
            suffixIcon: widget.suffixIcon,
            onChanged: widget.onChanged ?? (_) => setState(() {}),
            autoValidate: widget.autoValidate,
            validator: widget.validator,
            errorText: widget.errorText,
          ),
        ],
      ),
    );
  }
}

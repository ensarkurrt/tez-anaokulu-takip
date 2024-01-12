import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';
import 'package:provider/provider.dart';

class InputField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String? prefixIcon;
  final String? informationText;
  final String? prefixText;

  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;

  final bool animationActive;
  final bool enabled;
  final bool? lastInput;
  final bool? autoValidate;
  final bool obsecureText;
  final bool? required;
  final bool readOnlyWhenStateBusy;

  final double animationDuration;
  final double? minHeigth;
  final int? minLength;
  final int? maxLength;

  final Color? textColor;
  final Color? prefixDeactiveColor;

  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(bool)? onValidate;
  final void Function(String)? onFieldSubmitted;
  final Function? onClear;
  final void Function(String)? onUnFocus;
  final Function(Function)? clearField;

  const InputField({
    Key? key,
    required this.label,
    this.initialValue,
    this.obsecureText = false,
    this.onChanged,
    this.textColor = Colors.white,
    this.animationActive = true,
    this.animationDuration = 1.5,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.inputFormatters,
    this.informationText,
    this.validator,
    this.prefixIcon,
    this.lastInput = false,
    this.minLength,
    this.maxLength,
    this.required = true,
    this.textCapitalization = TextCapitalization.none,
    this.onValidate,
    this.autoValidate = true,
    this.prefixDeactiveColor,
    this.prefixText,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onClear,
    this.clearField,
    this.onUnFocus,
    this.minHeigth,
    this.readOnlyWhenStateBusy = true,
  }) : super(key: key);
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _infoShown = false;

  bool _isOpened = false;
  bool get _isPrimaryFocus => _focusNode.hasPrimaryFocus;

  String? errorText;

  bool isError = false;
  /* String? value; */

  @override
  void initState() {
    _controller.text = widget.initialValue ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Logger.instance.log("InputField initState widget.initialValue: ${widget.initialValue}");
      widget.clearField?.call(_clear);
      _focusNode.addListener(() {
        /* setState(() => _isPrimaryFocus = _focusNode.hasPrimaryFocus); */

        if (_isPrimaryFocus && errorText != null) {
          setState(() => errorText = null);
        }

        if (widget.keyboardType == TextInputType.datetime && _isPrimaryFocus) {
          _focusNode.unfocus();

          DateFormat inputFormat = DateFormat('dd.MM.yyyy HH:mm');
          DateFormat ouputFormat = DateFormat('yyyy-MM-dd HH:mm');

          int? initVal = widget.initialValue != null ? inputFormat.parse(widget.initialValue!).millisecondsSinceEpoch : null;

          context
              .showDateTimePicker(
                  initialDate: initVal != null ? DateTime.fromMillisecondsSinceEpoch(initVal) : DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 16))
              .then((value) {
            if (value != null) {
              String date = inputFormat.format(ouputFormat.parse(value.toString()));
              setState(() => _controller.text = date);
              widget.onChanged?.call(date);
            }
          });
        }

        if (!_isPrimaryFocus && widget.autoValidate == true) {
          setState(() => errorText = validator(_controller.text));
        }

        if (!_isPrimaryFocus && widget.onUnFocus != null) {
          widget.onUnFocus?.call(_controller.value.text);
        }
      });
    });
    super.initState();
  }

  void infoMessage() {
    if (widget.informationText == null || _infoShown == true) return;
    setState(() => _infoShown = true);
    context.hideKeyboard();

    context.dialog(
      context,
      title: widget.label,
      content: widget.informationText!,
      actions: <Widget>[
        TextButton(
          child: const Text("Tamam"),
          onPressed: () {
            Navigator.pop(context);
            _focusNode.requestFocus();
          },
        )
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, strokeAlign: BorderSide.strokeAlignCenter),
      borderRadius: BorderRadius.circular(8),
    );
  }

  Color get _labelColor {
    if (isError) return context.textColors.error;
    if (_isPrimaryFocus) return context.themeColors.accent;
    if (!widget.enabled) return context.themeColors.deactive;
    return context.textColors.title;
  }

  Color get _prefixColor {
    if (isError) return context.textColors.error;
    if (_isPrimaryFocus) return context.themeColors.main;
    if (!widget.enabled) return context.themeColors.deactive;
    return widget.prefixDeactiveColor ?? context.textColors.title;
  }

  Widget? _suffixIcon() {
    if (widget.obsecureText) {
      return IconButton(
        splashColor: Colors.transparent,
        onPressed: () => setState(() => _isOpened = !_isOpened),
        icon:
            _isOpened ? IconPathEnums.eyeOpen.widget(color: context.textColors.title) : IconPathEnums.eye.widget(color: context.themeColors.deactive),
      );
    } else {
      if ((_isPrimaryFocus || (_controller.text.isNotEmpty && widget.keyboardType == TextInputType.datetime)) && _controller.value.text.isNotEmpty) {
        return IconButton(
          splashColor: Colors.transparent,
          onPressed: () => _clear(),
          icon: IconPathEnums.xMarkCircle.widget(color: context.textColors.title, width: context.width * 0.055),
        );
      }
    }
    return null;
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call("");
    widget.onClear?.call();
    validator("");
  }

  Widget? _prefixIcon() {
    if (widget.prefixIcon != null) {
      return Padding(
        padding: EdgeInsets.all(context.width * 0.03),
        // ignore: deprecated_member_use
        child: SvgPicture.asset(widget.prefixIcon!, color: _prefixColor),
      );
    }
    return null;
  }

  String? validator(String? value) {
    value ??= _controller.text;
    Logger.instance.log("VALIDATOR ${widget.label} $value");

    String? error;
    if (widget.required! && value.isEmpty) error = "Bu alan boş bırakılamaz";
    if (value.isNotEmpty) {
      if (widget.minLength != null && value.length < widget.minLength! && error == null) error = "En az ${widget.minLength} karakter giriniz";
      if (widget.maxLength != null && value.length > widget.maxLength! && error == null) error = "En fazla ${widget.maxLength} karakter giriniz";
      if (widget.keyboardType == TextInputType.emailAddress && error == null) {
        RegExp regex = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        if (!regex.hasMatch(value)) {
          error = "Geçerli bir e-posta adresi giriniz";
        }
      }
    }

    if (widget.validator != null && error == null) {
      error = widget.validator!(value);
    }

    if (widget.onValidate != null) widget.onValidate!(error == null);

    return error;
  }

  @override
  Widget build(BuildContext context) {
    return widget.minHeigth != null || widget.keyboardType == TextInputType.multiline
        ? SizedBox(
            /* height: widget.minHeigth ?? (widget.keyboardType == TextInputType.multiline ? context.height * 0.09 : context.height * 0.06), */
            child: inputWidget,
          )
        : inputWidget;
  }

  Widget get inputWidget {
    return TextFormField(
      /* textAlignVertical: (widget.keyboardType == TextInputType.multiline ? TextAlignVertical.top : null), */
      readOnly: (widget.readOnlyWhenStateBusy && context.watch<StateManagement>().state == ViewStateEnum.Busy) ||
          widget.keyboardType == TextInputType.datetime,
      textInputAction: widget.textInputAction ??
          (widget.keyboardType == TextInputType.multiline
              ? TextInputAction.newline
              : ((widget.lastInput ?? false) ? TextInputAction.done : TextInputAction.next)),
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }

        /* check validation for enable button when typing, but if error is nut null doesnt set error  */
        String? err = validator(val);
        if (err == null) {
          setState(() => errorText = err);
        }
      },
      onFieldSubmitted: (value) {
        widget.onFieldSubmitted?.call(value);
        Logger.instance.log("onFieldSubmitted ${widget.label} $value");
        if (widget.textInputAction != null && widget.textInputAction == TextInputAction.search) return;

        Logger.instance.log("onFieldSubmitted ${widget.label} $value");
        if (widget.lastInput == true) {
          _focusNode.unfocus();
        } else {
          FocusScope.of(context).nextFocus();
        }
      },
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obsecureText && !_isOpened,
      keyboardType: widget.keyboardType,
      controller: _controller,
      enabled: widget.enabled,
      maxLines: widget.keyboardType == TextInputType.multiline ? 3 : 1,
      minLines: 1,
      /* expands: widget.keyboardType != TextInputType.multiline && widget.minHeigth != null, */
      onTap: infoMessage,
      validator: validator,
      style: context.fonts.body.copyWith(color: context.textColors.filledInputForm),
      decoration: InputDecoration(
        errorText: errorText,
        alignLabelWithHint: true,
        prefixIcon: _prefixIcon(),
        suffixIcon: _suffixIcon(),
        labelText: widget.label,
        prefixText: widget.prefixText,
        prefixStyle: context.fonts.body.copyWith(color: context.textColors.filledInputForm),
        labelStyle: TextStyle(color: _labelColor),
        contentPadding: EdgeInsets.symmetric(vertical: (widget.keyboardType == TextInputType.multiline ? 10 : 0), horizontal: 10),
        enabledBorder: _border(context.textColors.title),
        focusedBorder: _border(context.themeColors.accent),
        disabledBorder: _border(context.themeColors.deactive),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red),
      ),
    );
  }
}

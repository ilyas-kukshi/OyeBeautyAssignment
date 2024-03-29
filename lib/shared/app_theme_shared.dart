import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeShared {
  static Color turquoise = const Color(0xff04D4F0);
  static Color aqua = const Color(0xff04ECF0);
  static Color blueGrotto = const Color(0xff059DC0);

  static appBar(
      {required String title,
      required BuildContext context,
      bool automaticallyImplyLeading = false,
      bool? centerTitle = true,
      Widget? leading,
      List<Widget>? actions,
      Color? backgroundColor = Colors.white}) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
      ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }

  static sharedButton(
      {required BuildContext context,
      double height = 60,
      required double width,
      Color color = const Color(0xff62B6B7),
      required String buttonText,
      required dynamic Function()? onTap,
      double borderRadius = 0.0,
      double textSize = 16,
      Color textColor = Colors.white,
      FontWeight fontWeight = FontWeight.w600}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: Theme.of(context)
            .textTheme
            .headline1
            ?.copyWith(fontSize: textSize)
            .copyWith(color: textColor, fontWeight: fontWeight),
      ),
    );

    // return ElevatedButton(
    //     onPressed: onPressed,
  }

  static textFormField(
      {required BuildContext context,
      String labelText = '',
      String hintText = '',
      String? initialValue,
      String prefixText = '',
      TextEditingController? controller,
      TextInputAction? textInputAction,
      TextInputType? keyboardType,
      AutovalidateMode? autovalidateMode,

      //
      String? Function(String?)? validator,
      void Function(String)? onChanged,
      void Function(String?)? onSaved,
      void Function()? onEditingComplete,
      void Function(String)? onFieldSubmitted,
      void Function()? onTap,
      List<TextInputFormatter>? inputFormatters,

      //
      bool obscureText = false,
      bool autoFocus = false,
      bool readonly = false,
      bool expands = false,

      //
      int? maxLines,
      int? minLines,
      double borderRadius = 0,
      double enabledBorderWidth = 2,

      //
      Color enabledBorderColor = Colors.cyan,

      //
      Widget? suffixIcon,
      Widget? prefixIcon}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      initialValue: initialValue,
      obscureText: obscureText,
      autofocus: autoFocus,
      readOnly: readonly,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headline3?.copyWith(
            fontSize: 14, color: const Color(0xff757575), wordSpacing: 2),
        // labelText: labelText,
        // labelStyle: Theme.of(context)
        //     .textTheme
        //     .headline3
        //     ?.copyWith(fontSize: 16, color: Colors.black),
        suffixIcon: suffixIcon,
        isDense: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color: enabledBorderColor, width: enabledBorderWidth)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black)),
      ),
    );
  }

  static sharedRaisedButton({
    required BuildContext context,
    required double height,
    required double width,
    required Color color,
    required String buttonText,
    required void Function()? onPressed,
    double borderRadius = 0.0,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: height, width: width),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
        ),
        // style: ElevatedButton.styleFrom(primary: color),
      ),
    );
  }
}

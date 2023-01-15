// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget CustomText(
        {Key? key,
        String? text,
        Color? color,
        double? fontSize,
        TextAlign? textAlign,
        FontWeight? fontweight,
        bool? underline = false,
        TextOverflow? overflow,
        EdgeInsetsGeometry? padding,
        int? maxLines}) =>
    Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text!,
        textAlign: textAlign,
        style: TextStyle(
            color: color ?? Colors.black,
            decoration: underline == true
                ? TextDecoration.underline
                : TextDecoration.none,
            fontSize: fontSize ?? 3.w,
            fontWeight: fontweight ?? FontWeight.normal,
         ),
        overflow: overflow,
        maxLines: maxLines,
      ),
    );

// ignore_for_file: invalid_required_named_param, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import '../../config/constants.dart';
import '../../config/route/scale_route.dart';

Widget defaultTextButton({
  required String title,
  required void Function()? onPressed,
}) =>
    TextButton(onPressed: onPressed, child: Text(title));

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.purple,
  required Function()? function,
  @required String? text,
  double radius = 5.0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text!.toUpperCase(),
          style: const TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  String? hint,
  required TextInputType type,
  required String label,
  IconData? prefix,
  required String? Function(String?)? validate,
  bool isPassword = false,
  IconData? suffix,
  Function()? onSuffixPressed,
  Function()? onTap,
  Function(String)? onChanged,
  void Function(String)? onSubmit,
}) =>
    Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: descriptionTextColor.withOpacity(.3)),
      child: TextFormField(
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: onSuffixPressed,
                )
              : null,
        ),
        validator: validate!,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: descriptionTextColor.withOpacity(.3),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      ScaleRoute(page: widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

showCustom(BuildContext context, String message, Color color, IconData icon) {
  FToast fToast = FToast();

  TextSpan span = TextSpan(text: message);
  TextPainter tp = TextPainter(
    text: span,
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
  );
  tp.layout();

  fToast.init(context);
  Widget toast = ListTile(
    tileColor: color,
    leading: Icon(
      icon,
      size: 20.0,
    ),
    title: Text(
      message,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          overflow: TextOverflow.ellipsis),
    ),
  );
  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 4),
    gravity: ToastGravity.BOTTOM,
  );
}

Future<File> loadAssetImage(String imagePath) async {
  final ByteData byteData = await rootBundle.load(imagePath);
  final Directory tempDir = await getTemporaryDirectory();
  final File tempFile = File('${tempDir.path}/Default_prf.png');
  await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

  return tempFile;
}

Future<bool> onWillPop() {
  // Do something before the user goes back.
  // For example, you can save the user's progress.
  return Future.value(false);
}

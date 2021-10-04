import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lottie/lottie.dart';
import 'Style.dart';
import 'AssetsManager.dart';
import 'CommonShape.dart';
import 'ScreenUtil.dart';

//~~ Zuhair
// this is for common UI widgets
class CommonUI {
  ///Zuhair: this widget used for showing alert
  static Future<void> alert(BuildContext context,
      {String title = '',
      required String msg,
      VoidCallback? onDone,
      VoidCallback? onDismiss}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (onDone != null) {
                  onDone();
                }
                Navigator.of(context).pop();
              },
              child: Text(
                MaterialLocalizations.of(context).okButtonLabel,
                style: FontStyle.normal(context: context, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (onDismiss != null) {
      onDismiss();
    }
  }

  ///Zuhair: this widget used for showing dialog when some functions complete successfully
  static Future<void> successDialog(
    BuildContext context, {
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LottieBuilder.asset(
                  AnimAssets.success,
                  height: 70,
                  repeat: false,
                ),
                Text(
                  message,
                  style: FontStyle.normal(context: context),
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      MaterialLocalizations.of(context).okButtonLabel,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  ///Zuhair: this widget used for textField
  static Widget textField(
      {required BuildContext context,
      required String name,
      String? label,
      String? hint,
      required TextEditingController? controller,
      Widget? icon,
      int? maxLines,
      Function(String?)? onFieldSubmitted,
      bool obscureText = false,
      Widget? suffixIcon,
      Widget? prefixIcon,
      Color borderColor = const Color(0xffD8D7D3),
      bool isEdit = false,
      TextInputType keyboardType = TextInputType.multiline,
      String? Function(String?)? validate,
      Function(String?)? onChange}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormBuilderTextField(
          onSubmitted: onFieldSubmitted,
          name: name,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: borderColor),
              ),
              labelText: label,
              hintText: hint,
              icon: icon,
              prefixIcon: prefixIcon,
              suffixIcon: isEdit ? const Icon(Icons.edit) : suffixIcon,
              hintStyle:
                  FontStyle.normal(context: context, color: Style.beigeCoffee)),
          keyboardType: keyboardType,
          minLines: 1,
          maxLines: maxLines ?? 1,
          onChanged: onChange,
          validator: validate),
    );
  }

  ///Zuhair: dropDownButton
  static Widget dropDownButton({
    required BuildContext context,
    required List<DropdownMenuItem<Object>> items,
    required Function(Object?)? onChanged,
    Widget? icon,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 15,
          left: ScreenUtil.isDesktop(context) ? 16 : 0,
          right: ScreenUtil.isDesktop(context) ? 16 : 0),
      child: SizedBox(
        width: ScreenUtil.isDesktop(context) ? 300 : null,
        child: DropdownButtonFormField(
            icon: icon, items: items, onChanged: onChanged, hint: Text(text)),
      ),
    );
  }

  ///Zuhair: this widget used for showing toast
  // static void toast(BuildContext context, String msg,
  //     {Color bgColor = const Color(0xAA000000),
  //     Color textColor = Colors.white}) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_LONG,
  //       backgroundColor: bgColor,
  //       textColor: textColor,
  //       fontSize: 16.0);
  // }
  static void snackBar(BuildContext context, String msg,
      {Color bgColor = Style.beigeCoffee, Color textColor = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      backgroundColor: bgColor,
      duration: const Duration(milliseconds: 1000),
    ));
  }

  ///Zuhair: this widget used for showing empty status
  static Center empty(String text) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          AnimAssets.empty,
          height: 190,
          // repeat: false,
        ),
        Text(text),
      ],
    ));
  }

  ///Zuhair: this widget used for loading
  static Center loading() {
    return Center(
        child: LottieBuilder.asset(
      AnimAssets.loadingCoffee,
      height: 90,
      // repeat: false,
    ));
  }

  ///Zuhair: this widget used for showing error
  static Center error(BuildContext context, String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          AnimAssets.error,
          height: 190,
          // repeat: false,
        ),
        ScreenUtil.isDesktop(context) ? SelectableText(error) : Text(error),
      ],
    ));
  }

  static Widget textButton(
      {Color? color,
      double minWidth = 140,
      double minHight = 40,
      TextStyle? textStyle,
      EdgeInsetsGeometry? padding,
      required String text,
      double boarder = 15, //10
      Color textColor = Colors.white,
      required VoidCallback? click}) {
    return TextButton(
        clipBehavior: Clip.antiAlias,
        style: TextButton.styleFrom(
            padding: padding,
            primary: textColor,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(boarder))),
            minimumSize: Size(minWidth, minHight)),
        onPressed: click,
        child: Text(
          text,
          style: textStyle,
        ));
  }

  static Widget elevatedButton(
      {Color? color,
      double minWidth = 140,
      double minHight = 40,
      required String text,
      required BuildContext context,
      double radius = 13,
      double elevation = 3.0,
      Color textColor = Colors.white,
      Widget? icon,
      required void Function()? click}) {
    color ??= Style.primary;
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: color,
        onPrimary: textColor,
        // shadowColor: color,
        elevation: elevation,
        textStyle: FontStyle.normal(
          context: context,
        ),
        shape: CommonShapes.outlinedBorder(radius),
        minimumSize: Size(minWidth, minHight));
    return icon != null
        ? ElevatedButton.icon(
            style: style, onPressed: click, label: Text(text), icon: icon)
        : ElevatedButton(style: style, onPressed: click, child: Text(text));
  }

  ///Zuhair: basicly this outlineButton
  static Widget outlineBtn(
      {required BuildContext context,
      required String text,
      double radius = 40, //16.0,
      Color? textColor,
      double? minWidth = 140,
      double? minHight = 40,
      Color? color,
      bool withIcon = false,
      Color? borderColor,
      TextStyle? textStyle,
      Size? fixedSize,
      IconData? icon,
      EdgeInsetsGeometry? padding,
      required void Function() onPressed}) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(minWidth!, minHight!),
          fixedSize: fixedSize,
          animationDuration: const Duration(milliseconds: 300),
          primary: textColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          backgroundColor: color ?? Colors.transparent,
          side: BorderSide(color: borderColor ?? Style.primary, width: 1.1),
        ),
        onPressed: onPressed,
        child: withIcon
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon ?? null,
                      color: borderColor ?? Style.primary,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(text, style: textStyle)
                    // Spacer(),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text, style: textStyle),
              ));
  }

  static Widget outlineBtnIcon({
    required BuildContext context,
    double radius = 50, //16.0,
    Color? textColor,
    double minWidth = 50,
    double minHight = 50,
    Color? color,
    Color? borderColor,
    Size? fixedSize,
    required IconData icon,
    Color? iconColor,
    EdgeInsetsGeometry? padding,
    required void Function() onPressed,
  }) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(minWidth, minHight),
          fixedSize: fixedSize,
          animationDuration: const Duration(milliseconds: 300),
          primary: textColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          backgroundColor: color ?? Colors.transparent,
          side: BorderSide(color: borderColor ?? Style.primary, width: 1.1),
        ),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: borderColor ?? iconColor,
          size: ScreenUtil.isDesktop(context) ? 32 : 25,
        ));
  }

  ///Zuhair: this widget loading image and cached it for mobile cachedImage
  static Widget cachedImage(String? url, String ph,
      {Color? color, BoxFit fit = BoxFit.cover}) {
    return url == null
        ? Image.asset(
            ph,
            fit: fit,
          )
        : CachedNetworkImage(
            maxHeightDiskCache: 300,
            fit: fit,
            color: color,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Style.primary,
                )),
            errorWidget: (context, url, error) => Image.asset(
                  ph,
                  fit: fit,
                ),
            imageUrl: url);
  }

  ///Zuhair: ignore this right now
  static Widget webMenuButton({
    required String text,
    required VoidCallback onPress,
  }) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }

  ///Zuhair: this widget make text SelectableText for web and non-SelectableText for mobile
  static Widget text({
    required BuildContext context,
    required String text,
    TextStyle? style,
    int? minLines,
    int? maxLines,
    TextAlign? textAlign = TextAlign.start,
  }) {
    if (ScreenUtil.isDesktop(context) || ScreenUtil.isTablet(context)) {
      return SelectableText(
        text,
        minLines: minLines,
        maxLines: maxLines,
        textAlign: textAlign,
        style: style ?? FontStyle.normal(context: context, color: Colors.white),
      );
    } else {
      return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        softWrap: true,
        style: style ?? FontStyle.normal(context: context, color: Colors.white),
      );
    }
  }
}

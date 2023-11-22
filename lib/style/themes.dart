import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData appTheme() {
  return ThemeData(
      scaffoldBackgroundColor: AppColorPalette.colorScaffold,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: AppColorPalette.primary,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 8,
        color: AppColorPalette.primary,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
      ),
      cardTheme: CardTheme(
        elevation: 16,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dialogTheme: DialogTheme(
          elevation: 16,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      textTheme: const TextTheme(
        titleSmall: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.normal),
        bodyLarge: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.normal),
      ));
}

extension SetTextStyle on TextStyle {
  TextStyle textTitleThemeSmall(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!;
  }

  TextStyle textThemeSmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }

  TextStyle textThemeMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  TextStyle textThemeLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  TextStyle textThemeHint(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey);
  }
}

extension SetStringTheme on String {
  Text setTextTitleThemeSmall(BuildContext context) {
    return Text(this, style: const TextStyle().textTitleThemeSmall(context));
  }

  Text setTextThemeSmall(BuildContext context) {
    return Text(this, style: const TextStyle().textThemeSmall(context));
  }

  Text setTextThemeMedium(BuildContext context) {
    return Text(this, style: const TextStyle().textThemeMedium(context));
  }

  Text setTextThemeLarge(BuildContext context) {
    return Text(this, style: const TextStyle().textThemeLarge(context));
  }

  Text setTextThemeMediumBold(BuildContext context) {
    return Text(this, style: const TextStyle().textThemeMedium(context).copyWith(fontWeight: FontWeight.bold));
  }

  Text setTextThemeButton(BuildContext context) {
    return Text(this,
        style: const TextStyle().textThemeMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold));
  }

  Text setTextThemeCard(BuildContext context) {
    return Text(this,
        style: const TextStyle().textTitleThemeSmall(context).copyWith(color: Colors.white, shadows: [
          const Shadow(
            color: Colors.black,
            blurRadius: 0.0,
            offset: Offset(1.0, 1.0),
          )
        ]));
  }
}

InputDecoration getInputDecorator(BuildContext context, {String? label, String? hint}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle().textThemeHint(context),
    labelText: label,
    labelStyle: const TextStyle().textThemeMedium(context),
    enabledBorder: getInputBorder(),
    disabledBorder: getInputBorder().copyWith(borderSide: const BorderSide(color: Colors.grey)),
    errorBorder: getInputBorder().copyWith(borderSide: const BorderSide(color: Colors.red)),
    focusedBorder: getInputBorder(),
    filled: true,
    fillColor: Colors.white,
  );
}

OutlineInputBorder getInputBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(color: AppColorPalette.secondary),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}

ButtonStyle getButtonStyle() {
  return ButtonStyle(
      side: MaterialStateProperty.all(const BorderSide(color: AppColorPalette.primary)),
      backgroundColor: const MaterialStatePropertyAll(AppColorPalette.primary));
}

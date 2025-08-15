import 'package:flutter/material.dart';

class Palette {
  /// GENERATE SHADE AND TINT LINK : https://maketintsandshades.com/
  // Success Swatch
  static const MaterialColor kSuccessSwatch = MaterialColor(
    0xff4ca817, // Default
    <int, Color>{
      50: Color(0xffedf6e8), // tintColor - 0.9
      100: Color(0xffdbeed1), // tintColor - 0.8
      200: Color(0xffb7dca2), // tintColor - 0.6
      300: Color(0xff94cb74), // tintColor - 0.4
      400: Color(0xff70b945), // tintColor - 0.2
      500: Color(0xff4ca817), // color
      600: Color(0xff449715), // shadeColor - 0.1
      700: Color(0xff3d8612), // shadeColor - 0.2
      800: Color(0xff357610), // shadeColor - 0.3
      900: Color(0xff2e650e), // shadeColor - 0.4
    },
  );

  // Primary Swatch
  static const MaterialColor kPrimarySwatch = MaterialColor(
    0xffed323e, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xfffdebec), // tintColor - 0.9
      100: Color(0xfffbd6d8), // tintColor - 0.8
      200: Color(0xfff8adb2), // tintColor - 0.6
      300: Color(0xfff4848b), // tintColor - 0.4
      400: Color(0xfff15b65), // tintColor - 0.2
      500: Color(0xffed323e), // color
      600: Color(0xffd52d38), // shadeColor - 0.1
      700: Color(0xffbe2832), // shadeColor - 0.2
      800: Color(0xffa6232b), // shadeColor - 0.3
      900: Color(0xff8e1e25), // shadeColor - 0.4
    },
  );

  // Tertiary Swatch
  static const MaterialColor kTertiarySwatch = MaterialColor(
    0xff395759,
    <int, Color>{
      50: Color(0xffebeeee), // tintColor - 0.9
      100: Color(0xffd7ddde), // tintColor - 0.8
      200: Color(0xffb0bcbd), // tintColor - 0.6
      300: Color(0xff889a9b), // tintColor - 0.4
      400: Color(0xff61797a), // tintColor - 0.2
      500: Color(0xff395759), // color
      600: Color(0xff334e50), // shadeColor - 0.1
      700: Color(0xff2e4647), // shadeColor - 0.2
      800: Color(0xff283d3e), // shadeColor - 0.3
      900: Color(0xff223435), // shadeColor - 0.4
    },
  );

  // Secondary Swatch
  static const MaterialColor kSecondarySwatch = MaterialColor(
    0xffffcc29,
    <int, Color>{
      50: Color(0xfffffaea), // tintColor - 0.9
      100: Color(0xfffff5d4), // tintColor - 0.8
      200: Color(0xffffeba9), // tintColor - 0.6
      300: Color(0xffffe07f), // tintColor - 0.4
      400: Color(0xffffd654), // tintColor - 0.2
      500: Color(0xffffcc29), // color
      600: Color(0xffe6b825), // shadeColor - 0.1
      700: Color(0xffcca321), // shadeColor - 0.2
      800: Color(0xffb38f1d), // shadeColor - 0.3
      900: Color(0xff997a19), // shadeColor - 0.4
    },
  );

  //Yellow Warming
  static const MaterialColor kYellowWarmingSwatch = MaterialColor(
    0xffffcc29,
    <int, Color>{
      50: Color(0xffF79009), // tintColor - 0.9
      100: Color(0xffFDE9CE), // tintColor - 0.8
      200: Color(0xffFCDAAD), // tintColor - 0.6
      300: Color(0xffFBC784), // tintColor - 0.4
      400: Color(0xffFAB55B), // tintColor - 0.2
      500: Color(0xffF8A232), // color
      600: Color(0xffCE7807), // shadeColor - 0.1
      700: Color(0xffA56006), // shadeColor - 0.2
      800: Color(0xff7B4804), // shadeColor - 0.3
      900: Color(0xff523003), // shadeColor - 0.4
    },
  );
}

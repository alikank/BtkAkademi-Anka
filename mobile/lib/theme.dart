import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a68),
      surfaceTint: Color(0xff006a68),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff23ebe8),
      onPrimaryContainer: Color(0xff004746),
      secondary: Color(0xff2e6766),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb5efed),
      onSecondaryContainer: Color(0xff125150),
      tertiary: Color(0xff60588a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd5ccff),
      onTertiaryContainer: Color(0xff3f3767),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff3fbfa),
      onSurface: Color(0xff151d1d),
      onSurfaceVariant: Color(0xff3b4a49),
      outline: Color(0xff6b7a79),
      outlineVariant: Color(0xffbacac8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2a3231),
      inversePrimary: Color.fromARGB(255, 4, 163, 126),
      primaryFixed: Color(0xff42faf7),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xff00ddda),
      onPrimaryFixedVariant: Color(0xff00504e),
      secondaryFixed: Color(0xffb3edeb),
      onSecondaryFixed: Color(0xff00201f),
      secondaryFixedDim: Color(0xff98d1cf),
      onSecondaryFixedVariant: Color(0xff0f4f4e),
      tertiaryFixed: Color(0xffe6deff),
      onTertiaryFixed: Color(0xff1c1343),
      tertiaryFixedDim: Color(0xffc9bff9),
      onTertiaryFixedVariant: Color(0xff484071),
      surfaceDim: Color(0xffd4dcdb),
      surfaceBright: Color(0xfff3fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf5f4),
      surfaceContainer: Color(0xffe7efee),
      surfaceContainerHigh: Color(0xffe2eae9),
      surfaceContainerHighest: Color(0xffdce4e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004b4a),
      surfaceTint: Color(0xff006a68),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff008280),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff074b4a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff457e7c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff443c6d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff766ea2),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff3fbfa),
      onSurface: Color(0xff151d1d),
      onSurfaceVariant: Color(0xff374645),
      outline: Color(0xff536261),
      outlineVariant: Color(0xff6e7e7d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2a3231),
      inversePrimary: Color(0xff00ddda),
      primaryFixed: Color(0xff008280),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006766),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff457e7c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2b6563),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff766ea2),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5d5588),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd4dcdb),
      surfaceBright: Color(0xfff3fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf5f4),
      surfaceContainer: Color(0xffe7efee),
      surfaceContainerHigh: Color(0xffe2eae9),
      surfaceContainerHighest: Color(0xffdce4e3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002727),
      surfaceTint: Color(0xff006a68),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b4a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002727),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff074b4a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff231b4a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff443c6d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff3fbfa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff182626),
      outline: Color(0xff374645),
      outlineVariant: Color(0xff374645),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2a3231),
      inversePrimary: Color(0xff88fffc),
      primaryFixed: Color(0xff004b4a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003332),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff074b4a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003332),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff443c6d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2d2655),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd4dcdb),
      surfaceBright: Color(0xfff3fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf5f4),
      surfaceContainer: Color(0xffe7efee),
      surfaceContainerHigh: Color(0xffe2eae9),
      surfaceContainerHighest: Color(0xffdce4e3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 4, 163, 126),
      surfaceTint: Color(0xff00ddda),
      onPrimary: Color(0xff003736),
      primaryContainer: Color(0xff00ddda),
      onPrimaryContainer: Color(0xff003d3c),
      secondary: Color(0xff98d1cf),
      onSecondary: Color(0xff003736),
      secondaryContainer: Color(0xff014746),
      onSecondaryContainer: Color(0xffa5dfdc),
      tertiary: Color(0xfff5efff),
      onTertiary: Color(0xff312959),
      tertiaryContainer: Color(0xffcac0fa),
      onTertiaryContainer: Color(0xff373060),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0d1514),
      onSurface: Color(0xffdce4e3),
      onSurfaceVariant: Color(0xffbacac8),
      outline: Color(0xff849493),
      outlineVariant: Color(0xff3b4a49),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdce4e3),
      inversePrimary: Color(0xff006a68),
      primaryFixed: Color(0xff42faf7),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xff00ddda),
      onPrimaryFixedVariant: Color(0xff00504e),
      secondaryFixed: Color(0xffb3edeb),
      onSecondaryFixed: Color(0xff00201f),
      secondaryFixedDim: Color(0xff98d1cf),
      onSecondaryFixedVariant: Color(0xff0f4f4e),
      tertiaryFixed: Color(0xffe6deff),
      onTertiaryFixed: Color(0xff1c1343),
      tertiaryFixedDim: Color(0xffc9bff9),
      onTertiaryFixedVariant: Color(0xff484071),
      surfaceDim: Color(0xff0d1514),
      surfaceBright: Color(0xff333b3a),
      surfaceContainerLowest: Color(0xff08100f),
      surfaceContainerLow: Color(0xff151d1d),
      surfaceContainer: Color(0xff192121),
      surfaceContainerHigh: Color(0xff242b2b),
      surfaceContainerHighest: Color(0xff2e3636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadfffc),
      surfaceTint: Color(0xff00ddda),
      onPrimary: Color(0xff003736),
      primaryContainer: Color(0xff00ddda),
      onPrimaryContainer: Color(0xff001414),
      secondary: Color(0xff9cd5d3),
      onSecondary: Color(0xff001a1a),
      secondaryContainer: Color(0xff629a99),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff5efff),
      onTertiary: Color(0xff312959),
      tertiaryContainer: Color(0xffcac0fa),
      onTertiaryContainer: Color(0xff120839),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0d1514),
      onSurface: Color(0xfff4fcfb),
      onSurfaceVariant: Color(0xffbececd),
      outline: Color(0xff96a6a5),
      outlineVariant: Color(0xff778685),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdce4e3),
      inversePrimary: Color(0xff005150),
      primaryFixed: Color(0xff42faf7),
      onPrimaryFixed: Color(0xff001414),
      primaryFixedDim: Color(0xff00ddda),
      onPrimaryFixedVariant: Color(0xff003d3c),
      secondaryFixed: Color(0xffb3edeb),
      onSecondaryFixed: Color(0xff001414),
      secondaryFixedDim: Color(0xff98d1cf),
      onSecondaryFixedVariant: Color(0xff003d3c),
      tertiaryFixed: Color(0xffe6deff),
      onTertiaryFixed: Color(0xff110738),
      tertiaryFixedDim: Color(0xffc9bff9),
      onTertiaryFixedVariant: Color(0xff372f5f),
      surfaceDim: Color(0xff0d1514),
      surfaceBright: Color(0xff333b3a),
      surfaceContainerLowest: Color(0xff08100f),
      surfaceContainerLow: Color(0xff151d1d),
      surfaceContainer: Color(0xff192121),
      surfaceContainerHigh: Color(0xff242b2b),
      surfaceContainerHighest: Color(0xff2e3636),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeafffd),
      surfaceTint: Color(0xff00ddda),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff00e2df),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeafffd),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff9cd5d3),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffef9ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffcdc4fd),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0d1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffeefefd),
      outline: Color(0xffbececd),
      outlineVariant: Color(0xffbececd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdce4e3),
      inversePrimary: Color(0xff00302f),
      primaryFixed: Color(0xff49fffb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff00e2df),
      onPrimaryFixedVariant: Color(0xff001a1a),
      secondaryFixed: Color(0xffb7f2ef),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9cd5d3),
      onSecondaryFixedVariant: Color(0xff001a1a),
      tertiaryFixed: Color(0xffeae3ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcdc4fd),
      onTertiaryFixedVariant: Color(0xff160d3d),
      surfaceDim: Color(0xff0d1514),
      surfaceBright: Color(0xff333b3a),
      surfaceContainerLowest: Color(0xff08100f),
      surfaceContainerLow: Color(0xff151d1d),
      surfaceContainer: Color(0xff192121),
      surfaceContainerHigh: Color(0xff242b2b),
      surfaceContainerHighest: Color(0xff2e3636),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

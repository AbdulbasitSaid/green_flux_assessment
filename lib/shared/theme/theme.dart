import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  const NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class ThemeSettingChange extends Notification {
  ThemeSettingChange({required this.settings});
  final ThemeSettings settings;
}

class ThemeProvider extends InheritedWidget {
  ThemeProvider(
      {super.key,
      required this.settings,
      required this.lightDynamic,
      required this.darkDynamic,
      required super.child});

  final ValueNotifier<ThemeSettings> settings;
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;

  final pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
    },
  );

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColor) {
    return Color(
        Blend.harmonize(targetColor.value, settings.value.sourceColor.value));
  }

  Color source(Color? target) {
    Color source = settings.value.sourceColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light
        ? lightDynamic?.primary
        : darkDynamic?.primary;
    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? source(targetColor),
      brightness: brightness,
    );
  }

  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );

  CardTheme cardTheme() {
    return CardTheme(
      elevation: 0,
      shape: shapeMedium,
      clipBehavior: Clip.antiAlias,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      shape: shapeMedium,
      selectedColor: colors.secondary,
    );
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return AppBarTheme(
      elevation: 0,
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
    );
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return TabBarTheme(
      labelColor: colors.secondary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return BottomAppBarTheme(
      color: colors.surface,
      elevation: 0,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.surfaceVariant,
      selectedItemColor: colors.onSurface,
      unselectedItemColor: colors.onSurfaceVariant,
      elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      backgroundColor: colors.surface,
    );
  }

  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006A68),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF6FF7F4),
    onPrimaryContainer: Color(0xFF00201F),
    secondary: Color(0xFF315DA8),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD8E2FF),
    onSecondaryContainer: Color(0xFF001A41),
    tertiary: Color(0xFF00629F),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFCFE4FF),
    onTertiaryContainer: Color(0xFF001D34),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFF8FDFF),
    onBackground: Color(0xFF001F25),
    surface: Color(0xFFF8FDFF),
    onSurface: Color(0xFF001F25),
    surfaceVariant: Color(0xFFDAE5E3),
    onSurfaceVariant: Color(0xFF3F4948),
    outline: Color(0xFF6F7978),
    onInverseSurface: Color(0xFFD6F6FF),
    inverseSurface: Color(0xFF00363F),
    inversePrimary: Color(0xFF4DDAD7),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006A68),
    outlineVariant: Color(0xFFBEC9C7),
    scrim: Color(0xFF000000),
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF4DDAD7),
    onPrimary: Color(0xFF003736),
    primaryContainer: Color(0xFF00504F),
    onPrimaryContainer: Color(0xFF6FF7F4),
    secondary: Color(0xFFADC6FF),
    onSecondary: Color(0xFF002E69),
    secondaryContainer: Color(0xFF10448F),
    onSecondaryContainer: Color(0xFFD8E2FF),
    tertiary: Color(0xFF9ACBFF),
    onTertiary: Color(0xFF003355),
    tertiaryContainer: Color(0xFF004A79),
    onTertiaryContainer: Color(0xFFCFE4FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF001F25),
    onBackground: Color(0xFFA6EEFF),
    surface: Color(0xFF001F25),
    onSurface: Color(0xFFA6EEFF),
    surfaceVariant: Color(0xFF3F4948),
    onSurfaceVariant: Color(0xFFBEC9C7),
    outline: Color(0xFF889392),
    onInverseSurface: Color(0xFF001F25),
    inverseSurface: Color(0xFFA6EEFF),
    inversePrimary: Color(0xFF006A68),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4DDAD7),
    outlineVariant: Color(0xFF3F4948),
    scrim: Color(0xFF000000),
  );

  final SearchBarThemeData lightSearchBarThemeData = SearchBarThemeData(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: MaterialStatePropertyAll(lightColorScheme.onTertiary),
      textStyle: MaterialStatePropertyAll(
        TextStyle(color: lightColorScheme.scrim),
      ));

  final SearchBarThemeData darkSearchBarThemeData = SearchBarThemeData(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: MaterialStatePropertyAll(darkColorScheme.onPrimary),
      textStyle: MaterialStatePropertyAll(
        TextStyle(color: darkColorScheme.onSurface),
      ));

  ThemeData light([Color? targetColor]) {
    lightColorScheme;
    return ThemeData.light(useMaterial3: true).copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: lightColorScheme,
      appBarTheme: appBarTheme(lightColorScheme),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(lightColorScheme),
      bottomAppBarTheme: bottomAppBarTheme(lightColorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(lightColorScheme),
      tabBarTheme: tabBarTheme(lightColorScheme),
      drawerTheme: drawerTheme(lightColorScheme),
      scaffoldBackgroundColor: lightColorScheme.background,
      searchBarTheme: lightSearchBarThemeData,
    );
  }

  ThemeData dark([Color? targetColor]) {
    darkColorScheme;
    return ThemeData.dark(useMaterial3: true).copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: darkColorScheme,
      appBarTheme: appBarTheme(darkColorScheme),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(darkColorScheme),
      bottomAppBarTheme: bottomAppBarTheme(darkColorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(darkColorScheme),
      tabBarTheme: tabBarTheme(darkColorScheme),
      drawerTheme: drawerTheme(darkColorScheme),
      scaffoldBackgroundColor: darkColorScheme.background,
      searchBarTheme: darkSearchBarThemeData,
    );
  }

  ThemeMode themeMode() {
    return settings.value.themeMode;
  }

  ThemeData theme(BuildContext context, [Color? targetColor]) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light
        ? light(targetColor)
        : dark(targetColor);
  }

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.settings != settings;
  }
}

class ThemeSettings {
  ThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}

Color randomColor() {
  return Color(Random().nextInt(0xFFFFFFFF));
}

// Custom Colors
const linkColor = CustomColor(
  name: 'Link Color',
  color: Color(0xFF00B0FF),
);

class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(ThemeProvider provider) {
    return provider.custom(this);
  }
}

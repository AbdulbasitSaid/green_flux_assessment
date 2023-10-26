import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'package:green_flux_assessment/features/charge_locations/application/cubit/charge_location_cubit.dart';
import 'package:green_flux_assessment/features/charge_locations/data/locations_api.dart';
import 'package:green_flux_assessment/features/charge_locations/domain/locations_repository.dart';
import 'package:green_flux_assessment/shared/router.dart';
import 'package:green_flux_assessment/shared/theme/theme.dart';
import 'package:flutter_bloc/src/repository_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settings = ValueNotifier(ThemeSettings(
    sourceColor: const Color(0xff40A6A4),
    themeMode: ThemeMode.system,
  ));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LocationsApi(httpClient: Client()),
        ),
        RepositoryProvider(
          create: (context) =>
              LocationsRepository(locationsApi: context.read()),
        ),
      ],
      child: BlocProvider(
        create: (context) => ChargeLocationCubit(context.read()),
        child: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => ThemeProvider(
              lightDynamic: lightDynamic,
              darkDynamic: darkDynamic,
              settings: settings,
              child: NotificationListener<ThemeSettingChange>(
                onNotification: (notification) {
                  settings.value = notification.settings;
                  return true;
                },
                child: ValueListenableBuilder<ThemeSettings>(
                  valueListenable: settings,
                  builder: (context, value, _) {
                    final theme = ThemeProvider.of(context);

                    return MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      title: 'Green Flux',
                      theme: theme.light(settings.value.sourceColor),
                      darkTheme: theme.dark(settings.value.sourceColor),
                      themeMode: theme.themeMode(),
                      routeInformationParser: appRouter.routeInformationParser,
                      routeInformationProvider:
                          appRouter.routeInformationProvider,
                      routerDelegate: appRouter.routerDelegate,
                    );
                  },
                ),
              )),
        ),
      ),
    );
  }
}

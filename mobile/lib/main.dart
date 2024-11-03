import 'package:anka/product/navigation/app_router.dart';
import 'package:anka/product/provider/theme_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'util.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const _MyAppContent(),
    );
  }
}

class _MyAppContent extends StatelessWidget {
  const _MyAppContent();

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme =
        createTextTheme(context, "Patrick Hand", "Patrick Hand");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      title: 'Anka',
      theme: theme.light(),
      darkTheme: theme.dark(),
      builder: BotToastInit(),
      themeMode: Provider.of<ThemeProvider>(context).darkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}

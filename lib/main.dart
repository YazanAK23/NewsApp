import 'package:flutter/material.dart';
import 'package:news_app/consts/theme_data.dart';
import 'package:news_app/inner_screens/blog_details.dart';
import 'package:news_app/provider/dark_theme_provider.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),

        ChangeNotifierProvider(create: (_) {
          return NewsProvider();
        }),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: HomeScreen(),
            routes: {
               NewsDetailsScreen.routeName: (ctx) => NewsDetailsScreen(),
            },
          );
        }
      ),
    );
  }
}

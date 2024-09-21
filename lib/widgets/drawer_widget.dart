import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/inner_screens/bookmarks_screen.dart';
import 'package:news_app/provider/dark_theme_provider.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/images/newspaper.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                  VerticalSpacing(20),
                  Flexible(
                    child: Text(
                      'News App',
                      style: GoogleFonts.lobster(
                        fontSize: 30,
                        color: themeState.getDarkTheme
                            ? Colors.white // White color for dark mode
                            : Colors.black, // Black color for light mode
                      ),
                    ),
                  ),
                ], 
              ),
            ),
            VerticalSpacing(20),
            listTiles(
              label: 'Home',
              icon: IconlyBold.home, // Correct
              fct: () {},
            ),
            listTiles(
              label: 'Bookmarks',
              icon: IconlyBold.bookmark,
              fct: () {
                 Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft ,
                    child: BookmarksScreen(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
            ),
            Divider(
              thickness: 5,
            ),
            SwitchListTile(
              title: Text(
                'Theme',
                style: TextStyle(
                  color: themeState.getDarkTheme
                      ? Colors.white
                      : Colors
                          .black, // White for dark mode, black for light mode
                  fontSize: 20, // Consistent font size
                  fontWeight: FontWeight
                      .bold, // Optional: Makes the text bold for better visibility
                ),
              ),
              secondary: Icon(
                themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: themeState.getDarkTheme
                    ? Colors.white
                    : Colors.black, // Match icon color to text color
              ),
              onChanged: (bool value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              },
              value: themeState.getDarkTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class listTiles extends StatelessWidget {
  const listTiles({
    super.key,
    required this.label,
    required this.fct,
    required this.icon,
  });
  final String label;
  final Function fct;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Icon(icon, color: isDarkTheme ? Colors.white : Colors.black),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color:
              isDarkTheme ? Colors.white : Colors.black, // Adaptive text color
        ),
      ),
      onTap: () {
        fct();
      },
    );
  }
}

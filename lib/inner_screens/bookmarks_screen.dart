import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/provider/dark_theme_provider.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/articles_widget.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final themeState = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeState.getDarkTheme
              ? Colors.white // Icon color for dark mode
              : Colors.black, // Icon color for light mode
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(
            textStyle: TextStyle(fontSize: 20, letterSpacing: 0.6),
          ),
        ),

        backgroundColor: Theme.of(context)
            .primaryColor, // Now it will change based on the theme
      ),
      
      body:  EmptyNewsWidget(text: 'you didn\'t add anything to your bookMarks yet ', imagePath: 'assets/images/bookmark.png'),
      
      // ListView.builder(
      //     itemCount: 20,
      //     itemBuilder: (ctx, index) {
      //       return const ArticlesWidget();
      //     }),
    );
  }
}

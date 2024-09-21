import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum NewsType{
  topTrending , 
  allNews, 
}

enum SortByEnum{
  relevancy ,
  popularity ,
  publishedAt,
}
TextStyle smallTextStyle = GoogleFonts.montserrat(fontSize: 15);

List<String> searchKeyWords = [

  'Football',
  'Flutter',
  'Python',
  'Weather',
  'crypto', 
  'Bitcoin',
  'Youtube',
  'Netflix',
  'Meta', 
];
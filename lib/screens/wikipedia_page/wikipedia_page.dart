import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WikipediaPage extends StatelessWidget {
  String data;
  WikipediaPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text(
          this.data,
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}

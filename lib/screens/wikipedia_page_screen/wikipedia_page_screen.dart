import 'package:brainly2/providers/wikipedia_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/wikipedia.dart';

class WikipediaPageScreen extends StatefulWidget {
  String id;
  WikipediaPageScreen(this.id);

  @override
  _WikipediaPageScreenState createState() => _WikipediaPageScreenState();
}

class _WikipediaPageScreenState extends State<WikipediaPageScreen> {
  bool _isLoading = false;
  List<Data> wikiList = [];

  void getWiki(String id) async {
    setState(() {
      _isLoading = true;
    });
    print('masuk initstate');
    Data data = await WikipediaPageProvider.fetch(id);
    setState(() {
      this.wikiList.add(data);
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.getWiki(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text(
          this.widget.id,
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
      body: wikiList.isNotEmpty
          ? Container(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  wikiList[0].title,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              Container(
                                child: Image.network(
                                  wikiList[0].thumbnail,
                                  width: 130,
                                ),
                              ),
                              Text(
                                "  " + wikiList[0].intro,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

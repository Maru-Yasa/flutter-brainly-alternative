import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/wikipedia.dart';
import '../../providers/wikipedia_provider.dart';
import '../wikipedia_page/wikipedia_page.dart';

class WikipediaScreen extends StatefulWidget {
  @override
  _WikipediaScreenState createState() => _WikipediaScreenState();
}

class _WikipediaScreenState extends State<WikipediaScreen> {
  String query = "";
  bool _isLoading = false;
  List wikiList = [];
  void dataCallback(String text) {
    setState(() {
      query = text;
    });
  }

  void getWiki(String query) async {
    setState(() {
      _isLoading = true;
    });
    print('masuk get wiki');
    dynamic data = await WikipediaProvider.fetch(query);
    print(data[0]);
    setState(() {
      this.wikiList = data;
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text(
          "Wikipedia API",
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInputWidget(this.getWiki),
                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 5.0),
                  child: this.wikiList.isNotEmpty
                      ? Text("tips:Tap di box untuk melihat detail")
                      : Text(""),
                )
              ],
            ),
          ),
          this._isLoading
              ? Container(
                  margin: EdgeInsets.all(20.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : WikiListWidget(this.wikiList)
        ],
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  Function callback;
  TextInputWidget(this.callback);
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController controller = TextEditingController();

  void onPresshandler() {
    String text = controller.text;
    setState(() {
      widget.callback(text);
    });
    controller.clear();
  }

  void onSubmitted(String text) {
    this.onPresshandler();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onSubmitted: this.onSubmitted,
        controller: controller,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
            labelStyle: GoogleFonts.montserrat(),
            hintText: "Cari",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: this.onPresshandler,
            )),
      ),
    );
  }
}

class WikiListWidget extends StatelessWidget {
  List wikiList = [];
  WikiListWidget(this.wikiList);
  @override
  Widget build(BuildContext context) {
    void onTapHandler(int id) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WikipediaPage(id.toString()),
          ));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: this.wikiList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTapHandler(this.wikiList[index].pageId),
            child: Card(
              margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                    child: Text(
                      this.wikiList[index].title,
                      style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context).textTheme.headline1),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 20.0),
                    child: Text(
                        this.wikiList[index].desc == ""
                            ? "Tidak ada deskripsi"
                            : this.wikiList[index].desc,
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.bodyText1)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

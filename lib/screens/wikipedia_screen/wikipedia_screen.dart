import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/wikipedia.dart';
import '../../providers/wikipedia_provider.dart';
import '../wikipedia_page_screen/wikipedia_page_screen.dart';

class WikipediaScreen extends StatefulWidget {
  @override
  _WikipediaScreenState createState() => _WikipediaScreenState();
}

class _WikipediaScreenState extends State<WikipediaScreen> {
  String query = "";
  bool _isLoading = false;
  List wikiList = [];
  bool isCloseTop = false;
  int offset = 0;
  void dataCallback(String text) {
    setState(() {
      query = text;
    });
  }

  void scrollCallback(double offset) {
    setState(() {
      isCloseTop = offset > 50 ? true : false;
    });
  }

  ScrollController scrollController = ScrollController();
  @override
  void getWiki(String query) async {
    setState(() {
      _isLoading = true;
    });
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
    Size size = MediaQuery.of(context).size;
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
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: isCloseTop ? 0 : size.height * 0.13,
            child: Container(
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
                        ? Text("tips:Tap di box untuk melihat detail" +
                            offset.toString())
                        : Text(""),
                  )
                ],
              ),
            ),
          ),
          this._isLoading
              ? Container(
                  margin: EdgeInsets.all(20.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : WikiListWidget(this.wikiList, this.scrollCallback)
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

class WikiListWidget extends StatefulWidget {
  List wikiList = [];
  Function scrollCallback;
  ScrollController? controller;
  WikiListWidget(this.wikiList, this.scrollCallback);
  @override
  _WikiListWidgetState createState() => _WikiListWidgetState();
}

class _WikiListWidgetState extends State<WikiListWidget> {
  bool isCloseTop = false;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    widget.controller = ScrollController();
    widget.controller?.addListener(() {
      setState(() {
        widget.scrollCallback(widget.controller?.offset);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void onTapHandler(int id) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WikipediaPageScreen(id.toString()),
          ));
    }

    return Expanded(
      child: ListView.builder(
        controller: widget.controller,
        itemCount: this.widget.wikiList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTapHandler(this.widget.wikiList[index].pageId),
            child: Card(
              margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                    child: Text(
                      this.widget.wikiList[index].title,
                      style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context).textTheme.headline1),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 20.0),
                    child: Text(
                        this.widget.wikiList[index].desc == ""
                            ? "Tidak ada deskripsi"
                            : this.widget.wikiList[index].desc,
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

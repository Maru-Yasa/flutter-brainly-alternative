import 'package:brainly2/models/brainly.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/brainly_provider.dart';
import '../brainly_detail/brainly_detail.dart';

class BrainlyScreen extends StatefulWidget {
  @override
  _BrainlyScreenState createState() => _BrainlyScreenState();
}

class _BrainlyScreenState extends State<BrainlyScreen> {
  bool _isLoading = false;
  List timingsList = [];

  String question = "";
  List data = [];

  dataLoadFunction(String question) async {
    setState(() {
      _isLoading = true; // your loader has started to load
    });
    dynamic tempData = await BrainlyProvider.fetch(question);
    setState(() {
      this.data = tempData;
      this.question = question;
    });
    setState(() {
      _isLoading = false; // your loder will stop to finish after the data fetch
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text(
          "Brainly Alternative",
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextInputWidget(this.dataLoadFunction),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: Text(
                question.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ),
          this._isLoading
              ? Container(
                  margin: EdgeInsets.all(20.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListAnswerWidget(this.data)
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
            hintText: "Pertanyaan",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: this.onPresshandler,
            )),
      ),
    );
  }
}

class ListAnswerWidget extends StatefulWidget {
  List<dynamic> data;
  ListAnswerWidget(this.data);
  @override
  _ListAnswerWidgetState createState() => _ListAnswerWidgetState(this.data);
}

class _ListAnswerWidgetState extends State<ListAnswerWidget> {
  List data = [];
  _ListAnswerWidgetState(List data) {
    this.data = data;
  }

  void onTapHandler(Datum _data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BrainlyDetail(data: _data)));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 200.0,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTapHandler(this.data[index]),
                child: Card(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                        child: Text(
                          this.data[index].pertanyaan.toString().toUpperCase(),
                          style: GoogleFonts.montserrat(
                              textStyle: Theme.of(context).textTheme.headline1),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 15.0),
                        child: Text(
                          this.data[index].jawaban[0].text,
                          style: GoogleFonts.montserrat(
                              textStyle: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                      this.data[index].questionMedia.isEmpty
                          ? Container(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 15.0),
                              alignment: Alignment.topLeft,
                              child: this.data[index].jawaban[0].media.isEmpty
                                  ? null
                                  : Icon(Icons.image))
                          : Container(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 15.0),
                              alignment: Alignment.topLeft,
                              child: Icon(Icons.image),
                            ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

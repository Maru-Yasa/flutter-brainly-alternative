import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../models/brainly.dart';
import 'package:google_fonts/google_fonts.dart';

class BrainlyDetail extends StatefulWidget {
  final Datum data;

  BrainlyDetail({required this.data});

  @override
  _BrainlyDetailState createState() => _BrainlyDetailState(data);
}

class _BrainlyDetailState extends State<BrainlyDetail> {
  final Datum data;
  _BrainlyDetailState(this.data);

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
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: Text(
                this
                    .data
                    .pertanyaan
                    .toString()
                    .toUpperCase()
                    .replaceAll("\n", ""),
                style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline1),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: this.data.jawaban.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        this.data.questionMedia.isEmpty
                            ? Container()
                            : Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
                                child: Image.network(
                                  this.data.questionMedia[0],
                                ),
                                // child: Text(this.data.questionMedia[0]),
                              ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 5.0),
                          child: this.data.jawaban[index].text.contains("[tex]")
                              ? SelectableMath.tex(
                                  this.data.jawaban[0].text,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                )
                              : Text(
                                  this.data.jawaban[index].text,
                                  style: GoogleFonts.montserrat(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                        ),
                        this.data.jawaban[index].media.isEmpty
                            ? Container()
                            : Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                                child: Image.network(
                                    this.data.jawaban[index].media[0]),
                                // child: Text(this.data.questionMedia[0]),
                              ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

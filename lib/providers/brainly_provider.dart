import 'package:http/http.dart' as http;
import '../models/brainly.dart';

class BrainlyProvider {
  static final String apiURL =
      "https://brainly-no-ads.maruyasa.repl.co/api?question=";

  static Future fetch(String question) async {
    var uri = Uri.parse(apiURL + question);
    var response = await http.get(uri);
    String json = response.body.toString();
    final brainly = brainlyFromJson(json);
    return brainly.data;
  }
}

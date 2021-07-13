import 'package:http/http.dart' as http;
import '../models/wikipedia.dart';

class WikipediaProvider {
  static final String apiURL =
      "https://brainly-no-ads.maruyasa.repl.co/api/wikipedia?query=";

  static Future fetch(String question) async {
    var uri = Uri.parse(apiURL + question);
    var response = await http.get(uri);
    String json = response.body.toString();
    final wiki = wikipediaFromJson(json);
    return wiki.data;
  }
}

class WikipediaPageProvider {
  static final String apiURL =
      "https://brainly-no-ads.maruyasa.repl.co/api/wikipedia/page?id=";

  static Future fetch(String id) async {
    var uri = Uri.parse(apiURL + id);
    var response = await http.get(uri);
    String json = response.body.toString();
    final wiki = wikipediaPageFromJson(json);
    return wiki.data;
  }
}

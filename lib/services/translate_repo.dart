import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class Repo {
  Future<List<Sentence>> getTranslated(String target, String query);
}

class TranslateRepo extends Repo {
  StreamController<String> _translated = StreamController<String>();

  Stream<String> get translated => _translated.stream;

  String url =
      'https://translate.google.com/translate_a/single?client=at&dt=t&dt=ld&dt=qca&dt=rm&dt=bd&dj=1&hl=%25s&ie=UTF-8&oe=UTF-8&inputm=2&otf=2&iid=1dd3b944-fa62-4b55-b330-74909a99969e&';

  Map<String, String> header = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'User-Agent': 'AndroidTranslate/5.3.0.RC02.130475354-53000263 5.1 phone TRANSLATE_OPM5_TEST_1',
  };

  @override
  Future<List<Sentence>> getTranslated(String target, String query) async{
    var client = http.Client();
    Map<String, dynamic> body = {'sl': 'en', 'tl': target, 'q': query};
    try {
      final httpResponse = await client.post(url, headers: header, body: body);
      if (httpResponse.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        var response = httpResponse.body;

        _translated.add(response);

        var data = json.decode(response);
        var rest = data['sentences'] as List;

        var list = rest.map<Sentence>((json) => Sentence.fromJson(json)).toList();

        return list;
      } else {
        throw Exception('Failed to load post');
      }
    }finally {
      client.close();
    }
  }
}

class Translate {
  Sentence sentences;
  String dict;
  String src;

  Translate({this.sentences, this.dict, this.src});

  factory Translate.fromJson(Map<String, dynamic> json) {
    return Translate(
      sentences: Sentence.fromJson(json['sentences']),
      dict: json['dict'],
      src: json['src']
    );
  }
}

class Sentence {
  String trans;
  String orig;

  Sentence({this.trans, this.orig});

  factory Sentence.fromJson(Map<String, dynamic> json){
    return Sentence(
      trans: json['trans'],
      orig: json['orig']
    );
  }
}


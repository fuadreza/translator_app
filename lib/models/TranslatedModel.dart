
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
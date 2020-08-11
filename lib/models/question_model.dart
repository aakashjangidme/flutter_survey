
//Basic Model for App

class QuestionModel {
  int id;
  String questiontext;
  List<String> answertext;

  QuestionModel({this.id, this.questiontext, this.answertext});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questiontext = json['questiontext'];
    answertext = json['answertext'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questiontext'] = this.questiontext;
    data['answertext'] = this.answertext;
    return data;
  }
}
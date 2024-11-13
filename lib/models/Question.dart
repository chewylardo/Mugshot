import 'dart:convert';

class Question {
  final String titulo;
  int valor;
  final String min;
  final String max;

  Question({required this.titulo, required this.valor, required this.min, required this.max});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      titulo: json['titulo'],
      valor: json['valor'],
      min: json['min'],
      max: json['max'],
    );
  }
}

class QuestionCategory {
  final String name;
  final List<Question> questions;

  QuestionCategory({required this.name, required this.questions});

  factory QuestionCategory.fromJson(String name, List<dynamic> jsonList) {
    List<Question> questions = jsonList.map((q) => Question.fromJson(q)).toList();
    return QuestionCategory(name: name, questions: questions);
  }
}

List<QuestionCategory> parseJson(String jsonString) {
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);
  List<QuestionCategory> categories = [];
  
  jsonData.forEach((key, value) {
    categories.add(QuestionCategory.fromJson(key, value));
  });
  
  return categories;
}

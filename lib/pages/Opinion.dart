import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mugshot/models/ColorHelper.dart';
import 'package:mugshot/models/Question.dart';
import 'package:url_launcher/url_launcher.dart';

class OpinionScreen extends StatefulWidget {
  final List<QuestionCategory> categories;

  const OpinionScreen({required this.categories});

  @override
  _OpinionScreenState createState() => _OpinionScreenState();
}

class _OpinionScreenState extends State<OpinionScreen> {
  

  String compileSliderData(List<QuestionCategory> categories) {
    String result = "Survey Responses:\n\n";
    
    for (var category in categories) {
      result += "${category.name.toUpperCase()}:\n";
      for (var question in category.questions) {
        result += "${question.titulo}: ${question.valor}\n";
      }
      result += "\n";
    }

    return result;
  }

 

 sendEmail(String subject,String body, String recipientemail) async{
  final Email email = Email(

    body: body,
    subject: subject,
    recipients: [recipientemail],
    isHTML: false,

  );
  await FlutterEmailSender.send(email);

 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(title: const Text("Opinion Screen"), backgroundColor: ColorHelper.main,),
      body: SingleChildScrollView(  
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
     
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      ListView.builder(
                        shrinkWrap: true,  
                        physics: const NeverScrollableScrollPhysics(),  
                        itemCount: widget.categories.length,
                        itemBuilder: (context, categoryIndex) {
                          final category = widget.categories[categoryIndex];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.name.toUpperCase(),
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                ...category.questions.map((question) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(question.titulo, style: const TextStyle(fontSize: 16)),
                                   
                                      
                                       
                                          Text(question.min),
                                          Text(question.max),
                                     
                                      Slider(
                                        value: question.valor.toDouble(),
                                        min: 0,
                                        max: 5,
                                        divisions: 5,
                                        label: question.valor.toString(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            question.valor = newValue.toInt();
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    
                    String emailBody = compileSliderData(widget.categories);
                    
                    sendEmail('Respuesta', emailBody, 'chewylardo45@gmail.com');
                   
                  },
                  child: Text('Enviar respuestas'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

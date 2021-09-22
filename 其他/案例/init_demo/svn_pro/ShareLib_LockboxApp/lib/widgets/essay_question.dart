import 'package:flutter/material.dart';
import '../models/showing.dart';
import '../widgets/text_field.dart';



typedef EssayQuestionTextChange = void Function(String, List<String>);

class EssayQuestion extends StatefulWidget {

  final ShowingRequestSurveyQuestionsModel model;
  final EssayQuestionTextChange essayQuestionTextChange;
  EssayQuestion({this.model, this.essayQuestionTextChange});

  @override
  State<StatefulWidget> createState() {
    return EssayQuestionState();
  }

}

class EssayQuestionState extends State<EssayQuestion> {

  var _textkey = GlobalKey<TextInputFieldState>();

  String getText() => _textkey.currentState.text;

  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    var list = List<Widget>();
    list.add(
      Text(widget.model.QuestionSubject)
    );

    list.add(SizedBox(height: 10,));
    list.add(TextInputField( height: 130, maxLines: 6, key: _textkey, textInputFieldTextChanged: (text) {
      if(widget.essayQuestionTextChange != null) {
        widget.essayQuestionTextChange(widget.model.QuestionId.toString(), [text]);
      }
    },));

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list
      ),
    );
  }

  
}
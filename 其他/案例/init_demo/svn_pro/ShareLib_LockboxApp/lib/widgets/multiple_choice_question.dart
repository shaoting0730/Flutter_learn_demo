import 'package:flutter/material.dart';
import '../models/showing.dart';

typedef MultipleChoiceQuestionOnSelect = void Function(String, List<String> );
class MultipleChoiceQuestion extends StatefulWidget {

  final ShowingRequestSurveyQuestionsModel model;
  final MultipleChoiceQuestionOnSelect multipleChoiceQuestionOnSelect;
  MultipleChoiceQuestion({this.model, this.multipleChoiceQuestionOnSelect});

  @override
  State<StatefulWidget> createState() {
    return MultipleChoiceQuestionState();
  }

}

class MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {

  var status = [];
  @override
  void initState() {
    super.initState();

    for(int i = 0 ; i < widget.model.OptionList.length ; i ++) {
      status.add(0);
    }
  }

  List<String> getResult() {
    for(int i = 0 ; i < status.length; i ++) {
      if(status[i] == 1) {
        return [widget.model.OptionList[i].QuestionOptionId.toString()];
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    var list = List<Widget>();
    list.add(
      Text(widget.model.QuestionSubject)
    );

    list.add(SizedBox(height: 10,));
    for(int i = 0 ; i < widget.model.OptionList.length; i ++) {
      list.add(_buildOptionCheckBox(widget.model.OptionList[i], i));
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list
      ),
    );
  }

  Widget _buildOptionCheckBox(ShowingRequestSurveyQuestionOptionsModel option, int index) {
    return Container(
      height: 25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            activeColor: Color(0xFF536282),
            value: status[index] > 0,
            onChanged: (value) {
              setState(() {
                for(int i = 0 ; i < status.length; i ++) {
                  status[i] = 0;
                }
                status[index] = 1;

                if(widget.multipleChoiceQuestionOnSelect != null) {
                  widget.multipleChoiceQuestionOnSelect(widget.model.QuestionId.toString(), getResult());
                }
              });
            },
          ), 
          Text(option.QuestionOption.trim(), style: TextStyle(color: Color(0xFF3A3A3A), fontSize: 14),)
        ]
      ),
    );
  }

  
}
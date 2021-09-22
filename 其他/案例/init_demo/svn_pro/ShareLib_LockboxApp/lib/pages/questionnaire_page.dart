import 'package:flutter/material.dart';
import '../models/showing.dart';
import '../models/ui/plan_model.dart';
import '../pages/questionnaire_success_page.dart';
import '../service/serviceapi.dart';
import '../widgets/essay_question.dart';
import '../widgets/house_card.dart';
import '../widgets/multiple_choice_question.dart';
import '../widgets/shadow_decoration.dart';
import 'base_page.dart';


typedef QuestionnairePageSuccess = void Function();

class QuestionnairePage extends BasePage {

  final ShowingRequestModel model;
  final QuestionnairePageSuccess questionnairePageSuccess;

  QuestionnairePage({this.model, this.questionnairePageSuccess});
  
  @override
  State<StatefulWidget> createState() {
    
    return QuestionnairePageState();
  }

}

class QuestionnairePageState extends BasePageState<QuestionnairePage> {

  ShowingRequestSurveyModel surveyModel;

  var result = <String, List<String>>{};

  @override
  void initState() {
    super.initState();

    title = "Questionnaire";

    requestQuestion();
  }

  @override
  Widget pageContent(BuildContext context) {

    if(surveyModel == null) {
      return Container();
    }

    var houseModel = ShowingRequestModelToPlanModel( widget.model).house;

    var list = List<Widget>();
    list.add(_buildHouseCard(houseModel));
    list.add(_buildQuestion());
    list.add(SizedBox(height: 40,));
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child:SingleChildScrollView(
              child: Column(
                children: list
              ),
            )
          ),

          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: AlignmentDirectional.center,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildActionButton("Cancel", false),
                  _buildActionButton("Submit", true),
                ]
              )
            )
          )
        ]
      )
      
    );
  }

  void requestQuestion() async {
    displayProgressIndicator(true);
    var result = await UserServerApi().GetSurveyQuestions(context, widget.model.Guid);
    displayProgressIndicator(false);

    if(result != null) {
      setState(() {
        surveyModel = result;
      });
    }
  }

  Widget _buildHouseCard(HouseModel model) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      width: double.infinity,
      decoration: shadowDecoration(),
      child: HouseCard(model: model, displayFavorite: false,),
    );
  }

  Widget _buildQuestion() {
    var list = List<Widget>();
    list.add(Text("We would really appreciate your client's feedback. Please fill in the form below and add any additional comments you may have. Thank you in advance!", style: TextStyle(fontSize: 14),));
    for(int i = 0; i < surveyModel.QuestionList.length ; i ++ ) {
      var question = surveyModel.QuestionList[i];
      list.add(SizedBox(height: 10,));
      list.add(Container(
        height: 1,
        color: Colors.black.withAlpha(60),
      ));
      list.add(SizedBox(height: 10,));
      list.add(_buildQuestionPart(question));
    }

    return Container(
      decoration: shadowDecoration(),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: list
      )
      
    );  
  }

  Widget _buildQuestionPart(ShowingRequestSurveyQuestionsModel question) {
    if(question.QuestionType == 3) {
      return EssayQuestion(model: question, essayQuestionTextChange: (questionId, text) {
        result[questionId] = text;
      },);
    } else {
      return MultipleChoiceQuestion(model: question, multipleChoiceQuestionOnSelect: (questionId, list) {
        result[questionId] = list;
      },);
    }
  }

  Widget _buildActionButton(String text, bool fill) {
    Color color = fill ? Colors.red: Colors.white;
    Color textColor = fill ? Colors.white:Colors.red;
    return SizedBox(
      width: 150,
      child: RaisedButton(
        child: Text(text),
        onPressed: () {
          if(text == "Cancel") {
            Navigator.pop(context);
          } else if(text == "Submit") {
            _onTapSubmit();
          }
        },
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.red,)
        )
      ),
    );
  }

  void _onTapSubmit() async {
    if(result.length < surveyModel.QuestionList.length) {
      showErrorMessage(context, "Please fill all question");
      return;
    }

    displayProgressIndicator(true);
    var requset = ShowingRequestSurveyAnswerModel(QuestionAnswers: result, ShowingRequestSurveyGuid: surveyModel.Guid);
    var response = await UserServerApi().UpdateShowingRequestSurvey(context, requset);
    if(response) {
      if(widget.questionnairePageSuccess != null) {
        widget.questionnairePageSuccess();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionnaireSuccessPage()));
    }
    

  }
}
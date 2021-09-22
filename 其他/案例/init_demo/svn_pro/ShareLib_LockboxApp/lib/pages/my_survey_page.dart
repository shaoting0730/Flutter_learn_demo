import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import '../service/scheduled_service.dart';
import '../widgets/house_card.dart';
import '../widgets/shadow_decoration.dart';
import 'base_page.dart';
import './questionnaire_page.dart';

class MySurveyPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return MySurveyPageState();
  }

}

class MySurveyPageState extends BasePageState<MySurveyPage> {
  @override
  void initState() {
    super.initState();

    title = "My Survey";
  }

  @override
  Widget pageContent(BuildContext context) {
    return ListView.builder(
      itemCount: gSurveys.length,
      itemBuilder: (BuildContext context, int index) {

        var survey = gSurveys[index];
        var houseModel = ShowingRequestModelToPlanModel( survey).house;
        return InkWell(
          child: _buildHouseCard(houseModel),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionnairePage(model: survey, questionnairePageSuccess: (){
              setState(() {
                gSurveys.remove(survey);  
              });
            },)));
          },
        );
      }
    );
  }


  Widget _buildHouseCard(HouseModel model) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      width: double.infinity,
      decoration: shadowDecoration(),
      child: HouseCard(model: model, showQuestionnaire: true, displayFavorite: false,),
    );
  }

}
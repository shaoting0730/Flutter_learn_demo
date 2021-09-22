import 'package:flutter/material.dart';
import '../widgets/fast_pass_item.dart';
import './my_houses_page.dart';
import './my_favorite_page.dart';
import './my_lockers_page.dart';
import './search_page.dart';
import './message_page.dart';
import './my_plans_page.dart';
import './my_clients_page.dart';
import './settings_page.dart';
import '../service/scheduled_service.dart';
import '../service/baseapi.dart';
import '../pages/my_survey_page.dart';

class FastPassPage extends StatefulWidget {

  final int messageBadge;
  final String fromPageTitle;
  FastPassPage({this.messageBadge=0, this.fromPageTitle = ""});

  @override
  State<FastPassPage> createState() {
    return FastPassPageState();
  }
  
}


FastPassPageState gFastPassPage;

void updateFastPassPageMessageCount(int badge) {
  if(gFastPassPage != null) {
    gFastPassPage.updateMessageBadge(badge);
  }
}


class FastPassPageState extends State<FastPassPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'my_lockbox':"My Lockbox",
      'fast_pass':'Fast pass',
      'setting':'Setting',
    },
    'zh': {
      'my_lockbox':"我的锁盒",
      'fast_pass':'功能直达',
      'setting':'设置',
    },
  };
  int _badge;

  @override
  void initState() {
    super.initState();

    _badge = gUnreadMessageCount;
  }

  void updateMessageBadge(int badge) {
    setState(() {
      _badge = badge;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> visiblePages = List<Widget>();
    if(isAgent || isHouseOwner || isAgentAssistant)
    {
      visiblePages.add(GestureDetector(
        onTap: () {
          Navigator.pop(context);
          if(widget.fromPageTitle != "Find a home") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
          }
        },
        child: FastPassItem(icon: Image.asset('assets/fast_pass_search.png'), title: 'Search'),
      ));
    }
    
    if(isAgent)
    {

      visiblePages.add(GestureDetector(
        onTap: () {
          while(Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyPlansPage(pageIndex:0)));
        },
        child: FastPassItem(icon: Image.asset('assets/fast_pass_upcoming.png'), title: 'My Request'),
      ));
    }
    if(isAgent || isHouseOwner || isAgentAssistant)
    {
      visiblePages.add(GestureDetector(
        onTap: () {
          Navigator.pop(context);
          if(widget.fromPageTitle != "My Listing") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHousesPage()));
          }
        },
        child: FastPassItem(icon: Image.asset('assets/fast_pass_myhome.png'), title: 'My Listing'),
      ));
    }
    if(isAgent || isAgentAssistant || isHouseOwner)
    {
      visiblePages.add(GestureDetector(
        onTap: () {
          Navigator.pop(context);
          if(widget.fromPageTitle != "Message") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage()));
            updateUnreadMessageCount(0);
            setState(() {
              _badge = 0;
            });
          }
        },
        child: FastPassItem(icon: Image.asset('assets/fast_pass_message.png'), title: 'Message', badge: _badge),
      ));
    }
    if(isAgent || isHouseOwner || isAgentAssistant)
    {
      visiblePages.add(GestureDetector(
        onTap: () {
          Navigator.pop(context);
          if (widget.fromPageTitle != "My Favorite") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyFavoritePage()));
          }
        },
        child: FastPassItem(icon: Image.asset('assets/fast_pass_myllike.png'),
            title: 'My Favorite'),
      ));
    }
    if(isAgent)
    {
      visiblePages.add(GestureDetector(
          onTap: () {
            Navigator.pop(context);
            if(widget.fromPageTitle != "My Clients") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyClientsPage()));
            }
          },
          child: FastPassItem(icon: Image.asset('assets/fast_pass_myclients.png'), title: 'My Clients')
      ));

      if(gSurveys != null && !isOnlyForPerson) {
        visiblePages.add(GestureDetector(
          onTap: () {
            Navigator.pop(context);
            if(widget.fromPageTitle != "My Survey") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MySurveyPage()));
            }
          },
          child: FastPassItem(icon: Image.asset('assets/iocn_my_servey.png'), title: 'My Survey', badge: gSurveys.length),
        ));
      }
    }

    /*
    if(isAgent || isAgentAssistant || isHouseOwner)
    {
      visiblePages.add(GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForLockerPage()));
        },
        child: FastPassItem(icon: Image.asset('assets/fast_pass_applylock.png'), title: 'Apply Locker'),

      ));
    }
    */
    visiblePages.add(GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if(widget.fromPageTitle != _localizedValues[getLocaleCode()]["my_lockbox"]) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyLockersPage()));
        }
        
      },
      child: FastPassItem(icon: Image.asset('assets/fast_pass_mylock.png'), title: _localizedValues[getLocaleCode()]["my_lockbox"]),

      ));
    visiblePages.add(GestureDetector(
    onTap: () {
      Navigator.pop(context);
      if(widget.fromPageTitle != _localizedValues[getLocaleCode()]["setting"]) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
      }
    },
    child: FastPassItem(icon: Image.asset('assets/fast_pass_settings.png'), title: _localizedValues[getLocaleCode()]["setting"]),
    ));


    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child:Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
              decoration: BoxDecoration(
                color: Color(0xBB000000),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              height: 450,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Material(child: Text(_localizedValues[getLocaleCode()]["fast_pass"], style: TextStyle(fontSize: 16, color: Colors.white)), color:Colors.transparent)
                  ),
                  Container(
                    height: 350,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GridView.count (
                      childAspectRatio: 1.3,
                      crossAxisSpacing: .0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 3,
                      children: visiblePages,
                    )
                  )
                ]
              )
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
              ),
            )
          ],
        )
      )
    );
  }

}
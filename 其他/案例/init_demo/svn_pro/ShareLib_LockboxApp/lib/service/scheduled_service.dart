import 'dart:async';
import '../service/baseapi.dart';

import './serviceapi.dart';
import '../pages/my_plans_page.dart';
import '../pages/fast_pass_page.dart';
import '../models/showing.dart';

int gUnreadMessageCount = 0;
int gUnreadApprovalMessage = 0;
int gUnreadRequstMessage = 0;

PagedListShowingProfileModel gShowingProfiles = null;
List<ShowingRequestModel> gSurveys = null;

void startScheduledTimer() async {
  await sheduleCheckingMessage();
  await scheduleClientList();
  await scheduleCheckingSurveys();

  Timer.periodic(Duration(seconds: 10), (timer) async {
    print("Yeah, 10 seconds schedule task running....");

    // 
    await sheduleCheckingMessage();


    ///await scheduleUpdateUserInformation();
  });

  Timer.periodic(Duration(seconds: 60), (timer) async {
    print("Yeah, 60 seconds schedule task running....");

    await scheduleCheckingSurveys();
    
    // 
    await scheduleClientList();

    
  });

  
}

Future<void> scheduleCheckingSurveys() async {
  gSurveys = await UserServerApi().GetIncompleteSurveys();
  print(gSurveys);
}

Future<void> sheduleCheckingMessage() async {
  var badge = await UserServerApi().LoadMyBadgeDisplay();
  if(badge != null) {
    gUnreadMessageCount = badge.UnreadMessage;
    gUnreadApprovalMessage = badge.UnreadApprovalMessage;
    gUnreadRequstMessage = badge.UnreadRequestMessage;
    updateUnreadMessageCount(gUnreadMessageCount);
  }
}

Future<void> scheduleClientList() async {
  var showingRequestScheduler = await UserServerApi().SearchProfiles(null, ShowingProfileSearch(PageIndex: 0, PageSize: 1000));
  if(showingRequestScheduler != null) {
    gShowingProfiles = showingRequestScheduler;
  }
}


void updateUnreadMessageCount(int count) {
  gUnreadMessageCount = count;
  updateMyPlanMessageCount(count);
  updateFastPassPageMessageCount(count);
}


Future<void> scheduleUpdateUserInformation() async {
  if(loginResponse != null) {
    await UserServerApi().RefreshMyLogin(true);
  }
}
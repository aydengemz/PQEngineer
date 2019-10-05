import 'package:flutter/material.dart';

import './ai/ai_page.dart';
import './iot/iot_page.dart';
import './webrtc/src/call_sample/call_sample.dart';
import 'account/account_page.dart';
import 'cupertino_home_scaffold.dart';
import 'tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.iot;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.iot: GlobalKey<NavigatorState>(),
    TabItem.ai: GlobalKey<NavigatorState>(),
    TabItem.ar: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.iot: (_) => IoTPage(),
      TabItem.ai: (_) => AIPage(),
      TabItem.ar: (_) => CallSample(ip: '192.168.86.36'),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}

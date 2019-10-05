import 'package:flutter/material.dart';

enum TabItem { inspect, help, account }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.inspect: TabItemData(title: 'Inspect', icon: Icons.info),
   // TabItem.ai: TabItemData(title: 'AI', icon: Icons.view_headline),
    TabItem.help: TabItemData(title: 'Help', icon: Icons.help_outline),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}

import 'package:flutter/material.dart';

enum TabItem { iot, ai, ar, account }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.iot: TabItemData(title: 'IoT', icon: Icons.work),
    TabItem.ai: TabItemData(title: 'AI', icon: Icons.view_headline),
    TabItem.ar: TabItemData(title: 'AR', icon: Icons.view_headline),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}

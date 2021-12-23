import 'package:flutter/material.dart';
import 'package:house_rental/pages/home/tab_index/tab_index.dart';
import 'package:house_rental/pages/home/tab_info/index.dart';
import 'package:house_rental/pages/home/tab_profile/index.dart';
import 'package:house_rental/pages/home/tab_search/index.dart';
import 'package:house_rental/widgets/page_content.dart';

List<Widget> tabViewList=[
  TabIndexPage(),
  Tabsearch(),
  TabInfo(),
  TabProfile(),
  PageContent(name:"我的"),
];

const List<BottomNavigationBarItem> barItemList=[
  BottomNavigationBarItem(title: Text('首页'),icon:Icon(Icons.home)),
  BottomNavigationBarItem(title: Text('搜索'),icon:Icon(Icons.search)),
  BottomNavigationBarItem(title: Text('咨询'),icon:Icon(Icons.info)),
  BottomNavigationBarItem(title: Text('我的'),icon:Icon(Icons.home)),
];

class HomePage extends StatefulWidget {

  const HomePage({Key key}): super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tabViewList[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: barItemList,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

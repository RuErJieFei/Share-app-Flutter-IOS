import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_app/page/share_page.dart';
import 'package:share_app/page/contribute_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// 禁止屏幕旋转
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(CupertinoStoreApp());
  });
}

class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      /// 去掉右上角标签
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemRed,
      ),
      home: CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatefulWidget {
  CupertinoStoreHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CupertinoStoreHomePageState createState() => _CupertinoStoreHomePageState();
}

class _CupertinoStoreHomePageState extends State<CupertinoStoreHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('首页'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              title: Text('投稿'),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
//                  navigationBar: CupertinoNavigationBar(
//                    middle: const Text('Cupertino Store'),
//                  ),
                  child: SharePage(),
                );
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: ContributePage(),
                );
              });
          }
          return null;
        },
      ),
    );
  }
}

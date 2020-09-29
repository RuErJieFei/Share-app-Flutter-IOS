import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_app/model/user_model.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User _user;

  getUser() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get("http://localhost:8081/users/me/1");
    Map<String, dynamic> map = Map<String, dynamic>.from(response.data);
    setState(() {
      _user = User.fromJson(map);
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('我的'),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 110, 20, 0),
            sliver: SliverToBoxAdapter(
              child: _user == null
                  ? Container()
                  : Column(
                      children: <Widget>[
                        ClipOval(
                          child: Image.network(
                            _user.avatarUrl,
                            height: 120,
                            width: 120,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _user.wxNickname,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 50,
                          height: 32,
                          child: CupertinoButton(
                            padding: EdgeInsets.all(0),
                            color: CupertinoColors.activeGreen,
                            onPressed: () {},
                            child: Text(
                              "签到",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("我的兑换"),
                                CupertinoButton(
                                  onPressed: () {},
                                  child: Icon(CupertinoIcons.right_chevron),
                                )
                              ],
                            ),
                            Divider(
                              height: 1,
                              thickness: 0.2,
                              color: CupertinoColors.white,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("积分明细"),
                                CupertinoButton(
                                  onPressed: () {},
                                  child: Icon(CupertinoIcons.right_chevron),
                                )
                              ],
                            ),
                            Divider(
                              height: 1,
                              thickness: 0.2,
                              color: CupertinoColors.white,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("我的投稿"),
                                CupertinoButton(
                                  onPressed: () {},
                                  child: Icon(CupertinoIcons.right_chevron),
                                )
                              ],
                            ),
                            Divider(
                              height: 1,
                              thickness: 0.2,
                              color: CupertinoColors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_app/http/http_util.dart';
import 'package:share_app/model/share_model.dart';
import 'package:share_app/page/contribute_page.dart';
import 'package:share_app/page/user_page.dart';

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  ScrollController _scrollController;

  /// 改变标题用户显示
  bool _changeTitle = true;

  /// 点击用户高亮
  bool _userAlive = true;

  /// 投稿列表
  List<Share> _list = [];

  int count = 0;

  getShare() {
    HttpUtil.request("http://123.57.51.43:8086/shares/find/share", {
      "pageSize": 10,
      "pageIndex": 0,
    }, (code, msg, data) {
      if (code == 0) {
        List<Share> list = [];
        List.from(data).forEach((element) {
          list.add(Share.fromJson(element));
        });
        setState(() {
          _list = list;
        });
      } else {}
    }, (error) => null);
  }

  @override
  void initState() {
    super.initState();

    /// 初始化控制器
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset < 38) {
        setState(() {
          _changeTitle = true;
        });
      } else {
        setState(() {
          _changeTitle = false;
        });
      }
      if (_scrollController.offset > 400) {
        count++;
        HttpUtil.request("http://123.57.51.43:8086/shares/find/share", {
          "pageSize": 10,
          "pageIndex": 1,
        }, (code, msg, data) {
          if (code == 0) {
            setState(() {
              List.from(data).forEach((element) {
                _list.add(Share.fromJson(element));
              });
            });
          }
        }, (error) => null);
      }
    });

    /// 获取数据
    getShare();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          /// 而长的有大标题且可滑动
          CupertinoSliverNavigationBar(
            largeTitle: Row(
              mainAxisAlignment: _changeTitle
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '发现',
                ),
                _changeTitle
                    ? GestureDetector(
                        child: Icon(
                          CupertinoIcons.profile_circled,
                          size: 40,
                          color: _userAlive
                              ? CupertinoColors.systemRed
                              : Color.fromARGB(100, 235, 77, 61),
                        ),
                        onTapUp: (detail) {
                          setState(() {
                            _userAlive = !_userAlive;
                          });
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (_) => UserPage(),
                                fullscreenDialog: true),
                          );
                        },
                        onTapDown: (detail) {
                          setState(() {
                            _userAlive = !_userAlive;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            _userAlive = !_userAlive;
                          });
                        },
                      )
                    : Container(),
              ],
            ),
//          leading: Icon(CupertinoIcons.back),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              getShare();
            },
          ),

          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((content, index) {
                Share share = _list[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                child: Image.network(
                                  share.cover,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 70,
                                width: 170,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      share.title,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      share.summary,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(share.price.toString()),
                              CupertinoButton(
                                onPressed: () {},
                                child: Text("下载"),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        height: 20,
                        thickness: 0.2,
                        color: CupertinoColors.white,
                      ),
                    ],
                  ),
                );
              }, childCount: _list.length),
            ),
          )
        ],
      ),
    );
  }
}

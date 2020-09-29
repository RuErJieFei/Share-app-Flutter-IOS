import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_app/http/http_util.dart';
import 'package:share_app/util/toast.dart';
import 'package:toast/toast.dart';

class ContributePage extends StatefulWidget {
  @override
  _ContributePageState createState() => _ContributePageState();
}

class _ContributePageState extends State<ContributePage> {
  TextEditingController _titleController;
  TextEditingController _authorController;
  TextEditingController _priceController;
  TextEditingController _summaryController;
  TextEditingController _downloadController;
  bool _isCheckedFromOwn = false;
  bool _isCheckedFromOther = false;

  contribute() {
    HttpUtil.request("http://123.57.51.43:8086/shares/contribute", {
      "userId": 1,
      "author": "1sadasda",
      "downloadUrl": _downloadController.text,
      "isOriginal": _isCheckedFromOwn ? 0 : 1,
      "price": _priceController.text,
      "summary": _summaryController.text,
      "title": _titleController.text,
      "cover": _downloadController.text
    }, (code, msg, data) {
      ToastUtil.showToast(
        context,
        "投稿成功",
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
      _titleController.text = "";
      _authorController.text = "";
      _priceController.text = "";
      _summaryController.text = "";
      _downloadController.text = "";
      if (code == 0) {}
    }, (error) => null);
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: "");
    _authorController = TextEditingController(text: "");
    _priceController = TextEditingController(text: "");
    _summaryController = TextEditingController(text: "");
    _downloadController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text("投稿"),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Text("提示信息"),
                GestureDetector(
                  child: Container(
                    color: CupertinoColors.black,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "原创",
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(),
                            CupertinoButton(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _isCheckedFromOwn
                                          ? CupertinoColors.systemRed
                                          : CupertinoColors.white,
                                      border: Border.all(
                                          color: CupertinoColors.systemGrey,
                                          style: BorderStyle.solid,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Icon(CupertinoIcons.check_mark,
                                      size: 22,
                                      color: _isCheckedFromOwn
                                          ? CupertinoColors.white
                                          : CupertinoColors.systemGrey),
                                ),
                                onPressed: () {
                                  if (_isCheckedFromOwn == true) {
                                    _isCheckedFromOwn = false;
                                  }

                                  setState(() {
                                    _isCheckedFromOwn = !_isCheckedFromOwn;
                                  });
                                }),
                          ],
                        ),
                        Divider(
                          thickness: 0.2,
                          color: CupertinoColors.white,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (_isCheckedFromOther == true) {
                      _isCheckedFromOther = false;
                    }

                    setState(() {
                      _isCheckedFromOwn = !_isCheckedFromOwn;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    color: CupertinoColors.black,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "转载",
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(),
                            CupertinoButton(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _isCheckedFromOther
                                          ? CupertinoColors.systemRed
                                          : CupertinoColors.white,
                                      border: Border.all(
                                          color: CupertinoColors.systemGrey,
                                          style: BorderStyle.solid,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Icon(CupertinoIcons.check_mark,
                                      size: 22,
                                      color: _isCheckedFromOther
                                          ? CupertinoColors.white
                                          : CupertinoColors.systemGrey),
                                ),
                                onPressed: () {
                                  if (_isCheckedFromOwn == true) {
                                    _isCheckedFromOwn = false;
                                  }

                                  setState(() {
                                    _isCheckedFromOther = !_isCheckedFromOther;
                                  });
                                }),
                          ],
                        ),
                        Divider(
                          thickness: 0.2,
                          color: CupertinoColors.white,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (_isCheckedFromOwn == true) {
                      _isCheckedFromOwn = false;
                    }

                    setState(() {
                      _isCheckedFromOther = !_isCheckedFromOther;
                    });
                  },
                ),
                input("标题", "请输入标题", _titleController),
                input("作者", "请输入作者", _authorController),
                input("价格", "请输入价格", _priceController),
                input("简介", "介绍一下技术干货吧", _summaryController),
                input("下载地址", "请输入下载地址", _downloadController),
                SizedBox(
                  height: 20,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                    minWidth: 400,
                  ),
                  child: CupertinoButton(
                    onPressed: () {
                      contribute();
                    },
                    child: Text(
                      "提交",
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    color: CupertinoColors.systemRed,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget input(title, placeholder, controller) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Container(
              width: 240,
              height: 50,
              child: CupertinoTextField(
                controller: controller,
                placeholder: placeholder,
                style: TextStyle(fontSize: 16),
                decoration: BoxDecoration(
                  border: null,
                ),
              ),
            )
          ],
        ),
        Divider(
          height: 10,
          thickness: 0.2,
          color: CupertinoColors.white,
        ),
      ],
    );
  }
}

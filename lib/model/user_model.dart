class User {
  int id;
  String wxId;
  String wxNickname;
  String roles;
  String avatarUrl;
  String createTime;
  String updateTime;
  int bonus;

  User(
      {this.id,
      this.wxId,
      this.wxNickname,
      this.roles,
      this.avatarUrl,
      this.createTime,
      this.updateTime,
      this.bonus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wxId = json['wxId'];
    wxNickname = json['wxNickname'];
    roles = json['roles'];
    avatarUrl = json['avatarUrl'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wxId'] = this.wxId;
    data['wxNickname'] = this.wxNickname;
    data['roles'] = this.roles;
    data['avatarUrl'] = this.avatarUrl;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['bonus'] = this.bonus;
    return data;
  }
}

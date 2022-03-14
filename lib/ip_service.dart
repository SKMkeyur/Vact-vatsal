// To parse this JSON data, do
//
//     final ip = ipFromJson(jsonString);

import 'dart:convert';

Ip ipFromJson(String str) => Ip.fromJson(json.decode(str));

String ipToJson(Ip data) => json.encode(data.toJson());

class Ip {
  Ip({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory Ip.fromJson(Map<String, dynamic> json) => Ip(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.ip,
    this.newsId,
    this.userId
  });

  String id;
  String ip;
  String newsId;
  String userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    ip: json["ip"],
    newsId: json["news_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ip": ip,
    "news_id": newsId,
    "user_id": userId,
  };
}

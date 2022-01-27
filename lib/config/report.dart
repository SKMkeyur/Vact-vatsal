class Report {
  final String name, image, description, id, postName, datetime, userId;
  Report({
    this.id,
    this.name,
    this.image,
    this.description,
    this.postName,
    this.datetime,
    this.userId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json["id"],
      name: json["name"],
      postName: json["postName"],
      image: json["image"],
      description: json["description"],
      datetime: json["datetime"],
      userId: json["userId"],
    );
  }
}

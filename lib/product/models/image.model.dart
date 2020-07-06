class ImageModel {
  String id;
  String url;
  ImageModel({this.id, this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json["id"],
      url: json['url'],
    );
  }
  toJson() {
    return {"id": id, "url": url};
  }
}

class ImageModel {
  String id;
  String url;
  ImageModel({this.id, this.url});
  toJson() {
    return {"id": id, "url": url};
  }
}

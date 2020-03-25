class TwoModel {
  List<Data> data;
  int status;

  TwoModel({this.data, this.status});

  TwoModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String image;
  String title;
  String url;

  Data({this.image, this.title, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class GirlsList {
  String? sId = '';
  String? author = '';
  String? category = '';
  String? createdAt = '';
  String? desc = '';
  List<String>? images = [];
  int? likeCounts = 0;
  String? publishedAt = '';
  int? stars = 0;
  String? title = '';
  String? type = '';
  String? url = '';
  int? views = 0;

  GirlsList(
      {this.sId,
      this.author,
      this.category,
      this.createdAt,
      this.desc,
      this.images,
      this.likeCounts,
      this.publishedAt,
      this.stars,
      this.title,
      this.type,
      this.url,
      this.views});

  GirlsList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    category = json['category'];
    createdAt = json['createdAt'];
    desc = json['desc'];
    images = json['images'].cast<String>();
    likeCounts = json['likeCounts'];
    publishedAt = json['publishedAt'];
    stars = json['stars'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['author'] = author;
    data['category'] = category;
    data['createdAt'] = createdAt;
    data['desc'] = desc;
    data['images'] = images;
    data['likeCounts'] = likeCounts;
    data['publishedAt'] = publishedAt;
    data['stars'] = stars;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    data['views'] = views;
    return data;
  }
}

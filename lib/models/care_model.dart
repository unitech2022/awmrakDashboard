class Care {
  int? id;
  String? name;
  String? image;
  String? desc;
  Care({this.id, this.name, this.image,this.desc});

  Care.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['desc']=desc;
    return data;
  }
}
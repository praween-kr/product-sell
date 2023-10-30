class CmsModel {
  int? id;
  String? accessor;
  String? title;
  String? content;
  int? created;
  int? updated;
  String? createdAt;
  String? updatedAt;

  CmsModel(
      {this.id,
      this.accessor,
      this.title,
      this.content,
      this.created,
      this.updated,
      this.createdAt,
      this.updatedAt});

  CmsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessor = json['accessor'];
    title = json['title'];
    content = json['content'];
    created = json['created'];
    updated = json['updated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accessor'] = accessor;
    data['title'] = title;
    data['content'] = content;
    data['created'] = created;
    data['updated'] = updated;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

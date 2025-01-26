class InitData {
  InitData({
    String? data,
  }) {
    _data = data;
  }

  InitData.fromJson(dynamic json) {
    _data = json['data'];
  }

  String? _data;

  InitData copyWith({
    String? data,
  }) =>
      InitData(
        data: data ?? _data,
      );

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    return map;
  }
}

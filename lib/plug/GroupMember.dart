import 'dart:convert';

class GroupMember {
  // type or name of the group
  final String type;

  // index of the the group member within the group
  final int index;

  GroupMember.first(String type) : this(type, 0);

  GroupMember(this.type, this.index);

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'index': index,
    };
  }

  factory GroupMember.fromMap(Map<String, dynamic> map) {
    return GroupMember(
      map['type'],
      map['index'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupMember.fromJson(String source) =>
      GroupMember.fromMap(json.decode(source));

  @override
  String toString() => 'GroupMember(type: $type, index: $index)';
}

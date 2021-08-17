import 'dart:convert';

class GroupMember {
  // type or name of the group
  final String name;

  // index of the the group member within the group
  final int index;

  GroupMember.first(String name) : this(name, 0);

  GroupMember(this.name, this.index);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'index': index,
    };
  }

  factory GroupMember.fromMap(Map<String, dynamic> map) {
    return GroupMember(
      map['name'],
      map['index'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupMember.fromJson(String source) =>
      GroupMember.fromMap(json.decode(source));

  @override
  String toString() => 'GroupMember(name: $name, index: $index)';
}

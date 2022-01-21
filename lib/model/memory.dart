part of plugs;

class Memory {
  ///
  final String address;

  ///
  final int total;

  //
  final int free;

  //
  final Header header;

  // content
  final dynamic content;

  Memory(this.address, this.total, this.free, this.header, this.content);

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'total': total,
      'free': free,
      'header': header.toMap(),
      'content': content,
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      map['address'] ?? '',
      map['total']?.toInt() ?? 0,
      map['free']?.toInt() ?? 0,
      Header.fromMap(map['header']),
      map['content'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Memory.fromJson(String source) => Memory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Memory(address: $address, total: $total, free: $free, header: $header, content: $content)';
  }
}

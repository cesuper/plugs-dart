abstract class AinSnapshot {
  // timestamp of the snapshot, when data is created
  final int ts;

  // plug serial from where the snapshot is originated
  final String plug;

  //
  AinSnapshot(this.ts, this.plug);

  @override
  String toString() => 'AinSnapshot(ts: $ts, plug:$plug)';
}

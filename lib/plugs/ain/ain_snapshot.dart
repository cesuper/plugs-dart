abstract class AinSnapshot {
  // timestamp of the snapshot, when data is created
  final int ts;

  //
  AinSnapshot(this.ts);

  @override
  String toString() => 'AinSnapshot(ts: $ts)';
}

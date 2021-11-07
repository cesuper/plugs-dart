import 'ain.dart';
import 'ain_snapshot.dart';

abstract class AinBuffered extends Ain {
  /// Returns the last buffered snapshot
  Future<AinSnapshot> get bufferedSnapshot;

  /// Starts buffered sampling
  Future<void> buffer();
}

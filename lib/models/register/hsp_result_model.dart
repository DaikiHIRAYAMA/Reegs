class HspResult {
  final int hspCount;
  final int result;

  HspResult({required this.hspCount}) : result = hspCount >= 14 ? 1 : 0;
}

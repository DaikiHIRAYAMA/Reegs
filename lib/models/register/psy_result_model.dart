class PsyResult {
  final int psyCount;
  final int result;

  PsyResult({required this.psyCount}) : result = psyCount >= 5 ? 1 : 0;
}

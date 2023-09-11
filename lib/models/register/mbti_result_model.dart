class MbtiResult {
  int eiTotal;
  int nsTotal;
  int ftTotal;
  int jpTotal;

  MbtiResult({
    required this.eiTotal,
    required this.nsTotal,
    required this.ftTotal,
    required this.jpTotal,
  });

  String computeResult(
      {required int eiTotal,
      required int nsTotal,
      required int ftTotal,
      required int jpTotal}) {
    final eiResult = eiTotal >= 0 ? 'E' : 'I';
    final nsResult = nsTotal >= 0 ? 'S' : 'N';
    final ftResult = ftTotal >= 0 ? 'F' : 'T';
    final jpResult = jpTotal >= 0 ? 'J' : 'P';
    return eiResult + nsResult + ftResult + jpResult;
  }
}

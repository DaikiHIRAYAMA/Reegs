class SociopathModel {
  final int result;

  SociopathModel(this.result);

  String get description {
    switch (result) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
        return '「ソシオパスの傾向はありません」';
      case 5:
      case 6:
      case 7:
        return '「ソシオパスの傾向がある」といえますが、仕事や私生活において、大きな影響を及ぼす程ではありません。普段の自身の行動を定期的に振り返るなどして、自分の言動や行動を改善していく事で、私生活において良好な人間関係を築く事ができる様になります。';
      case 8:
      case 9:
        return '「ソシオパス度がかなり高い方」だといえます。この数が当てはまる方は、普段の生活の中で、自分では気づかないうちに仕事でトラブルを起こしてしまっていたり、周囲の人を傷つけてしまう事があります。周りの信頼のおける人に自分自身の性格について話すなどし、理解を得るとともに、気づいた点などを随時指摘してもらうなど、改善を繰り返す事で周囲とのトラブルを少しずつ減らしていく様、心掛けましょう。';
      case 10:
        return '「ソシオパス度が非常に強い」といえます。周囲と良好な人間関係を構築するのは非常に難しく、仕事で大きなトラブルを起こしてしまったり、悪気はなくても時に相手を深く傷つけてしまったり、という事が多く起こる可能性があります。そして、周囲のそんな反応にも自分自身は不感である為、自分自身を改めようという感覚すらありません。';
      default:
        return '判断できませんでした';
    }
  }
}

class JurosCompostos {
  static List<double> calcularEvolucao({
    required double capitalInicial,
    required double aplicacaoMensal,
    required double taxaJurosMensal,
    required int periodoMeses,
  }) {
    List<double> montantes = [];
    double saldoAtual = capitalInicial;

    for (int i = 0; i < periodoMeses; i++) {
      saldoAtual += aplicacaoMensal;
      saldoAtual += saldoAtual * (taxaJurosMensal / 100);
      montantes.add(saldoAtual);
    }

    return montantes;
  }

  static double calcularMontanteFinal(List<double> montantes) {
    return montantes.isNotEmpty ? montantes.last : 0.0;
  }
}

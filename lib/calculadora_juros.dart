import 'package:flutter/material.dart';



/// Widget principal do aplicativo
class CalculadoraJurosApp extends StatelessWidget {
  const CalculadoraJurosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CalculadoraJurosPage(title: 'Calculadora de Juros Compostos'),
    );
  }
}

/// Página principal da Calculadora de Juros Compostos
class CalculadoraJurosPage extends StatefulWidget {
  const CalculadoraJurosPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State createState() => _CalculadoraJurosPageState();
}

/// Estado da página principal que controla os cálculos e exibição dos dados
class _CalculadoraJurosPageState extends State {
  // Controladores para capturar os valores digitados
  final capitalController = TextEditingController();
  final aplicacaoMensalController = TextEditingController();
  final mesesController = TextEditingController();
  final taxaJurosMesController = TextEditingController();

  // Variáveis para armazenar os dados e cálculos
  late double capital = 0.0;
  late double aplicacaoMensal = 0.0;
  late int meses = 0;
  late double taxaJurosMes = 0.0;
  late double rendimentoMensal = 0.0;
  late double rendimentoFinal = 0.0;
  late double montante = 0.0;

  // Listas para exibir os valores calculados
  List valorRendimentos = [];
  List valores = [];
  late String dados;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Juros Compostos"),
      ),
      body: Column(
        children: [
          // Campo para inserir o investimento inicial
          _campoTexto(
            controller: capitalController,
            label: 'Investimento inicial',
          ),

          // Campo para inserir a aplicação mensal
          _campoTexto(
            controller: aplicacaoMensalController,
            label: 'Aplicação Mensal',
          ),

          // Campo para inserir o período em meses
          _campoTexto(
            controller: mesesController,
            label: 'Período em meses',
          ),

          // Campo para inserir a taxa de juros mensal
          _campoTexto(
            controller: taxaJurosMesController,
            label: 'Rentabilidade Mês (%)',
          ),

          // Botão para calcular os juros compostos
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: _calcularJurosCompostos,
              child: const Text('Calcular'),
            ),
          ),

          // Exibição do montante total após o cálculo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                montante == 0
                    ? "Insira os dados para calcular"
                    : "Montante final: R$ ${montante.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Lista que exibe os rendimentos mês a mês
          Expanded(
            child: ListView.builder(
              itemCount: valores.length,
              itemBuilder: (context, index) {
                final rendimento = valores[index];
                final mes = index + 1;
                return ListTile(
                  title: Text('Mês 
rendimento'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Função para criar um campo de texto reutilizável
  Widget _campoTexto({required TextEditingController controller, required String label}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: label),
          keyboardType: TextInputType.number, // Apenas números
        ),
      ),
    );
  }

  /// Função para calcular os juros compostos
  void _calcularJurosCompostos() {
    // Captura e converte os valores digitados
    capital = double.parse(capitalController.text);
    aplicacaoMensal = double.parse(aplicacaoMensalController.text);
    meses = int.parse(mesesController.text);
    taxaJurosMes = double.parse(taxaJurosMesController.text) / 100; // Converte para percentual

    // Limpa os dados anteriores
    rendimentoFinal = 0.0;
    montante = 0.0;
    valores.clear();

    // Realiza os cálculos para cada mês
    for (int i = 0; i < meses; i++) {
      rendimentoMensal = capital * taxaJurosMes;
      rendimentoFinal += rendimentoMensal;
      montante = capital + rendimentoMensal;

      // Adiciona a aplicação mensal ao capital
      capital += rendimentoMensal + aplicacaoMensal;

      // Armazena os rendimentos para exibição
      valores.add(rendimentoMensal.toStringAsFixed(2));
    }

    // Atualiza a interface com os novos valores
    setState(() {});
  }
}

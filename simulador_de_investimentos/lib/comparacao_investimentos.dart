import 'package:flutter/material.dart';
import 'calculadora_juros.dart';

class ComparacaoInvestimentos extends StatefulWidget {
  const ComparacaoInvestimentos({super.key});

  @override
  _ComparacaoInvestimentosState createState() =>
      _ComparacaoInvestimentosState();
}

class _ComparacaoInvestimentosState extends State<ComparacaoInvestimentos> {
  final _formKey = GlobalKey<FormState>();
  double capitalInicial1 = 0, capitalInicial2 = 0;
  double aplicacaoMensal1 = 0, aplicacaoMensal2 = 0;
  double taxaJuros1 = 0, taxaJuros2 = 0;
  int periodoMeses = 0;

  List<double> evolucao1 = [];
  List<double> evolucao2 = [];

  void calcularInvestimentos() {
    evolucao1 = JurosCompostos.calcularEvolucao(
      capitalInicial: capitalInicial1,
      aplicacaoMensal: aplicacaoMensal1,
      taxaJurosMensal: taxaJuros1,
      periodoMeses: periodoMeses,
    );
    evolucao2 = JurosCompostos.calcularEvolucao(
      capitalInicial: capitalInicial2,
      aplicacaoMensal: aplicacaoMensal2,
      taxaJurosMensal: taxaJuros2,
      periodoMeses: periodoMeses,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparação de Investimentos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dados do Investimento 1',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Capital Inicial',
                onChanged: (value) =>
                    capitalInicial1 = double.tryParse(value) ?? 0,
              ),
              _buildTextField(
                label: 'Aplicação Mensal',
                onChanged: (value) =>
                    aplicacaoMensal1 = double.tryParse(value) ?? 0,
              ),
              _buildTextField(
                label: 'Taxa de Juros Mensal (%)',
                onChanged: (value) => taxaJuros1 = double.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 20),
              const Text(
                'Dados do Investimento 2',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Capital Inicial',
                onChanged: (value) =>
                    capitalInicial2 = double.tryParse(value) ?? 0,
              ),
              _buildTextField(
                label: 'Aplicação Mensal',
                onChanged: (value) =>
                    aplicacaoMensal2 = double.tryParse(value) ?? 0,
              ),
              _buildTextField(
                label: 'Taxa de Juros Mensal (%)',
                onChanged: (value) => taxaJuros2 = double.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 20),
              const Text(
                'Período de Investimento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Período em Meses',
                onChanged: (value) => periodoMeses = int.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: calcularInvestimentos,
                  child: const Text('Comparar Investimentos'),
                ),
              ),
              const SizedBox(height: 30),
              if (evolucao1.isNotEmpty && evolucao2.isNotEmpty)
                _buildComparisonResults(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildComparisonResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Resultados da Comparação',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: periodoMeses,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('Mês ${index + 1}'),
                subtitle: Text(
                  'Investimento 1: R\$${evolucao1[index].toStringAsFixed(2)}\n'
                  'Investimento 2: R\$${evolucao2[index].toStringAsFixed(2)}',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

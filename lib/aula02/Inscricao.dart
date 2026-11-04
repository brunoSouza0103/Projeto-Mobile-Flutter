
import 'package:flutter/material.dart';

class Inscricao extends StatefulWidget {
  const Inscricao({super.key});

  @override
  State<Inscricao> createState() => _InscricaoState();
}

class _InscricaoState extends State<Inscricao> {
  final receita = TextEditingController();

  String? mensagemErro;
  String? resultadoPesquisa;

  void pesquisarReceita() {
    final texto = receita.text.trim();

    setState(() {
      if (texto.isEmpty) {
        mensagemErro = "Informe o nome de uma receita para pesquisar.";
        resultadoPesquisa = null;
        return;
      }

      mensagemErro = null;
      resultadoPesquisa = texto;
    });
  }

  @override
  void dispose() {
    receita.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisar Receitas"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: receita,
              decoration: InputDecoration(
                labelText: "Nome da receita",
                hintText: "Ex: Bolo de cenoura",
                errorText: mensagemErro,
                border: const OutlineInputBorder(),
              ),
              onChanged: (valor) {
                if (mensagemErro != null) {
                  setState(() {
                    mensagemErro = null;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: pesquisarReceita,
                child: const Text("Pesquisar"),
              ),
            ),

            const SizedBox(height: 24),

            if (resultadoPesquisa != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text("Pesquisa realizada"),
                  subtitle: Text(
                    "Receita pesquisada: $resultadoPesquisa",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

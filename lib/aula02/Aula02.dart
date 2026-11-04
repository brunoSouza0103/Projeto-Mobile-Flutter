import 'package:flutter/material.dart';
import 'package:projeto_novo/aula02/Inscricao.dart';

class Aula02 extends StatelessWidget {
  const Aula02({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Inscricao(),
    );
  }
}

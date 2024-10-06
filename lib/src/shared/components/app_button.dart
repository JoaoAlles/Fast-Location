import 'package:flutter/material.dart'; // Importa o framework Flutter para desenvolvimento de interface.

// Define um botão customizado chamado AppButton.
class AppButton extends StatelessWidget {
  final String label; // Define o texto do botão.
  final Function()? action; // Define a ação a ser executada ao pressionar o botão.

  // Construtor da classe.
  const AppButton({
    super.key, // Chave única do widget.
    required this.label, // Define o texto do botão como obrigatório.
    this.action, // Define a ação como opcional.
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Define um SizedBox para controlar a largura do botão.
      width: double.infinity, // Define a largura do botão como infinita (ocupa todo o espaço disponível).
      child: ElevatedButton( // Define o botão como um ElevatedButton.
        onPressed: action, // Define a ação a ser executada ao pressionar o botão.
        child: Text(label), // Define o texto do botão.
      ),
    );
  }
}
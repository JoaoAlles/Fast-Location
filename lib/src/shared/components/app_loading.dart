import 'package:flutter/material.dart'; // Importa o framework Flutter para desenvolvimento de interface.

// Define o widget AppLoading que exibe um indicador de progresso circular.
class AppLoading extends StatelessWidget {
  const AppLoading({super.key}); // Construtor da classe.

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Define o widget Scaffold para a estrutura básica da página.
      backgroundColor: Theme.of(context).colorScheme.primary, // Define a cor de fundo da página.
      body: Center( // Centraliza o conteúdo da página.
        child: CircularProgressIndicator( // Define o indicador de progresso circular.
          backgroundColor: Theme.of(context).colorScheme.primaryContainer, // Define a cor de fundo do indicador.
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_app/views/lista_form_view.dart';

import 'package:lista_app/main.dart'; // Certifique-se de que o MyApp é importado corretamente

void main() {
  testWidgets('Verifica se o botão de adicionar está presente e funcionando', (WidgetTester tester) async {
    // Construa o widget e execute a tela
    await tester.pumpWidget(MyApp());

    // Verifique se o ícone de adicionar está presente
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Clique no botão de adicionar
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Recarrega a tela

    // Verifique se a navegação para o formulário de tarefa (ListaFormView) ocorreu
    expect(find.byType(ListaFormView), findsOneWidget);
  });
}

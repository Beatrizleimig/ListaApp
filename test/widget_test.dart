import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_app/views/lista_form_view.dart';

import 'package:lista_app/main.dart';

void main() {
  testWidgets('Verifica se o botão de adicionar está presente e funcionando', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());


    expect(find.byIcon(Icons.add), findsOneWidget);


    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();


    expect(find.byType(ListaFormView), findsOneWidget);
  });
}

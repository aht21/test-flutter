import 'package:flutter/widgets.dart';

main() => runApp(
  Directionality(
    textDirection: TextDirection.ltr,
    child: Container( // новый виджет! <div> в мире Flutter'а
      // Для виджета Container свойство color означает цвет фона
      color: Color(0xFF444444),
      child: Center(
        child: Text(
          'Hello, World!',
          style: TextStyle( // а у текста появился виджет, который его стилизует
            color: Color(0xFFFD620A), // задаем ему цвет текста
            fontSize: 32.0, // и размер шрифта
          ),
        ),
      ),
    ),
  ),
);
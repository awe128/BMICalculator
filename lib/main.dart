import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:bmi_calc/constants.dart';
import 'package:bmi_calc/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calc/widgets/CardWidget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ИМТ Калькулятор',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

var lines = [];

enum Gender { male, female }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerWeight = TextEditingController();
  final controllerAge = TextEditingController();

  Gender gender = Gender.male;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerWeight.dispose();
    controllerAge.dispose();
    super.dispose();
  }

  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    String date = DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());
    file
        .openWrite(mode: FileMode.append)
        .write('ИМТ: $text\nДата и время: $date\n');
  }

  Future<String?> _read() async {
    String? text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      text = file.readAsStringSync();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  var height = 60;
  int age = 0;
  double weight = 0;

  @override
  Widget build(BuildContext context) {
    onTap() async {
      final weight = double.parse(controllerWeight.text);
      final resultHeight = pow(height / 100, 2);
      final bmi = weight / resultHeight;
      await _write(bmi.toStringAsFixed(1));
      String descriptionBMI = '';
      TextStyle resultColorBMI =
          const TextStyle(fontSize: 30, fontWeight: FontWeight.w900);
      if (gender == Gender.male) {
        if (bmi < 20) {
          descriptionBMI = 'Дефицит веса';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.cyan);
        } else if (bmi >= 20 && bmi < 25) {
          descriptionBMI = 'Норма';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.green);
        } else if (bmi >= 25 && bmi < 30) {
          descriptionBMI = 'Незначительный\nизбыточный\nвес';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.yellow);
        } else if (bmi >= 30 && bmi < 40) {
          descriptionBMI = 'Ожирение';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.orange);
        } else {
          descriptionBMI = 'Сильное ожирение';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.red);
        }
      } else {
        if (bmi < 19) {
          descriptionBMI = 'Дефицит веса';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.cyan);
        } else if (bmi >= 19 && bmi < 24) {
          descriptionBMI = 'Норма';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.green);
        } else if (bmi >= 24 && bmi < 30) {
          descriptionBMI = 'Незначительный\nизбыточный\nвес';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.yellow);
        } else if (bmi >= 30 && bmi < 40) {
          descriptionBMI = 'Ожирение';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.orange);
        } else {
          descriptionBMI = 'Сильное ожирение';
          resultColorBMI = const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.red);
        }
      }
      var g = await _read();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
              bmi: bmi,
              desc: descriptionBMI,
              resultColorBMI: resultColorBMI,
              prefBMI: g
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('ИМТ Калькулятор'),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: CardWidget(
                    onTap: () {
                      setState(() {
                        gender = Gender.male;
                      });
                    },
                    color: gender == Gender.male
                        ? CardColorActive
                        : CardColorInactive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          FontAwesomeIcons.mars,
                          size: 70,
                        ),
                        Text(
                          'Мужской'.toUpperCase(),
                          style: names,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CardWidget(
                    onTap: () {
                      setState(() {
                        gender = Gender.female;
                      });
                    },
                    color: gender == Gender.female
                        ? CardColorActive
                        : CardColorInactive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          FontAwesomeIcons.venus,
                          size: 70,
                        ),
                        Text(
                          'Женский'.toUpperCase(),
                          style: names,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: CardWidget(
                    color: CardColorInactive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Рост'.toUpperCase(),
                          style: names,
                        ),
                        Text(
                          height.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 40),
                        ),
                        Slider(
                          value: height.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              height = value.round();
                            });
                          },
                          min: 60,
                          max: 250,
                          activeColor: Colors.deepOrange,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: CardWidget(
                    color: CardColorInactive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Вес'.toUpperCase(),
                          style: names,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: controllerWeight,
                          textAlign: TextAlign.center,
                          style: inputs,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Введите вес',
                          ),
                          maxLength: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CardWidget(
                    color: CardColorInactive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Возраст'.toUpperCase(),
                          style: names,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: controllerAge,
                          textAlign: TextAlign.center,
                          style: inputs,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Введите возраст',
                          ),
                          maxLength: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            GestureDetector(
                onTap: onTap,
                child: SizedBox(
                  child: Container(
                    height: 60,
                    color: Colors.deepOrange,
                    child: Center(
                      child: Text(
                        'Вычислить результат'.toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ))
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

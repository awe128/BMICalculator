import 'package:bmi_calc/constants.dart';
import 'package:bmi_calc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultPage extends StatelessWidget {
  final bmi;
  final String? desc;
  final TextStyle? resultColorBMI;
  final prefBMI;

  const ResultPage(
      {super.key, this.bmi, this.desc, this.resultColorBMI, this.prefBMI});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваш результат ИМТ'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 70, 30, 70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Индекс ИМТ:', style: TextStyle(fontSize: 30)),
                Text(bmi.toStringAsFixed(1), style: resultColorBMI),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Описание:', style: TextStyle(fontSize: 20)),
                Text(
                  desc.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Предыдущие результаты: ',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: Center(
                  child: Text(
                    prefBMI,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                )),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bmi_calc/constants.dart';
import 'package:bmi_calc/widgets/CardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultPage extends StatelessWidget {

  final bmi;
  final String? desc;
  final TextStyle? resultColorBMI;

  const ResultPage({super.key, this.bmi, this.desc, this.resultColorBMI});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ваш результат ИМТ'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 70, 30, 70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Индекс ИМТ:', style: TextStyle(fontSize: 30)),
                Text(bmi.toStringAsFixed(1), style: resultColorBMI),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Описание:', style: TextStyle(fontSize: 20)),
                Text(desc.toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
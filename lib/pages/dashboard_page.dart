import 'package:flutter/material.dart';
import 'package:flutter_imc_calculator/components/constants.dart';
import 'package:flutter_imc_calculator/models/imc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:validatorless/validatorless.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController _imcWeightController = TextEditingController();
  TextEditingController _imcHeightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _imcText = '';
  double _imc = 0.0;
  Color _textColor = stanColor;
  bool _calculating = false;

  void _resetIMC() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _imcWeightController.text = "";
      _imcHeightController.text = "";
      _imcText = "";
      _formKey = GlobalKey<FormState>();
      _calculating = false;
    });
  }

  void _calculateIMC() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      final IMC imcData = IMC(
          weight: double.parse(_imcWeightController.text),
          height: double.parse(_imcHeightController.text));
      _imc = imcData.weight / (imcData.height * imcData.height);
      _calculating = true;

      if (_imc < 18.5) {
        _imcText = 'MAGREZA';
        _textColor = Colors.green;
      } else if (_imc >= 18.5 && _imc < 25.9) {
        _imcText = "SAUDÁVEL";
        _textColor = Colors.greenAccent;
      } else if (_imc >= 25.9 && _imc < 29.9) {
        _imcText = "SOBREPESO";
        _textColor = Colors.yellow;
      } else if (_imc >= 29.9) {
        _imcText = "OBESIDADE";
        _textColor = Colors.red;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _imcWeightController.dispose();
    _imcHeightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Calculadora do IMC',
          style: TextStyle(color: stanColor, fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: darkModeColor,
        actions: [IconButton(onPressed: _resetIMC, icon: const Icon(Icons.refresh))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Peso",
                    style: TextStyle(
                      color: stanColor,
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: TextFormField(
                        style: const TextStyle(color: darkColor, fontSize: 20),
                        keyboardType: TextInputType.number,
                        controller: _imcWeightController,
                        validator: Validatorless.multiple([
                          Validatorless.required('Insira seu Peso'),
                          Validatorless.number('Apenas números')
                        ]),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          hintText: 'Ex: 70.0',
                          hintStyle: const TextStyle(fontSize: 18, color: Colors.black54),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              'Kg',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: darkColor,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(48),
                            borderSide: const BorderSide(
                              style: BorderStyle.none,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Altura",
                      style: TextStyle(
                        color: stanColor,
                        fontSize: 24,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 17),
                        child: TextFormField(
                          style: const TextStyle(color: darkColor, fontSize: 20),
                          keyboardType: const TextInputType.numberWithOptions(),
                          controller: _imcHeightController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Insira seu Peso'),
                            Validatorless.number('Apenas números')
                          ]),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            hintText: 'Ex:  1.70',
                            hintStyle:
                                const TextStyle(fontSize: 18, color: Colors.black54),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                'M',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: darkColor,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(48),
                              borderSide: const BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      _calculateIMC();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: stanColor,
                      splashFactory: InkSplash.splashFactory,
                      elevation: 0,
                      surfaceTintColor: Colors.grey,
                      animationDuration: defaultDuration,
                      foregroundColor: Colors.blueGrey),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                          fontSize: 22, color: darkColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              _calculating
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "Resultado:",
                            style: TextStyle(
                              color: stanColor,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 8),
                          child: Text(
                            _imcText,
                            style: TextStyle(
                                color: _textColor,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Insira seus dados",
                        style: TextStyle(
                          color: standardBlue.withOpacity(0.8),
                          fontSize: 26,
                        ),
                      ),
                    ),
              if (_calculating)
                SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                        showLabels: false,
                        minimum: 0,
                        maximum: 40,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 18.5,
                              color: Colors.green,
                              startWidth: 50,
                              endWidth: 50),
                          GaugeRange(
                              startValue: 18.5,
                              endValue: 25.9,
                              color: Colors.greenAccent,
                              startWidth: 50,
                              endWidth: 50),
                          GaugeRange(
                              startValue: 25.9,
                              endValue: 29.9,
                              color: Colors.yellow,
                              startWidth: 50,
                              endWidth: 50),
                          GaugeRange(
                              startValue: 29.9,
                              endValue: 40,
                              color: Colors.red,
                              startWidth: 50,
                              endWidth: 50),
                        ],
                        pointers: <GaugePointer>[
                          MarkerPointer(
                            value: _imc,
                            markerType: MarkerType.triangle,
                            markerHeight: 30,
                            markerWidth: 30,
                            markerOffset: 40,
                            color: stanColor,
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            axisValue: _imc,
                            positionFactor: 0.05,
                            widget: Text(
                              _imc.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal),
                            ),
                          )
                        ])
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

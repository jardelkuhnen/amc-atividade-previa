import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String textoScreen = "Infome seus dados...";

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  void _clearForm() {
    setState(() {
      alturaController.text = "";
      pesoController.text = "";
      textoScreen = "Infome seus dados...";
    });
  }

  void _calcularIMC() {
    setState(() {
      if (alturaController.text.isEmpty || pesoController.text.isEmpty) {
        textoScreen = "Informe o Peso e Altura!!!";
        return;
      }

      double imc;
      try {
        double altura = double.parse(alturaController.text) / 100;
        double peso = double.parse(pesoController.text);
        imc = peso / (altura * altura);
      } catch (e) {
        textoScreen =
            "Dados inválidos! Informe corretamente seu Peso e Altura!";
        return;
      }

      if (imc < 17) {
        textoScreen = "muito abaixo do peso (${imc.toStringAsPrecision(4)})";
        return;
      }

      if (imc >= 17 && imc < -18.49) {
        textoScreen = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        return;
      }

      if (imc >= 18.5 && imc <= 24.99) {
        textoScreen = "Peso ideal (${imc.toStringAsPrecision(4)})";
        return;
      }

      if (imc >= 25 && imc <= 29.99) {
        textoScreen = "Acima do peso (${imc.toStringAsPrecision(4)})";
        return;
      }

      if (imc >= 30 && imc <= 39.99) {
        textoScreen = "Obesidade I (${imc.toStringAsPrecision(4)})";
        return;
      }

      if (imc >= 35 && imc <= 39.99) {
        textoScreen = "Obesidade II (severa) (${imc.toStringAsPrecision(4)})";
        return;
      }

      if (imc > 40) {
        textoScreen =
            "Obesidade III (mórbida) (${imc.toStringAsExponential(4)})";
        return;
      }
    });
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue[900], fontSize: 15.0),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Atividade Prévia AMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _clearForm();
              }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.calculate_rounded,
              size: 170.0,
              color: Colors.blue[900],
            ),
            Text(
              "Calculadora de IMC",
              style: TextStyle(color: Colors.blue[900], fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: buildTextField("Peso", pesoController),
            ),
            Divider(),
            buildTextField("Altura", alturaController),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 50.0,
                child: ElevatedButton(
                    child:
                        Text("Calcular", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      _calcularIMC();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0D47A1),
                      textStyle: const TextStyle(fontSize: 20),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                textoScreen,
                style: TextStyle(color: Colors.grey[900], fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

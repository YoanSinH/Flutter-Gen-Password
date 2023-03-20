import 'dart:math';
import 'package:flutter/material.dart';

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String _password = 'contrasena';
  int _length = 8;
  bool _useUppercase = false;
  bool _useSpecialChars = false;
  bool _useNumbers = false;

  void _generatePassword() {
    setState(() {
      _password = _getRandomPassword(_length, _useUppercase, _useSpecialChars, _useNumbers);
    });
  }

  String _getRandomPassword(int length, bool useUppercase, bool useSpecialChars, bool useNumbers) {
    final random = Random.secure();
    final lettersLower = "abcdefghijklmnopqrstuvwxyz";
    final lettersUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final specialChars = "!@#\$%^&*()_-+=[{]}|;:,<.>/?";
    final numbers = "0123456789";

    String chars = lettersLower;
    String password = "";

    if (useUppercase) {
      chars += lettersUpper;
    }
    if (useSpecialChars) {
      chars += specialChars;
    }
    if (useNumbers) {
      chars += numbers;
    }

    for (int i = 0; i < length; i++) {
      int randIndex = random.nextInt(chars.length);
      password += chars[randIndex];
    }

    return password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GENERADOR DE CONTRASEÑAS"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.0),
              SelectableText(
                _password,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Longitud: $_length"),
              Slider(
                min: 6,
                max: 20,
                divisions: 13,
                value: _length.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _length = value.round();
                  });
                },
                label: _length.toString(),
              ),
              CheckboxListTile(
                title: Text("abcd"),
                value: true,
                onChanged: (value) {
                  setState(() {
                    
                  });
                },
              ),
              CheckboxListTile(
                title: Text("ABCD"),
                value: _useUppercase,
                onChanged: (value) {
                  setState(() {
                    _useUppercase = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("/#\$%"),
                value: _useSpecialChars,
                onChanged: (value) {
                  setState(() {
                    _useSpecialChars = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("1234"),
                value: _useNumbers,
                onChanged: (value) {
                  setState(() {
                    _useNumbers = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _generatePassword,
                child: Text("Generar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';

class Materiales extends StatefulWidget{

@override
_MaterialesState createState() => _MaterialesState();
}

class _MaterialesState extends State<Materiales>{

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

String _email ="";
String _password = "";

void _getcredentials(){
_email = _emailController.text;
_password = _passwordController.text;

if (_email=="luisangelguillencastillo@gmail.com" && _password=="123456")
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login exitoso")),);
}

else
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Credenciales Incorrectas")),
  );
}

}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Materiales")),
        body: Column());
        }
        
        }/*ListView(
        children:ExpansionTile(title: Text("Materiales Activos"),
          leading: Icon(Icons.work),
            children: [
                
                      ],

        ),
        )
      
    );
  }
  }*/

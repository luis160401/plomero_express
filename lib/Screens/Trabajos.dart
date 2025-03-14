import 'dart:io';

import 'package:flutter/material.dart';

class Trabajos extends StatefulWidget{

@override
_TrabajosState createState() => _TrabajosState();
}

class _TrabajosState extends State<Trabajos>{

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
        title: Text("Trabajos")),
        body: Column());
        }
        
        }/*ListView(
        children:ExpansionTile(title: Text("Trabajos Activos"),
          leading: Icon(Icons.work),
            children: [
                
                      ],

        ),
        )
      
    );
  }
  }*/

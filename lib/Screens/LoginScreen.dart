import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{

@override
_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();



Future<void> register()async{
try{
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passwordController.text.trim());
  
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login exitoso")),);
  
}
on FirebaseAuthException
catch (e) {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Credenciales Incorrectas")));
}

}

Future<void> login() async
{
try{
UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passwordController.text.trim());

   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se accedio perfectamente")));
}
on FirebaseAuthException catch (e)
{
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No se pudo completar el Log in")));
}
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in")),
        body: Padding(padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Correo Electronico o Usuario"),
                  keyboardType: TextInputType.emailAddress
                ),



                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Contraseña"),
                  obscureText: true,
                ),
                
                SizedBox(height:10),

                ElevatedButton(onPressed: login, child: Text('Logearse')),
                
                SizedBox(height:  10),
                
                ElevatedButton(onPressed: register, child: Text('Crear Cuenta Nueva'))
                      ],

        ),
        )
      
    );
  }
  }


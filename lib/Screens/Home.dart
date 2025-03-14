import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plomero_express/Screens/LoginScreen.dart';
import 'package:plomero_express/Screens/Mapas.dart';
import 'package:plomero_express/Screens/Trabajos.dart';
import 'Facturas.dart';
import 'Materiales.dart';
import 'Mapas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';





class ScreensButtons extends StatefulWidget
{
  _ScreensButtons createState() => _ScreensButtons();
}

class _ScreensButtons extends State<ScreensButtons>
{
  int _selectedIndex = 0;
  

Future<void> SignOut(BuildContext context) async
{
await FirebaseAuth.instance.signOut();
Navigator.pushReplacementNamed(context, "/login");

}
  final List<Widget> _screens = 
[
  Home(),
  Trabajos(),
  Mapas(),
  Materiales(),
  Facturas(),
  

  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.work,
    Icons.map_rounded,
    Icons.handyman,
    Icons.money
  ];

  final NotchBottomBarController _notchBottomBarController =NotchBottomBarController(index: 0);

  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Plomero Express'),
            Image.asset('assets/images/logo.jpg',
              width: screenwidth*0.14,              fit: BoxFit.contain,
            )
     
          ]),
        
        actions: [
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: ()
              {
                showMenu(context: context,
                          position: RelativeRect.fromLTRB(50, 50, 50, 50),
                         items: [
                          PopupMenuItem<String>
                              (
                                value: 'profile',
                                child: Row(children: 
                                          [
                                            Icon(Icons.account_circle_outlined),
                                            SizedBox(width: 8),
                                            Text('Ver Perfil')

                                          ]
                                         ,)
                              ,),
                            PopupMenuItem<String> (
                              value: 'signOut',
                              child: Row(children:
                                [
                                  Icon(Icons.exit_to_app),
                                  SizedBox(width: 8),
                                  Text('Cerrar Sesión')
                                ],)
                      
                            )
                         ],
                         elevation: 8.0,
                          ).then((value)
                          {
                              if (value == 'profile')
                              {
                                print('Ir al perfil');
                              } 
                              else if(value == 'signOut')
                              {
                                SignOut(context);
                              }

                           }
                          );
              }
            )
         ]               

      ),
      extendBody: true,
      body: _screens[_selectedIndex],
       floatingActionButton: FloatingActionButton(onPressed: (){
      }
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
      notchBottomBarController: _notchBottomBarController,
      color: Colors.blueAccent,
      notchColor: const Color.fromARGB(255, 255, 255, 255),
      showLabel: false,
      kIconSize: 30.0,
      kBottomRadius: 20.0,
      bottomBarItems: [

        BottomBarItem(inActiveItem: Icon(icons[1], color: Colors.white,)
                    , activeItem: Icon(icons[1], color: const Color.fromARGB(255, 255, 158, 13),)),
      
        BottomBarItem(inActiveItem: Icon(icons[2], color: Colors.white,)
                    , activeItem: Icon(icons[2], color: Color.fromARGB(255, 255, 158, 13),)),

        BottomBarItem(inActiveItem: Icon(icons[3], color: Colors.white,)
                    , activeItem: Icon(icons[3], color: Color.fromARGB(255, 255, 158, 13),)),

        BottomBarItem(inActiveItem: Icon(icons[4], color: Colors.white,)
                    , activeItem: Icon(icons[4], color: Color.fromARGB(255, 255, 158, 13),)),
        
        BottomBarItem(inActiveItem: Icon(icons[5], color: Colors.white,)
                    , activeItem: Icon(icons[5], color: Color.fromARGB(255, 255, 158, 13),)),

          ],

          onTap: (index) {
                setState(() {
                  _selectedIndex=index;
            });
          }
      )

    );
  }
}

 /* 
 @override
 Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text("Plomero Expreess"),
    ) ,
    body: 
        IndexedStack(
      index: _selectedIndex,
      children: _screens),

    bottomNavigationBar: CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: Colors.blueAccent,
      height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.white),
          Icon(Icons.home, size: 30,color: Colors.green),
          Icon(Icons.home, size: 30,color: Colors.red),
        ],
        onTap: (index)
        {
          setState(() {
            _selectedIndex=index;
          });
        },
          )
        
        );
 }

}
*/

class Home extends StatefulWidget{

@override
_Home createState() => _Home();
}

class _Home extends State<Home>{



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio")),
        body: Column(
        children: [
          Card(
               elevation: 5,
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Text("Trabajos Activos"),
                      SizedBox(height: 20),
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.work),
                              title: Text("Trabajo 1"),
                              subtitle: Text("Estado: En progreso"),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: (){},
                            ),

                             ListTile(
                              leading: Icon(Icons.work),
                              title: Text("Trabajo 1"),
                              subtitle: Text("Estado: En progreso"),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: (){},
                            ),

                             ListTile(
                              leading: Icon(Icons.work),
                              title: Text("Trabajo 1"),
                              subtitle: Text("Estado: En progreso"),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: (){},
                            ),

                            SizedBox(height: 20),

                            ElevatedButton(onPressed:(){} , child: Text("Agregar Trabajo"))
                          ],

                        ),
                      )


                    ]
                  )

                  
                ),
              )
          ],

        ),
        );
      
  }
  }


import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Metro GO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      drawer: getDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/metrogo-logo.jpg',
              height: 250,
              scale: 2.5,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.history,
                          size: 70
                          ),
                        onPressed: () {
                        },
                      ),
                      const Text(
                        'Historial'
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.inventory_2,
                          size: 70
                          ),
                        onPressed: () {
                        },
                      ),
                      const Text(
                        'Entregas Activas'
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.paid,
                          size: 70
                          ),
                        onPressed: () {
                        },
                      ),
                      const Text(
                        'Cobros'
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.directions_run,
                          size: 70
                          ),
                        onPressed: () {
                          context.go("/EntregasRetiros");
                        },
                      ),
                      const Text(
                        'Entregas y Retiros'
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ), 
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      drawer: getDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/metrogo-logo.jpg',
              height: 200,
            ),
            const Text(
              "¡Tu código de entrega ha sido generado!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10)
            ),
            QrImageView(
              data: 'Prueba para MetroQR. Buenas!',
              version: QrVersions.auto,
              size: 250.0,
            ),
            const Padding(
              padding: EdgeInsets.all(10)
            ),
            ElevatedButton(
              child: const Text('Salir'),
              onPressed: () {
                context.go("/");
              },
            )
          ],
        )
      ),
    );
  }
}

class EntregasRetiros extends StatelessWidget {
  const EntregasRetiros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      drawer: getDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/metrogo-logo.jpg',
              height: 200,
            ),
            const Text(
              "Entregas y retiros",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.inventory_2,
                        size: 70
                      ),
                      onPressed: () {
                      },
                    ),
                    const Text(
                      'Nueva entrega'
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(30)
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.location_on,
                        size: 70
                      ),
                      onPressed: () {
                      },
                    ),
                    const Text(
                      'Retiros pendientes'
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10)
            ),
            ElevatedButton(
              child: const Text('Atrás'),
              onPressed: () {
                context.go("/");
              },
            )
          ],
        )
      ),
    );
  }
}

AppBar getAppBar(BuildContext context) {
  return AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      );
}

Drawer getDrawer(BuildContext context) {
  return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
        // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Inicio'),
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                }
                context.go("/");
              },
            ),
            ListTile(
              title: const Text('Usuario'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              title: const Text('Configuración'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              title: const Text('Escanear QR'),
              onTap: () {
                  context.go("/QRScreen");
              },
            ),
            ListTile(
              title: const Text('Estaciones'),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/QRScreen',
      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const QRScreen(),
          transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.75, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeIn)),
              ),
          child: child),
        );
      },
    ),
    GoRoute(
      path: '/EntregasRetiros',
      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const EntregasRetiros(),
          transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.75, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeIn)),
              ),
          child: child),
        );
      },
    ),
  ],
);
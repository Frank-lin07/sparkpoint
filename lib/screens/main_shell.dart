import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';
import 'crear_screen.dart';
import 'generando_screen.dart';
import 'carpetas_screen.dart';

class MainShell extends StatefulWidget {
  final int pestanaInicial;

  const MainShell({super.key, this.pestanaInicial = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int indice = widget.pestanaInicial;

  void irA(int nuevo) {
    setState(() {
      indice = nuevo;
    });
  }

  Widget proximamente(String nombre) {
    return Center(
      child: Text('$nombre: próximamente',
          style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pantallas = [
      HomeScreen(alCrear: () => irA(1)),
      CrearScreen(alGenerar: (tema, estilo) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => GenerandoScreen(tema: tema, estilo: estilo)),
        );
      }),
      const CarpetasScreen(),
      proximamente('Perfil'),
    ];

    return Scaffold(
      body: pantallas[indice],
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.superficie,
        indicatorColor: AppColors.amarillo.withValues(alpha: 0.2),
        selectedIndex: indice,
        onDestinationSelected: irA,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.amarillo),
              label: 'Inicio'),
          NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined),
              selectedIcon: Icon(Icons.auto_awesome, color: AppColors.amarillo),
              label: 'Crear'),
          NavigationDestination(
              icon: Icon(Icons.folder_outlined),
              selectedIcon: Icon(Icons.folder, color: AppColors.amarillo),
              label: 'Carpetas'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.amarillo),
              label: 'Perfil'),
        ],
      ),
    );
  }
}
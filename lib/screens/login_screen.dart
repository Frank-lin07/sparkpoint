import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/logo_spark.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool esRegistro = false;
  bool ocultarClave = true;

  final TextEditingController usuarioCtrl = TextEditingController();
  final TextEditingController correoCtrl = TextEditingController();
  final TextEditingController claveCtrl = TextEditingController();
  final TextEditingController confirmarCtrl = TextEditingController();

  @override
  void dispose() {
    usuarioCtrl.dispose();
    correoCtrl.dispose();
    claveCtrl.dispose();
    confirmarCtrl.dispose();
    super.dispose();
  }

  void cambiarModo(bool registro) {
    setState(() {
      esRegistro = registro;
    });
  }

  Widget campo(String etiqueta, TextEditingController ctrl, IconData icono,
      {bool esClave = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(etiqueta, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          TextField(
            controller: ctrl,
            obscureText: esClave && ocultarClave,
            decoration: InputDecoration(
              prefixIcon: Icon(icono, color: AppColors.textoSecundario),
              suffixIcon: esClave
                  ? IconButton(
                      icon: Icon(
                        ocultarClave ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textoSecundario,
                      ),
                      onPressed: () {
                        setState(() {
                          ocultarClave = !ocultarClave;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget pestana(String texto, bool activa, VoidCallback alTocar) {
    return Expanded(
      child: GestureDetector(
        onTap: alTocar,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: activa ? AppColors.superficie : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            texto,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: activa ? AppColors.amarillo : AppColors.textoSecundario,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  const LogoSpark(tamano: 64),
                  const SizedBox(height: 8),
                  Text('Spark Point',
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 4),
                  Text('Tu punto de partida creativo',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.fondo,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.superficie),
                    ),
                    child: Row(
                      children: [
                        pestana('Iniciar sesión', !esRegistro,
                            () => cambiarModo(false)),
                        pestana('Registrarse', esRegistro,
                            () => cambiarModo(true)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (esRegistro)
                    campo('Nombre de usuario', usuarioCtrl, Icons.alternate_email)
                  else
                    campo('Usuario o correo electrónico', usuarioCtrl,
                        Icons.alternate_email),
                  if (esRegistro)
                    campo('Correo electrónico', correoCtrl, Icons.mail_outline),
                  campo('Contraseña', claveCtrl, Icons.lock_outline,
                      esClave: true),
                  if (esRegistro)
                    campo('Confirmar contraseña', confirmarCtrl,
                        Icons.lock_outline,
                        esClave: true),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.degradado,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      child: Text(
                        esRegistro ? 'Crear cuenta' : 'Iniciar sesión',
                        style: const TextStyle(
                          fontFamily: AppTheme.fuenteTitulos,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
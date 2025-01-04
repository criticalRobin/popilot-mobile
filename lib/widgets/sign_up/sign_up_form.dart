import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/providers/auth_provider.dart';
import 'package:popilot_mobile/shared/notification.dart';
import 'package:popilot_mobile/utils/colors.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Form(
      key: _formKey,
      onChanged: () =>
          setState(() => _enableBtn = _formKey.currentState!.validate()),
      child: Column(
        children: [
          TextFormField(
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            onSaved: (value) => username = value!,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lapislazuli),
              ),
              labelText: 'Usuario',
              floatingLabelStyle: TextStyle(color: AppColors.lapislazuli),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) =>
                value == null || value.isEmpty || !value.contains("@")
                    ? "Correo inválido"
                    : null,
            onSaved: (value) => email = value!,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lapislazuli),
              ),
              labelText: 'Correo',
              floatingLabelStyle: TextStyle(color: AppColors.lapislazuli),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) =>
                value!.length < 6 ? 'Min. 6 caracteres' : null,
            onSaved: (value) => password = value!,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lapislazuli),
              ),
              labelText: 'Contraseña',
              floatingLabelStyle: TextStyle(color: AppColors.lapislazuli),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: _enableBtn ? AppColors.lapislazuli : null,
            ),
            icon: authState.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.lapislazuli,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.app_registration_outlined,
                    color: AppColors.white),
            label: Text(
              authState.isLoading ? 'Cargando...' : 'Registrarse',
              style: TextStyle(
                  color: authState.isLoading
                      ? AppColors.lapislazuli
                      : AppColors.white),
            ),
            onPressed: (_enableBtn && !authState.isLoading)
                ? () async {
                    FocusScope.of(context).requestFocus(FocusNode());

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final success = await authNotifier.register(
                          username, email, password);

                      success
                          ? context.go('/')
                          : ScaffoldMessenger.of(context).showSnackBar(
                              CustomNotification(
                                message: 'Error al registrarse',
                                status: 'error',
                              ),
                            );
                    }
                    _formKey.currentState!.reset();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

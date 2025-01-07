import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/models/facebook.dart';
import 'package:popilot_mobile/providers/social_networks_provider.dart';
import 'package:popilot_mobile/shared/notification.dart';
import 'package:popilot_mobile/utils/colors.dart';

class CreateUpdateFbForm extends ConsumerStatefulWidget {
  const CreateUpdateFbForm({super.key});

  @override
  ConsumerState<CreateUpdateFbForm> createState() => _CreateUpdateFbFormState();
}

class _CreateUpdateFbFormState extends ConsumerState<CreateUpdateFbForm> {
  final _formKey = GlobalKey<FormState>();
  final socialNetworkType = 'FB';
  String name = '';
  String pageId = '';
  String pageAccessToken = '';
  bool _enableBtn = false;

  @override
  Widget build(BuildContext context) {
    final snNotifier = ref.read(socialNetworkProvider.notifier);
    final snState = ref.watch(socialNetworkProvider);

    return Form(
      key: _formKey,
      onChanged: () =>
          setState(() => _enableBtn = _formKey.currentState!.validate()),
      child: Column(
        children: [
          TextFormField(
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            onSaved: (value) => name = value!,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lapislazuli),
              ),
              labelText: 'Nombre',
              floatingLabelStyle: TextStyle(color: AppColors.lapislazuli),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            onSaved: (value) => pageId = value!,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lapislazuli),
              ),
              labelText: 'ID de la página',
              floatingLabelStyle: TextStyle(color: AppColors.lapislazuli),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            onSaved: (value) => pageAccessToken = value!,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lapislazuli),
              ),
              labelText: 'Token de acceso de la página',
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
            icon: snState.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.lapislazuli,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.add_task_sharp, color: AppColors.white),
            label: Text(
              snState.isLoading ? 'Cargando...' : 'Crear red social',
              style: TextStyle(
                  color: snState.isLoading
                      ? AppColors.lapislazuli
                      : AppColors.white),
            ),
            onPressed: (_enableBtn && !snState.isLoading)
                ? () async {
                    FocusScope.of(context).requestFocus(FocusNode());

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final FacebookModel fb = FacebookModel(
                        name: name,
                        socialNetworkType: socialNetworkType,
                        pageId: pageId,
                        pageAccessToken: pageAccessToken,
                      );
                      final success = await snNotifier.createSocialNetwork(fb);

                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomNotification(
                            message: 'Error al crear red social',
                            status: 'error',
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomNotification(
                            message: 'Red social creada con éxito',
                            status: 'success',
                          ),
                        );
                        context.go('/socials');
                      }
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

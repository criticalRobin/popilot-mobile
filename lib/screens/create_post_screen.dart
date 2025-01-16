import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:popilot_mobile/models/social_network.dart';
import 'package:popilot_mobile/providers/auth_provider.dart';
import 'package:popilot_mobile/providers/post_provider.dart';
import 'package:popilot_mobile/providers/social_networks_provider.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/shared/notification.dart';
import 'package:popilot_mobile/utils/colors.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _scheduledAt;
  File? _image;
  String? _imagePreviewUrl;
  final _socialNetworks = <SocialNetworkModel>[];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSocialNetworks();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadSocialNetworks() async {
    final socialNetworksNotifier = ref.read(socialNetworkProvider.notifier);
    final socialNetworks = await socialNetworksNotifier.getSocialNetworks();
    if (socialNetworks != null) {
      setState(() {
        _socialNetworks.addAll(socialNetworks.facebookAccounts);
        _socialNetworks.addAll(socialNetworks.xAccounts);
      });
    }
  }

  void _handleImagePicker() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _imagePreviewUrl = pickedImage.path;
      });
    }
  }

  void _addSocialNetwork(SocialNetworkModel sn) {
    if (!_socialNetworks.any((n) => n.id == sn.id)) {
      setState(() {
        _socialNetworks.add(sn);
      });
    }
  }

  void _deleteSocialNetwork(SocialNetworkModel sn) {
    setState(() {
      _socialNetworks.removeWhere((n) => n.id == sn.id);
    });
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String? scheduledAt;
      if (_scheduledAt != null) {
        scheduledAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(_scheduledAt!);
      }

      final formData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'social_networks': _socialNetworks.map((sn) => sn.id).toList(),
        if (_image != null) 'image': _image,
      };

      try {
        await ref.read(postProvider.notifier).createPost(formData);
        if (_scheduledAt != null) {
          context.go('/home');
        } else {
          context.go('/posts');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomNotification(
            message: 'Error al crear el post',
            status: 'error',
          ),
        );
        context.go('/posts');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _addSocialNetworksModal() async {
    final socialNetworksNotifier = ref.read(socialNetworkProvider.notifier);
    final socialNetworks = await socialNetworksNotifier.getSocialNetworks();

    if (socialNetworks != null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Agregar redes sociales'),
          content: SizedBox(
            width: 400,
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final sn in socialNetworks.facebookAccounts)
                  ListTile(
                    title: Text(sn.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _addSocialNetwork(sn),
                    ),
                  ),
                for (final sn in socialNetworks.xAccounts)
                  ListTile(
                    title: Text(sn.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _addSocialNetwork(sn),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.lapislazuli, // header background color
              onPrimary: AppColors.white, // header text color
              onSurface: AppColors.erieblack, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.lapislazuli, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _scheduledAt = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PopilotAppbar(),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Campo requerido' : null,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lapislazuli),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Campo requerido' : null,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lapislazuli),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                if (authState.isPremiumUser == true)
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: TextEditingController(
                          text: _scheduledAt != null
                              ? DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(_scheduledAt!)
                              : '',
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Fecha de publicación',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.lapislazuli),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _addSocialNetworksModal();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.erieblack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: AppColors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Agregar redes sociales',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                if (_socialNetworks.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Redes sociales seleccionadas:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.erieblack,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      for (final sn in _socialNetworks)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(sn.name),
                            IconButton(
                              onPressed: () => _deleteSocialNetwork(sn),
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.erieblack,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _handleImagePicker,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.erieblack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image, color: AppColors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Seleccionar imagen',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                if (_imagePreviewUrl != null)
                  Image.file(
                    File(_imagePreviewUrl!),
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lapislazuli,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save, color: AppColors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Guardar',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.lapislazuli,
              ),
            ),
        ],
      ),
    );
  }
}

class FormData {
  final String title;
  final String description;
  final String? scheduledAt;
  final File? image;
  final List<int> socialNetworks;

  FormData({
    required this.title,
    required this.description,
    this.scheduledAt,
    this.image,
    required this.socialNetworks,
  });
}

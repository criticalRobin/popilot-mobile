import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

final stripeProvider = StateNotifierProvider<StripeNotifier, StripeState>(
  (ref) => StripeNotifier(),
);

class StripeState {
  final bool isLoading;
  final String? errorMessage;
  final bool isPaymentSuccessful;

  StripeState({
    required this.isLoading,
    this.errorMessage,
    this.isPaymentSuccessful = false,
  });

  StripeState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isPaymentSuccessful,
  }) {
    return StripeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isPaymentSuccessful: isPaymentSuccessful ?? this.isPaymentSuccessful,
    );
  }
}

class StripeNotifier extends StateNotifier<StripeState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl =
      'http://10.0.2.2:8000/api/payment'; // Ajusta según tu URL base

  StripeNotifier() : super(StripeState(isLoading: false));

  Future<void> initialize() async {
    Stripe.publishableKey =
        'pk_test_51Q9EvLFMrc1eZvoEGgjp0BTMVDDkvc4v3USLEHe4rZ9WJaoPAiBYDHGrLtRoHt9eTxP0iFWJy2QIvkkb0Ed7k82y00mRnCNydg';
    await Stripe.instance.applySettings();
  }

  Future<void> createPayment() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      // Obtener el token de autenticación
      final token = await _storage.read(key: 'token');
      _dio.options.headers['Authorization'] = 'Bearer $token';

      // Crear el PaymentIntent
      final response = await _dio.post(
        '$baseUrl/payment/create-payment-intent/',
      );

      if (response.statusCode == 200) {
        final clientSecret = response.data['clientSecret'];
        await _processPayment(clientSecret);
      } else {
        throw 'Error al crear el PaymentIntent';
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isPaymentSuccessful: false,
      );
    }
  }

  Future<void> _processPayment(String clientSecret) async {
    try {
      // Configurar la hoja de pago
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'PoPilot',
        ),
      );

      // Mostrar la hoja de pago
      await Stripe.instance.presentPaymentSheet();

      // Si llegamos aquí, el pago fue exitoso
      await _updatePremiumStatus();

      state = state.copyWith(
        isLoading: false,
        isPaymentSuccessful: true,
        errorMessage: null,
      );
    } catch (e) {
      if (e is StripeException) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: e.error.localizedMessage,
          isPaymentSuccessful: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
          isPaymentSuccessful: false,
        );
      }
    }
  }

  Future<void> _updatePremiumStatus() async {
    try {
      final token = await _storage.read(key: 'token');
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.post(
        '$baseUrl/update-user-is-premium-status/',
      );

      if (response.statusCode != 200) {
        throw 'Error al actualizar el estado premium';
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error al actualizar estado premium: ${e.toString()}',
      );
    }
  }

  void resetState() {
    state = StripeState(isLoading: false);
  }
}

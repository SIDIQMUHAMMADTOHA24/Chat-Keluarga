import 'package:bloc/bloc.dart';
import 'package:chat_keluarga/services/auth_service.dart';
import 'package:chat_keluarga/utils/storage_util.dart';
import 'package:equatable/equatable.dart'; // Tambahkan dependensi equatable

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Panggil login service
      final token = await AuthService.login(event.email, event.password);
      print('token = $token');
      if (token != "Login Failed") {
        // Simpan token ke SharedPreferences
        await StorageUtils.saveToken(token);
        emit(AuthSuccess(message: "Login berhasil!"));
      } else {
        emit(AuthFailure(message: "Login gagal. Periksa email atau password."));
      }
    } catch (e) {
      emit(AuthFailure(message: "Terjadi kesalahan: $e"));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await AuthService.register(event.email, event.password);
      if (token != "Register Failed" && !token.contains("Failed")) {
        await StorageUtils.saveToken(token);
        emit(AuthSuccess(message: "Registrasi berhasil!"));
      } else {
        emit(AuthFailure(message: token));
      }
    } catch (e) {
      emit(AuthFailure(message: "Terjadi kesalahan: $e"));
    }
  }
}

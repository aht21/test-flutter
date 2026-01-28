import 'package:bloc/bloc.dart';
import 'package:flutter_application/data/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServiceInterface authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.signUp(email: event.email, password: event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<LogInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.logIn(email: event.email, password: event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<LogOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.logOut();
        emit(AuthLoggedOut());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}

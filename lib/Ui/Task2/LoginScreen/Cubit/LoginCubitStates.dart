abstract class LoginCubitStates {}

class InitialState extends LoginCubitStates {}
class ButtonLoading extends LoginCubitStates {}
class LoginSuccessful extends LoginCubitStates {}
class ErrorState extends LoginCubitStates {
  String error;
  ErrorState({required this.error});
}
class LoginFailed extends LoginCubitStates {
  String error;
  LoginFailed({required this.error});
}
class LoginState extends LoginCubitStates {

}



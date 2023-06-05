abstract class CubitState {}

class InitialState extends CubitState {}
class TextHeading extends CubitState {
  String heading;
  String subHeading;
  TextHeading({required this.heading, required this.subHeading});
}



import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final int page;

  const SplashState({this.page = 0});

  SplashState copyWith({int? page}) => SplashState(page: page ?? this.page);

  @override
  List<Object?> get props => [page];
}

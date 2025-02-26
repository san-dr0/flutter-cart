import 'package:equatable/equatable.dart';

abstract class DomainState extends Equatable {}

class DomainAppStartedState extends DomainState {
  @override
  List<Object?> get props => [];
}

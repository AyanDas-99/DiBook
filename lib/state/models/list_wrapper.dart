import 'package:equatable/equatable.dart';

class ListWrapper extends Equatable {
  final List<String> items;

  ListWrapper(this.items);

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}

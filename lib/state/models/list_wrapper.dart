import 'package:equatable/equatable.dart';

class ListWrapper extends Equatable {
  final List<String> items;

  const ListWrapper(this.items);

  @override
  List<Object?> get props => [items];
}

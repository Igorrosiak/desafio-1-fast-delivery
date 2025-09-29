// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryController on _HistoryControllerBase, Store {
  late final _$addressHistoryAtom =
      Atom(name: '_HistoryControllerBase.addressHistory', context: context);

  @override
  ObservableList<Address> get addressHistory {
    _$addressHistoryAtom.reportRead();
    return super.addressHistory;
  }

  @override
  set addressHistory(ObservableList<Address> value) {
    _$addressHistoryAtom.reportWrite(value, super.addressHistory, () {
      super.addressHistory = value;
    });
  }

  late final _$_HistoryControllerBaseActionController =
      ActionController(name: '_HistoryControllerBase', context: context);

  @override
  void loadHistory() {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction(
        name: '_HistoryControllerBase.loadHistory');
    try {
      return super.loadHistory();
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
addressHistory: ${addressHistory}
    ''';
  }
}

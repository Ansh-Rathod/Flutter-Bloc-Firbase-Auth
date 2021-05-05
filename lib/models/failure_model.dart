import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Failure extends Equatable {
  final String code;
  final String msg;
  Failure({
    this.code,
    this.msg,
  });
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, msg];
}

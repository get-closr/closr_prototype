import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:closr_prototype/utils/simple_bloc_delegate.dart';

import 'closr_app.dart';

void main(){
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(ClosrApp());
}

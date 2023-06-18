import 'package:flutter/material.dart';

// Navigation

void navigateTo(
  BuildContext context, String route, 
  {bool shouldPopOldRoutes = false}
){

  final navigator = Navigator.of(context);

  if(shouldPopOldRoutes){
    navigator.pushNamedAndRemoveUntil(
      route, 
      (route) => false
    );
  }else{
    navigator.pushNamed(route);
  }
}

// Media Query

Size screenSizeOf(BuildContext context){
  return MediaQuery.of(context).size;
}


// Theme & ColorScheme

ColorScheme colorSchemeOf(BuildContext context){
  return Theme.of(context).colorScheme;
}

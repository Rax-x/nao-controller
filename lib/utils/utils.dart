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


// SnackBar

void showErrorSnackBar(BuildContext context, String error){
  final colorScheme = colorSchemeOf(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(10),
      elevation: 2,
      showCloseIcon: true,
      closeIconColor: colorScheme.onError,
      backgroundColor: colorScheme.error,
      content: Text(
        error, 
        style: TextStyle(
          color: colorScheme.onError
          )
        )
    )
  );
}
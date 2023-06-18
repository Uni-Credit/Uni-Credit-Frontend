





// Cor do container


import 'package:flutter/material.dart';

getContainerColorPositional(int x, int y) {

  if(x == 0) {

    if(y == 0) {
      return Colors.yellow;
    }

    return Colors.green;
  }

  return Colors.black;
}

getContainerColorNamed({int x=0, int y=0}) {

  if(x == 0) {

    if(y == 0) {
      return Colors.yellow;
    }

    return Colors.green;
  }

  return Colors.black;
}


// bool -> true/false
// condicao == true -> retorna 0
// condicao == false -> retorna 1
int retornarValor(bool condicao) {
  if(condicao) {
    return 0;
  }
  return 1;
}

// faz a mesma coisa, só que de forma resumida
int retornarValorComTernario(bool condicao) {
  return condicao ? 0 : 1;
}

// condicao == true -> retorna 0
// condicao == false -> retorna 0
int retornarSempreZero(bool condicao) {
  if(true) {
    return 0;
  }
  return 1;
}

int retornarSempreZeroTernario(bool condicao) {
  return true ? 0 : 1;
}
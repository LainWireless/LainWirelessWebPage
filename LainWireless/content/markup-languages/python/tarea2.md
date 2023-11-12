+++
title = "Python"
weight = 15
chapter = false
author = "Iván Piña Castillo"
tags = ["Python"]
description = "Enunciado de la segunda tarea de Pyhton."
readingTime = true
hideComments = true
+++

# Tarea 2

### Estructura alternativa

## Ejercicio 1

El programa debe pedir un número positivos al usuario y almacena la respuesta en la variable "numero". Después comprueba si el número es negativo. Si lo es, el programa avisa que no era eso lo que se había pedido. Finalmente, el programa imprime siempre el valor introducido por el usuario.

```python	
numero = float(input("Introduzca un número positivo: "))
if numero <= 0:
    print(("%.2f no es un número positivo. No es lo que se ha pedido.") %(numero))
else:
    if numero > 0:
        print(("%.2f es un número positivo.") %(numero))
```

## Ejercicio 2

El programa pregunta la edad al usuario y almacena la respuesta en la variable "edad". Después comprueba si la edad es inferior a 18 años. Si esta comparación es cierta, el programa escribe que es menor de edad y si es falsa escribe que es mayor de edad. Finalmente el programa siempre se despide, ya que la última instrucción está fuera de cualquier bloque y por tanto se ejecuta siempre.

```python
edad = int(input("Introduzca su edad: "))
if edad < 18:
    print("Usted es menor de edad.")
else:
    print("Usted es mayor de edad.")
print("Que tenga un buen día.")    
```

## Ejercicio 3

Programa que pide la edad y en función del valor recibido da un mensaje diferente. Podemos distinguir, por ejemplo, tres situaciones:

* si el valor es negativo, se trata de un error
* si el valor está entre 0 y 17, se trata de un menor de edad
* si el valor es superior o igual a 18, se trata de un mayor de edad

```python
edad = int(input("Introduzca su edad: "))
if edad < 0:
    print("La edad introducida se trata de un número negativo, ¿acaso usted ni siquiera ha sido gestado?")
elif edad >= 0 and edad <= 17:
    print("Usted es menor de edad.")
elif edad >=18:
    print("Usted es mayor de edad.")  
```

## Ejercicio 4

Programa que pide un valor y nos dice:

* si es múltiplo de dos
* si es múltiplo de cuatro (y de dos)
* si no es múltiplo de dos

```python
numero = int(input("Introduzca un número: "))
if numero % 4 == 0 and numero % 2 == 0:
    print ("El número es múltiplo de 4 y de 2.")
elif numero % 2 == 0:
    print ("El número es múltiplo de 2.")
else:
    if numero % 4 or numero % 2 != 0: 
        print ("No es múltiplo de 2.")  
```

## Ejercicio 5

Escriba un programa que simule el juego Piedra, papel, tijera para dos jugadores. El programa pide dos cadenas (PIEDRA, PAPEL o TIJERAS) para cada uno de los jugadores.

Las reglas del juego son las siguientes:

* El jugador que ha sacado Piedra gana al jugador que ha sacado Tijera.
* El jugador que ha sacado Tijera gana al jugador que ha sacado Papel.
* El jugador que ha sacado Papel gana al jugador que ha sacado Piedra.
* Si los dos sacan el mismo objeto es un empate.

```python
j1 = input ("Jugador 1 escoja, Piedra, Papel o Tijeras: ")
j2 = input ("Jugador 2 escoja, Piedra, Papel o Tijeras: ")

if j1 == "Piedra" and j2 == "Tijeras":
    print ("Jugador 1 gana.")
elif j1 == "Tijeras" and j2 == "Papel":
    print ("Jugador 1 gana.")
elif j1 == "Papel" and j2 == "Piedra":
    print ("Jugador 1 gana.")
elif j2 == "Piedra" and j1 == "Tijeras":
    print ("Jugador 2 gana.")
elif j2 == "Tijeras" and j1 == "Papel":
    print ("Jugador 2 gana.")
elif j2 == "Papel" and j1 == "Piedra":
    print ("Jugador 2 gana.")
else:
    if j1 and j2 == "Papel":
        print ("Empate.")
    elif j1 and j2 == "Piedra":
        print ("Empate.")
    elif j1 and j2 == "Tijeras":
        print ("Empate.")
    else:
        print ("Error.")
```
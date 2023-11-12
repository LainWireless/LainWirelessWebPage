+++
title = "Python"
weight = 15
chapter = false
author = "Iván Piña Castillo"
tags = ["Python"]
description = "Enunciado de la primera tarea de Pyhton."
readingTime = true
hideComments = true
+++

# Tarea 1

## Ejercicio 1

Diseñar el algoritmo correspondiente a un programa que lea el valor correspondiente a una distancia en millas marinas y las escriba expresadas en metros.

```python
numero = float(input("Introduzca un número positivo: "))
if numero <= 0:
    print(("%.2f no es un número positivo. No es lo que se ha pedido.") %(numero))
else:
    if numero > 0:
        print(("%.2f es un número positivo.") %(numero))
```

## Ejercicio 2

Escribir un programa que pida al usuario su peso (en kg) y estatura (en metros), calcule el índice de masa corporal y lo almacene en una variable, e imprima por pantalla la frase “Tu índice de masa corporal es…” y el resultado.

```python
edad = int(input("Introduzca su edad: "))
if edad < 18:
    print("Usted es menor de edad.")
else:
    print("Usted es mayor de edad.")
print("Que tenga un buen día.")    
```

## Ejercicio 3

Una juguetería tiene mucho éxito en dos de sus productos: payasos y muñecas. Suele hacer venta por correo y la empresa de logística les cobra por peso de cada paquete así que deben calcular el peso de los payasos y muñecas que saldrán en cada paquete a demanda. Cada payaso pesa 112 g y cada muñeca 75 g. Escribir un programa que lea el número de payasos y muñecas vendidos en el último pedido y calcule el peso total del paquete que será enviado. Además se nos pide el precio que se cobra por gramo, , y se nos mostrará el total de dinero que necesitamos para realizar el envío.

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

Diseñar el algoritmo correspondiente a un programa que pida el total de kilómetros recorridos, el precio de la gasolina (por litro), el consumo del coche (litros/100 km) y nos muestre la siguiente información:
* El total de litros de gasolina que ha gastado en el trayecto.
* ¿Cuánto dinero te ha costado la gasolina?

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

Suponiendo que una paella se puede cocinar exclusivamente con arroz y gambas, y que para cada cuatro personas se utiliza medio kilo de arroz y un cuarto de kilo de gambas, escribir un programa que pida por pantalla el número de comensales para la paella, el precio por kilo de los ingredientes y muestre las cantidades de los ingredientes necesarios y el coste de la misma.

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

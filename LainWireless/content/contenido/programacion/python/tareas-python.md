+++
title = "Python Tareas"
weight = 15
chapter = false
author = "Iván Piña Castillo"
tags = ["Python"]
description = "Documentación de mis tareas de Pyhton."
readingTime = true
hideComments = true
+++

# Tarea 1

### Ejercicios de estructura secuencial

## Ejercicio 1

Diseñar el algoritmo correspondiente a un programa que lea el valor correspondiente a una distancia en millas marinas y las escriba expresadas en metros.

```python
millas_marinas = float(input("Ingrese la distancia en millas marinas: "))
metros = millas_marinas * 1852  # 1 milla marina = 1852 metros
print(f"La distancia en metros es: {metros} metros")
```

## Ejercicio 2

Escribir un programa que pida al usuario su peso (en kg) y estatura (en metros), calcule el índice de masa corporal y lo almacene en una variable, e imprima por pantalla la frase “Tu índice de masa corporal es…” y el resultado.

```python
peso = float(input("Ingrese su peso en kg: "))
estatura = float(input("Ingrese su estatura en metros: "))

# Calcula el índice de masa corporal (IMC)
imc = peso / (estatura ** 2)

# Imprime el resultado
print(f"Tu índice de masa corporal es: {imc}")
```

## Ejercicio 3

Una juguetería tiene mucho éxito en dos de sus productos: payasos y muñecas. Suele hacer venta por correo y la empresa de logística les cobra por peso de cada paquete así que deben calcular el peso de los payasos y muñecas que saldrán en cada paquete a demanda. Cada payaso pesa 112 g y cada muñeca 75 g. Escribir un programa que lea el número de payasos y muñecas vendidos en el último pedido y calcule el peso total del paquete que será enviado. Además se nos pide el precio que se cobra por gramo, , y se nos mostrará el total de dinero que necesitamos para realizar el envío.

```python
payasos = int(input("Ingrese el número de payasos vendidos: "))
munecas = int(input("Ingrese el número de muñecas vendidas: "))
precio_por_gramo = float(input("Ingrese el precio por gramo: "))

# Peso de payaso y muñeca en gramos
peso_payaso = 112
peso_muneca = 75

# Calcula el peso total del paquete
peso_total = (payasos * peso_payaso + munecas * peso_muneca) / 1000

# Calcula el costo del envío
costo_envio = precio_por_gramo * peso_total

# Muestra los resultados
print(f"El peso total del paquete es: {peso_total} kg")
print(f"El costo total del envío es: {costo_envio} pesos")
```

## Ejercicio 4

Diseñar el algoritmo correspondiente a un programa que pida el total de kilómetros recorridos, el precio de la gasolina (por litro), el consumo del coche (litros/100 km) y nos muestre la siguiente información:

+ El total de litros de gasolina que ha gastado en el trayecto.
+ ¿Cuánto dinero te ha costado la gasolina?

```python
kilometros_recorridos = float(input("Ingrese el total de kilómetros recorridos: "))
precio_gasolina = float(input("Ingrese el precio de la gasolina por litro: "))
consumo_coche = float(input("Ingrese el consumo del coche en litros/100 km: "))

# Calcula el total de litros de gasolina gastados
litros_gasolina = (kilometros_recorridos * consumo_coche) / 100

# Calcula el costo total de la gasolina
costo_gasolina = litros_gasolina * precio_gasolina

# Muestra los resultados
print(f"Total de litros de gasolina gastados: {litros_gasolina} litros")
print(f"Costo total de la gasolina: {costo_gasolina} pesos")
```

## Ejercicio 5

Suponiendo que una paella se puede cocinar exclusivamente con arroz y gambas, y que para cada cuatro personas se utiliza medio kilo de arroz y un cuarto de kilo de gambas, escribir un programa que pida por pantalla el número de comensales para la paella, el precio por kilo de los ingredientes y muestre las cantidades de los ingredientes necesarios y el coste de la misma.

```python
comensales = int(input("Ingrese el número de comensales: "))
precio_arroz = float(input("Ingrese el precio por kilo de arroz: "))
precio_gambas = float(input("Ingrese el precio por kilo de gambas: "))

# Cantidades necesarias de arroz y gambas
arroz_por_persona = 0.5  # medio kilo por persona
gambas_por_persona = 0.25  # un cuarto de kilo por persona

# Calcula las cantidades totales
cantidad_arroz = comensales * arroz_por_persona
cantidad_gambas = comensales * gambas_por_persona

# Calcula el costo total
costo_total = (cantidad_arroz * precio_arroz) + (cantidad_gambas * precio_gambas)

# Muestra los resultados
print(f"Cantidad de arroz necesaria: {cantidad_arroz} kg")
print(f"Cantidad de gambas necesaria: {cantidad_gambas} kg")
print(f"Costo total de la paella: {costo_total} pesos")
```

# Tarea 2

### Ejercicios de estructura alternativa

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

+ Si el valor es negativo, se trata de un error.
+ Si el valor está entre 0 y 17, se trata de un menor de edad.
+ Si el valor es superior o igual a 18, se trata de un mayor de edad.

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

+ Si es múltiplo de dos.
+ Si es múltiplo de cuatro (y de dos).
+ Si no es múltiplo de dos.

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

+ El jugador que ha sacado Piedra gana al jugador que ha sacado Tijera.
+ El jugador que ha sacado Tijera gana al jugador que ha sacado Papel.
+ El jugador que ha sacado Papel gana al jugador que ha sacado Piedra.
+ Si los dos sacan el mismo objeto es un empate.

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

# Tarea 3

### Ejercicios de estructura repetitiva

## Ejercicio 1

Diseñar el algoritmo correspondiente a un programa que lea el valor correspondiente a una distancia en millas marinas y las escriba expresadas en metros.

```python
while True:
    num1 = int(input("Ingrese el primer número entero: "))
    num2 = int(input("Ingrese el segundo número entero (mayor que el primero): "))
    
    if num1 < num2:
        break
    else:
        print("Error: El segundo número debe ser mayor que el primero. Inténtelo de nuevo.")

suma = sum(range(num1, num2 + 1))
print(f"La suma de los enteros entre {num1} y {num2} es: {suma}")
```

## Ejercicio 2

Escribir un programa que pida al usuario su peso (en kg) y estatura (en metros), calcule el índice de masa corporal y lo almacene en una variable, e imprima por pantalla la frase “Tu índice de masa corporal es…” y el resultado.

```python
numeros = []
while True:
    num = int(input("Ingrese un número entero positivo (0 para finalizar): "))
    
    if num == 0:
        break
    
    numeros.append(num)

if numeros:
    cantidad = len(numeros)
    mayor = max(numeros)
    menor = min(numeros)
    media = sum(numeros) / cantidad

    print(f"Cantidad de números leídos: {cantidad}")
    print(f"El mayor número es: {mayor}")
    print(f"El menor número es: {menor}")
    print(f"La media de los números es: {media}")
else:
    print("No se introdujeron números.")
```

## Ejercicio 3

Una juguetería tiene mucho éxito en dos de sus productos: payasos y muñecas. Suele hacer venta por correo y la empresa de logística les cobra por peso de cada paquete así que deben calcular el peso de los payasos y muñecas que saldrán en cada paquete a demanda. Cada payaso pesa 112 g y cada muñeca 75 g. Escribir un programa que lea el número de payasos y muñecas vendidos en el último pedido y calcule el peso total del paquete que será enviado. Además se nos pide el precio que se cobra por gramo, , y se nos mostrará el total de dinero que necesitamos para realizar el envío.

```python
intentos = 3

while intentos > 0:
    usuario = input("Ingrese su nombre de usuario: ")
    contraseña = input("Ingrese su contraseña: ")

    if usuario == "root" and contraseña == "1234":
        print("Bienvenido al sistema.")
        break
    else:
        intentos -= 1
        if intentos > 0:
            print(f"Datos incorrectos. Le quedan {intentos} intentos.")
        else:
            print("Número de intentos agotado. Acceso denegado.")
```

## Ejercicio 4

Diseñar el algoritmo correspondiente a un programa que pida el total de kilómetros recorridos, el precio de la gasolina (por litro), el consumo del coche (litros/100 km) y nos muestre la siguiente información:

+ El total de litros de gasolina que ha gastado en el trayecto.

+ ¿Cuánto dinero te ha costado la gasolina?

```python
suma = 0
contador = 0

while contador < 10 and suma <= 100:
    num = int(input("Ingrese un número: "))
    suma += num
    contador += 1

if contador == 10:
    print("Se han introducido 10 números.")
else:
    print("La suma de los números supera 100.")
```

## Ejercicio 5

Suponiendo que una paella se puede cocinar exclusivamente con arroz y gambas, y que para cada cuatro personas se utiliza medio kilo de arroz y un cuarto de kilo de gambas, escribir un programa que pida por pantalla el número de comensales para la paella, el precio por kilo de los ingredientes y muestre las cantidades de los ingredientes necesarios y el coste de la misma.

```python
total_factura = 0

while True:
    cantidad = int(input("Ingrese la cantidad de unidades vendidas (0 para finalizar): "))
    
    if cantidad == 0:
        break
    
    precio_unitario = float(input("Ingrese el precio unitario del artículo: "))
    
    if cantidad > 0 and precio_unitario > 0:
        total_articulo = cantidad * precio_unitario
        total_factura += total_articulo
    else:
        print("Error: La cantidad y el precio deben ser números positivos. Inténtelo de nuevo.")

print(f"El importe total de la factura es: {total_factura}")
```

# Tarea 4

### Ejercicios de estructuras repetitivas y alternativas

## Ejercicio 1

Escriba un programa que pida el año actual y un año cualquiera y que escriba cuántos años han pasado desde ese año o cuántos años faltan para llegar a ese año. Se puede mejorar el programa haciendo que cuando la diferencia sea exactamente un año y escriba la frase en singular.

```python
from datetime import datetime

# Obtener el año actual
año_actual = datetime.now().year

# Solicitar el año al usuario
año_cualquiera = int(input("Ingrese un año cualquiera: "))

# Calcular la diferencia de años
diferencia_años = abs(año_actual - año_cualquiera)

# Determinar si la diferencia es singular o plural
pluralidad = "años" if diferencia_años != 1 else "año"

# Mostrar el resultado
if año_actual > año_cualquiera:
    print(f"Han pasado {diferencia_años} {pluralidad} desde {año_cualquiera}.")
elif año_actual < año_cualquiera:
    print(f"Faltan {diferencia_años} {pluralidad} para llegar a {año_cualquiera}.")
else:
    print("¡Estamos en el mismo año!")
```

## Ejercicio 2

### Juego de las multiplicaciones

## Apartado 1

Escriba un programa que genere una multiplicación de dos números del 2 al 10 al azar, pregunte por el resultado y diga si se ha dado la respuesta correcta.

Para generar números al azar puedes utilizar el siguiente código:

from random import randint
a = randint(2, 10)

## Apartado 2

Amplie el programa anterior haciendo que el programa pida primero al usuario cuántas multiplicaciones se van a plantear.

## Apartado 3

Amplíe el programa anterior haciendo que el programa lleve la cuenta de las respuestas correctas e incorrectas e indique la nota correspondiente. Si la nota es igual o mayor que 9, el programa felicitará al usuario por el resultado. 

**Ayuda:** La nota se calcula con la fórmula Nota=Correctas / Total * 10.

**NOTA: Tienes que entregar sólo el código del apartado 3.**

```python
from random import randint

# Inicializar variables para contar respuestas correctas e incorrectas
correctas = 0
incorrectas = 0

# Solicitar al usuario la cantidad de multiplicaciones
cantidad_multiplicaciones = int(input("Ingrese la cantidad de multiplicaciones que se plantearán: "))

# Generar y evaluar las multiplicaciones
for _ in range(cantidad_multiplicaciones):
    # Generar números al azar
    num1 = randint(2, 10)
    num2 = randint(2, 10)

    # Calcular la respuesta correcta
    respuesta_correcta = num1 * num2

    # Solicitar la respuesta al usuario
    respuesta_usuario = int(input(f"{num1} x {num2} = "))

    # Verificar la respuesta y actualizar contadores
    if respuesta_usuario == respuesta_correcta:
        print("¡Respuesta correcta!\n")
        correctas += 1
    else:
        print(f"Respuesta incorrecta. La respuesta correcta era {respuesta_correcta}.\n")
        incorrectas += 1

# Calcular la nota y mostrar el resultado
total_preguntas = correctas + incorrectas
nota = correctas / total_preguntas * 10

print(f"Respuestas correctas: {correctas}")
print(f"Respuestas incorrectas: {incorrectas}")
print(f"Nota: {nota:.2f}")

# Felicitar al usuario si la nota es igual o mayor que 9
if nota >= 9:
    print("¡Felicidades por tu excelente desempeño!")  
```

### Ejercicios de cadenas

## Ejercicio 3

Para calcular la letra del DNI se calcula el número del DNI módulo 23 y el resultado es la posición en la siguiente cadena:
```
'TRWAGMYFPDXBNJZSQVHLCKE'
```

Crea un programa que pida un DNI (valide que tiene 9 caracteres) y diga si es válido.

```python
dni = input("Ingrese el DNI (9 caracteres): ")

if len(dni) == 9 and dni[:-1].isdigit() and dni[-1].isalpha():
    letra_calculada = "TRWAGMYFPDXBNJZSQVHLCKE"[int(dni[:-1]) % 23]
    
    if letra_calculada == dni[-1].upper():
        print("El DNI es válido.")
    else:
        print("El DNI no es válido.")
else:
    print("El formato del DNI no es válido.") 
```

## Ejercicio 4

Realiza un programa que pida un cadena. A continuación debe pedir otra cadena. El programa debe buscar la segunda cadena en la primera (ignorando mayúsculas o minúsculas) y podrá responder una de las siguientes opciones:

+ La segunda cadena es una subcadena de la primera.

+ La segunda cadena no es una subcadena de la primera.

```python
cadena1 = input("Ingrese la primera cadena: ")
cadena2 = input("Ingrese la segunda cadena: ")

if cadena2.lower() in cadena1.lower():
    print("La segunda cadena es una subcadena de la primera.")
else:
    print("La segunda cadena no es una subcadena de la primera.")

```

## Ejercicio 5

Escribe una programa que pida una cadena de caracteres y diga si no tiene caracteres repetidos.

```python
cadena = input("Ingrese una cadena de caracteres: ")

if len(set(cadena)) == len(cadena):
    print("La cadena no tiene caracteres repetidos.")
else:
    print("La cadena tiene caracteres repetidos.")
```

# Tarea 5

### Ejercicios de listas

## Ejercicio 1

Pedir cadenas de caracteres y guardarlas en una lista (el programa pedirá al principio cuantas cadenas se van a introducir). A continuación se pide otra cadena, y hay que eliminar de la lista todas las apariciones de esta segunda cadena. Si se ha quitado algún elemento se muestra la lista, sino se informa que la segunda cadena no estaba en la lista.

```python
n = int(input("Ingrese cuántas cadenas va a introducir: "))
cadenas = []

# Pedir cadenas y guardarlas en la lista
for _ in range(n):
    cadena = input("Ingrese una cadena: ")
    cadenas.append(cadena)

# Pedir otra cadena para eliminar de la lista
cadena_eliminar = input("Ingrese otra cadena para eliminar de la lista: ")

# Eliminar todas las apariciones de la segunda cadena
cadenas = [c for c in cadenas if c != cadena_eliminar]

# Mostrar el resultado
if len(cadenas) > 0:
    print("Lista después de eliminar la cadena:")
    print(cadenas)
else:
    print(f"La cadena '{cadena_eliminar}' no estaba en la lista.")
```

## Ejercicio 2

Crear una lista con 10 número aleatorios (del 1 al 100). A continuación se muestra la lista. El programa seguirá mostrando el siguiente menú:

1. Sumar

2. Máximo

3. Media

4. Salir

Opción:

Al elegir una opción se realiza la operación:

+ Sumar: Muestra la suma de los números.

+ Máximo: Muestra el máximo de la lista.

+ Medía: Muestra la Media.

El menú se va repitiendo hasta que elegimos la opción 4 (Salir).

```python
from random import randint

# Crear una lista con 10 números aleatorios del 1 al 100
numeros = [randint(1, 100) for _ in range(10)]

while True:
    # Mostrar la lista
    print("Lista de números:", numeros)

    # Mostrar el menú
    print("\nMenú:")
    print("1. Sumar")
    print("2. Máximo")
    print("3. Media")
    print("4. Salir")

    # Solicitar opción al usuario
    opcion = int(input("Opción: "))

    if opcion == 1:
        suma = sum(numeros)
        print(f"Suma de los números: {suma}")
    elif opcion == 2:
        maximo = max(numeros)
        print(f"Máximo de la lista: {maximo}")
    elif opcion == 3:
        media = sum(numeros) / len(numeros)
        print(f"Media de los números: {media}")
    elif opcion == 4:
        print("¡Hasta luego!")
        break
    else:
        print("Opción no válida. Inténtelo de nuevo.")
```

## Ejercicio 3

Tenemos la siguiente variable definida en nuestro programa (esta variable puede tener cualquier valor, es decir, le podemos añadir nuevas ciudades con temperaturas):

temperaturas='''Utrera,29,12

Dos Hermanas,32,14

Sevilla,30,15

Alcalá de Guadaíra,31,14

'''

En esa cadena se definen nombres de poblaciones y las temperaturas máximas y mínimas de dichas poblaciones durante un día.

Realiza un programa que muestre el nombre de las poblaciones y la temperatura media. Además el programa te debe pedir el nombre de una población y nos debe dar la temperatura máxima y mínima (si la población no existe se debe dar une error.)

**Ayuda: Puede venir muy bien utilizar los métodos splitlines y split de cadenas.**

```python
temperaturas = '''Utrera,29,12
Dos Hermanas,32,14
Sevilla,30,15
Alcalá de Guadaíra,31,14
'''

# Dividir la cadena en líneas
lineas = temperaturas.splitlines()

# Inicializar diccionario para almacenar temperaturas medias
temperaturas_medias = {}

# Mostrar el nombre de las poblaciones y la temperatura media
for linea in lineas:
    datos = linea.split(',')
    ciudad = datos[0]
    temp_media = (int(datos[1]) + int(datos[2])) / 2
    temperaturas_medias[ciudad] = temp_media
    print(f"{ciudad}: Temperatura media = {temp_media:.2f}°C")

# Pedir el nombre de una población y mostrar temperatura máxima y mínima
ciudad_consulta = input("Ingrese el nombre de una población: ")

if ciudad_consulta in temperaturas_medias:
    temp_maxima = max(int(datos[1]) for datos in lineas if datos.startswith(ciudad_consulta))
    temp_minima = min(int(datos[2]) for datos in lineas if datos.startswith(ciudad_consulta))
    print(f"Temperatura máxima en {ciudad_consulta}: {temp_maxima}°C")
    print(f"Temperatura mínima en {ciudad_consulta}: {temp_minima}°C")
else:
    print("Error: Población no encontrada.")
```

## Ejercicio 4

Escriba un programa que permita crear una lista de palabras y que, a continuación de tres opciones:

+ Contar: Me pide una cadena, y me dice cuantas veces aparece en la lista.

+ Modificar: Me pide una cadena, y otra cadena a modificar, y modifica todas alas apariciones de la primera por la segunda en la lista.

+ Eliminar: Me pide una cadena, y la elimina de la lista.

El programa te muestra el menú, hasta que introduzcamos la opción 0 de salir.

```python
palabras = []

while True:
    # Mostrar el menú
    print("\nMenú:")
    print("1. Contar")
    print("2. Modificar")
    print("3. Eliminar")
    print("0. Salir")

    # Solicitar opción al usuario
    opcion = int(input("Opción: "))

    if opcion == 0:
        print("¡Hasta luego!")
        break
    elif opcion == 1:
        cadena_contar = input("Ingrese una cadena para contar: ")
        contador = palabras.count(cadena_contar)
        print(f"La cadena '{cadena_contar}' aparece {contador} veces en la lista.")
    elif opcion == 2:
        cadena_original = input("Ingrese una cadena a modificar: ")
        cadena_modificada = input("Ingrese la cadena modificada: ")
        palabras = [cadena_modificada if palabra == cadena_original else palabra for palabra in palabras]
        print("Lista modificada:", palabras)
    elif opcion == 3:
        cadena_eliminar = input("Ingrese una cadena para eliminar: ")
        palabras = [palabra for palabra in palabras if palabra != cadena_eliminar]
        print("Lista después de eliminar la cadena:", palabras)
    else:
        print("Opción no válida. Inténtelo de nuevo.")

    print("Lista actualizada:", palabras)
```

## Ejercicio 5

Vamos a crear un programa que tenga el siguiente menú:

+ Añadir número a la lista: Me pide un número de la lista y lo añade al final de la lista.
+ Añadir número de la lista en una posición: Me pide un número y una posición, y si la posición existe en la lista lo añade a ella (la posición se pide a partir de 1).
+ Longitud de la lista: te muestra el número de elementos de la lista.
+ Eliminar el último número: Muestra el último número de la lista y lo borra.
+ Eliminar un número: Pide una posición, y si la posición existe en la lista lo borra de ella (la posición se pide a partir de 1).
+ Contar números: Te pide un número y te dice cuantas apariciones hay en la lista.
+ Posiciones de un número: Te pide un número y te dice en que posiciones está (contando desde 1).
+ Mostrar números: Muestra los números de la lista
+ Salir

**Nota: Utilizar todos los métodos de las listas que sean necesarios.**

```python
numeros_lista = []

while True:
    # Mostrar el menú
    print("\nMenú:")
    print("1. Añadir número a la lista")
    print("2. Añadir número de la lista en una posición")
    print("3. Longitud de la lista")
    print("4. Eliminar el último número")
    print("5. Eliminar un número")
    print("6. Contar números")
    print("7. Posiciones de un número")
    print("8. Mostrar números")
    print("0. Salir")

    # Solicitar opción al usuario
    opcion = int(input("Opción: "))

    if opcion == 0:
        print("¡Hasta luego!")
        break
    elif opcion == 1:
        numero = int(input("Ingrese un número: "))
        numeros_lista.append(numero)
    elif opcion == 2:
        numero = int(input("Ingrese un número: "))
        posicion = int(input("Ingrese una posición (a partir de 1): "))
        if 1 <= posicion <= len(numeros_lista) + 1:
            numeros_lista.insert(posicion - 1, numero)
        else:
            print("Posición no válida. Inténtelo de nuevo.")
    elif opcion == 3:
        print(f"Longitud de la lista: {len(numeros_lista)}")
    elif opcion == 4:
        if numeros_lista:
            ultimo_numero = numeros_lista.pop()
            print(f"Último número eliminado: {ultimo_numero}")
        else:
            print("La lista está vacía.")
    elif opcion == 5:
        posicion = int(input("Ingrese una posición (a partir de 1) para eliminar un número: "))
        if 1 <= posicion <= len(numeros_lista):
            numero_eliminado = numeros_lista.pop(posicion - 1)
            print(f"Número en la posición {posicion} eliminado: {numero_eliminado}")
        else:
            print("Posición no válida. Inténtelo de nuevo.")
    elif opcion == 6:
        numero_contar = int(input("Ingrese un número para contar en la lista: "))
        contador = numeros_lista.count(numero_contar)
        print(f"El número {numero_contar} aparece {contador} veces en la lista.")
    elif opcion == 7:
        numero_posiciones = int(input("Ingrese un número para encontrar sus posiciones: "))
        posiciones = [i + 1 for i, num in enumerate(numeros_lista) if num == numero_posiciones]
        if posiciones:
            print(f"Posiciones del número {numero_posiciones}: {posiciones}")
        else:
            print(f"El número {numero_posiciones} no está en la lista.")
    elif opcion == 8:
        print("Números en la lista:", numeros_lista)
    else:
        print("Opción no válida. Inténtelo de nuevo.")
```



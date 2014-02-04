[-- Ejercicio 4 --](./ejercicio04.md)

----------------


## Ejercicios 5

### Comparar las prestaciones de un servidor web en una jaula y el mismo servidor en un contenedor. Usar nginx.

Para comparar las prestaciones entre una jaula y un contenedor, deberemos tener el mismo sistema operativo en ambos sistemas e intentar tener los dos bajo las mismas condiciones. A continuación deberemos instalar nginx en ambos sistemas. Una vez instalado nginx deberemos pasarle un benchmark a ambos sistemas y comparar los resultados.

(Estos resultados son visibles en el [ejercicio de Germán Martínez](https://github.com/germaaan/IV_GMM/blob/master/TEMA3/ejercicio05.md), quien, además, proporciona un script para obtener los resultados)

Con estos valores podemos comprobar que es más rápido ejecutar el proceso desde una jaula que desde un contenedor pues este último hace uso de una interfaz puente la cual provoca unos ligeros retrasos.


----------------

[-- Ejercicio 6 --](./ejercicio06.md)

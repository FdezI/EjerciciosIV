[-- Ejercicio 1 --](./ejercicio01.md)

-----------------------------


## Ejercicios 2
### Usando las tablas de precios de servicios de alojamiento en Internet y de proveedores de servicios en la nube, Comparar el coste durante un año de un ordenador con un procesador estándar (escogerlo de forma que sea el mismo tipo de procesador en los dos vendedores) y con el resto de las características similares (tamaño de disco duro equivalente a transferencia de disco duro) si la infraestructura comprada se usa sólo el 1% o el 10% del tiempo.

La comparación será de dos productos de la misma empresa (para así evitar diferencias de precios causados por el hecho de ser distintas empresas). Los servicios en cuestión son:

1. Servidor dedicado de 4 cores, 4 GB de RAM y 750GB de disco duro (49.99€/mes)
2. Servidor cloud dinámico de 4 cores, 4GB de RAM y 700GB de disco duro (0.15€/hora)

Ambos sistemas correrán un sistema Linux y ambos precios están sin IVA.

Teniendo en cuenta los tiempos de uso que se va a hacer (1% - 10% del tiempo contratado durante 1 año), se puede obtener:

Uso    | 1. Dedicado | 2. Dinámico
------ | :---------: | -------------------
1%     |   599.88€   | 0.15€ * 87.6h = 13.14€
10%    |   599.88€   | 0.15€ * 876h = 131.4€
45.65% |   599.88€   | 0.15 * 3999h =  599.8€
90%    |   599.88€   | 0.15 * 7884h = 1182.6€


Como se puede ver en la tabla anterior, para tiempos de uso del producto inferiores al 45.65% es más rentable el servidor cloud, mientras que para uso intensivos (superiores al 45.65%) es preferible hacer uso de un servidor dedicado.


-----------------------------

[-- Ejercicio 3 --](./ejercicio03.md)

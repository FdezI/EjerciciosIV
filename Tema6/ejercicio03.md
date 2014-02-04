[-- Ejercicio 2 --](./ejercicio02.md)

------------------

## Ejercicios 3

### Escribir en YAML la siguiente estructura de datos en JSON { uno: 'dos', tres: [ 4, 5, 'Seis', { siete: 8, nueve: [ 10, 11 ] } ] }

La sintaxis del formato JSON es mucho más flexible en cuanto a "visualización", puede ponerse todo en una línea o separarse por líneas sin influir en su sintaxis.

YAML, por el contrario, requiere que se use un formato de "visualización" concreto, siendo distinta la sintaxis a usar si se quiere poner en una sóla línea o en forma de "árbol":

En una línea:

    {uno: 'dos', tres: [4, 5, 'Seis', {siete: 8, nueve: [10, 11] } ] }

En árbol:

```
- uno: "dos" 
  tres: 
    - 4 
    - 5 
    - "Seis" 
    - 
      - siete: 8 
        nueve: 
          - 10 
          - 11
```

------------------

[-- Ejercicio 4 --](./ejercicio04.md)

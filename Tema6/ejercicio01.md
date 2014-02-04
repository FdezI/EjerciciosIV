[**-- Tema 5 --**](../Tema5)

------------------

## Ejercicios 1

### Instalar chef en la máquina virtual que vayamos a usar.

* Forma, habitualmente, más manejable:

        # apt-get install ruby1.9.1 ruby1.9.1-dev rubygems
        # gem install ohai chef

* Forma rápida:

        # curl -L https://www.opscode.com/chef/install.sh | bash

    En caso de no tener "curl" y no querer instalarlo:

        # wget -q https://www.opscode.com/chef/install.sh -O /tmp/chef && bash /tmp/chef

    > Cualquiera de los comandos anteriores puede ser ejecutado como súper usuario o como usuario estándar. Lo más habitual es instalarlo como súper usuario

------------------

[-- Ejercicio 2 --](./ejercicio02.md)

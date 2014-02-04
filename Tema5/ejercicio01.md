[**-- Tema 4 --**](../Tema4)

------------------

## Ejercicios 1

### Instalar los paquetes necesarios para usar KVM. Se pueden [seguir estas instrucciones](https://wiki.debian.org/KVM#Installation). Ya lo hicimos en el [primer tema](http://jj.github.io/IV/documentos/temas/Intro_concepto_y_soporte_fisico), pero volver a comprobar si nuestro sistema está preparado para ejecutarlo o hay que conformarse con la paravirtualización.

    # apt-get install qemu-kvm libvirt-bin

    $ kvm-ok

    # modprobe kvm-intel

> En caso de tener amd: `# modprobe kvm-amd`

------------------

[-- Ejercicio 2 --](./ejercicio02.md)

[-- Ejercicio 7 --](./ejercicio07.md)

------------------

## Ejercicios 8

### Configurar tu máquina virtual usando vagrant con el provisionador
ansible.

Modificamos el fichero [Vagrantfile](./vagrant/Vagrantfile) dejándolo:

```
Vagrant::Config.run do |config| 
  config.vm.box = "squeeze" 

  config.vm.provision "ansible" do |ansible| 
    ansible.playbook = "playbook.yml" 
    ansible.inventory_path = "hosts"
  end 

  config.vm.box_url = "http://dl.dropbox.com/u/54390273/vagrantboxes/Squeeze64_VirtualBox4.2.4.box" 

  config.vm.network :hostonly, "192.168.33.10" 
end
```

Y creamos un [playbook](./vagrant/playbook.yml) muy simple y básico (no vale la pena estructurar en varios ficheros):

```
- hosts: vagrant 
  sudo: yes 
  tasks: 
    - name: Instalar última versión de nginx 
      apt: name=nginx state=latest 
      notify: 
      - restart nginx 
  handlers: 
    - name: restart nginx 
      service: name=nginx state=restarted 
```

Sin olvidarnos de añadir el host a la lista de hosts "vagrant" (especificada en el playbook) al [fichero indicado](./vagrant/hosts) en el **Vagrantfile** (ruta relativa a éste):

    # echo -e "[vagrant]\n192.168.33.10 " >> hosts

De esta forma, ansible se encargará de instalar nginx y mantenerlo actualizado al ejecutar:

    $ vagrant provision

o al iniciar la máquina (`$ vagrant up`).

> La máquina provisionada necesita "python" para poder usar ansible.


------------------

[**-- Volver al repositorio --**](../)

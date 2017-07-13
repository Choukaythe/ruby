# A Virtual Machine for SImRuby students

## Introduction

Ce repository contient la VM de developpement que je vous recommande
fortement d'utiliser pendant la Semaine Immersive Ruby (SImRuby). Il
contient aussi des liens vers les specs des exercices de la semaine,
vers les slides des cours, ainsi que de la documentation pour vous
assister.

Note: Thank to the rails team for providing the original vagrant box.

## Dependances

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* Un cerveau repose et en etat de marche

* Pas mal de motivation

## Comment deployer la VM et s'y connecter

Building the virtual machine is this easy:

    host $ git clone https://github.com/emmanueldd/simruby.git
    host $ cd simruby
    host $ git submodule init
    host $ vagrant up

That's it.

Si la box de base n'est pas present, la commande va aller la
telecharger dans un premier temps, le setup prends quelques minutes
sur mon laptop, il peut etre plus long en fonctions de votre
connection et de votre machine.

Une fois cela fait, vous pouvez acceder a votre machine virtuelle de cette facon "

    host $ vagrant ssh
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)
    ...
    vagrant@simruby-devbox:~$

Vous etes maintenant en train d'executer un shell dans la machine
virtuelle. Vagrant est vraiment tres cool, il partage par defaut le
repertoire simruby ainsi que tous les sous-repertoires avec la VM,
vous pouvez y acceder en vous rendant dans le repertoire /vagrant

    vagrant@simruby-devbox:~$ cd /vagrant
    vagrant@simruby-devbox:/vagrant$ ls
    ruby  rails  puppet  README.md  slides  Vagrantfile

Le port 3000 (le port par defaut de rails) de l'hote est forward
(transfere) au port 3000 de la machine virtuelle. De cette maniere,
les applis rails de la machine virtuelles sont disponibles a cette
adresse sur l'hote: http://localhost:3000

## Mettre a jour le dossier

A cause de la facon dont sont organises les contenus (plusieurs petits
repos au lieu d'un gros) la mise a jour des contenus necessites 2
commandes au lieu d'une seule :

    host $ git pull orign master
    host $ git submodule update --recursive

## Tester mon travail

### Jour 1

    vagrant@simruby-devbox:~$ cd /vagrant/ruby
    [Bosser]
    vagrant@simruby-devbox:/vagrant/ruby$ rspec
    [...]
    [ Fail or Win ]

## What's In The Box

* Git

* RVM

* Ruby 2.0.0 (binary RVM install)

* Bundler

* SQLite3, MySQL, Postgres and Redis

* System dependencies for nokogiri, sqlite3, mysql, mysql2, and pg

* Databases and users needed to run the Active Record test suite

* Node.js for the asset pipeline

* Memcached

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* test within the virtual machine.

This workflow is convenient because in the host computer you normally have your editor of choice fine-tuned, Git configured, and SSH keys in place.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://vagrantup.com/v1/docs/index.html) for more information on Vagrant.

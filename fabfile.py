from fabric.api import put
from fabric.api import run
from fabric.api import sudo
from fabric.api import task

@task
def provisionServer():
    sudo('apt-get install apache2 -y')
    sudo('service apache2 restart')

@task
def deployIndex():
    put('index.html', '/var/www/html/index.html', use_sudo=True)
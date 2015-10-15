from fabric.api import put
from fabric.api import run
from fabric.api import sudo
from fabric.api import task

@task
def provisionServer():
    sudo('curl -L https://www.chef.io/chef/install.sh | sudo bash')
    
	run('rm -rf cookbooks/')
	run('mkdir -p cookbooks')
    
	put('trapache', 'cookbooks')
    run('ls -lah cookbooks')
	
    run('rm -rf cookbooks.tar.gz')
    run('tar cvzpf cookbooks.tar.gz cookbooks/')
	#put es como scp
	put('runlist.json', 'runlist.json')
	
	sudo('chef-solo -j runlist.json -r cookbooks.tar.gz')
	
@task
def deployIndex():
    put('index.html', '/var/www/html/index.html', use_sudo=True)
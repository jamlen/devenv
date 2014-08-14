# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'json'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

if not File.exists? './config.json'
	abort "ERROR: Missing a 'config.json' file"
end

setup = JSON.load(IO.read('./config.json'));

def bootstrap_args (setup)
	args = []
	args.push('-n', setup["git"]["user"]["name"])
	args.push('-e', setup["git"]["user"]["email"])
	if setup.has_key? "npm" and setup["npm"].has_key? "useSystemProxy" and setup["npm"]["useSystemProxy"] and ENV.has_key? "http_proxy"	
		args.push('-p', ENV['http_proxy']) 
	else
		args.push('-p', 'null') 
	end
	args.push('-r', setup["npm"]["registry"]) if setup.has_key? "npm" and setup["npm"].has_key? "registry"
	args
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "chef/debian-7.4"
	config.vm.network "private_network", ip: "192.168.56.2"
	config.vm.synced_folder '../dev/ess', '/src/ess'

	if setup.has_key? "npm" and setup["npm"].has_key? "registry"
		config.vm.provision :hosts do |hosts|
			hosts.add_host '172.19.3.16', ['esscontrol-npm.essdev.local', 'esscontrol-npm']
		end
	end

	if setup.has_key? "proxy" and setup["proxy"].has_key? "useSystemProxy" and setup["proxy"]["useSystemProxy"] and ENV.has_key? "http_proxy"
		config.proxy.http     = ENV['http_proxy']
		config.proxy.https    = ENV['https_proxy']
		config.proxy.no_proxy = ENV['no_proxy']
	end

	config.vm.provision :ventriloquist do |env|
		env.platforms << %w( nodejs-0.10 )
		env.packages << %w( tmux build-essential checkinstall exuberant-ctags curl python-pip vim-nox git-flow cmake dstat gnuplot gdb )
	end

	args = bootstrap_args setup
	config.vm.provision :shell, :path => "bootstrap.sh", :args => args
end

class docker-registry($port='8000', $ip='0.0.0.0'){
    include 'docker-registry::deps'
        
  if ! defined(Package['git']){package{'git':}}

  exec{'get_latest_stable_docker_registry':
            path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
            cwd=>'/usr/local/share',
            command => "git clone https://github.com/dotcloud/docker-registry.git",
            creates=>'/usr/local/share/docker-registry',
            provider=>'shell',
            logoutput => true,
        }->
        exec{'copy_config_file':
          path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
          cwd=>'/usr/local/share/docker-registry/config',
          command=>'cp config_sample.yml config.yml',
          provider=>'shell',
              require=>Exec['get_latest_stable_docker_registry'],
          creates=>'/usr/local/share/docker-registry/config.yml',
            
        }->
            # create a directory      
        file { '/tmp/registry':
          ensure => "directory",
          mode=> 777
        }->
       # exec{'pip_install_requirements':
        #  path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
         # provider=>'shell',
         # cwd=>'/usr/local/share/docker-registry',
         # command=>'pip install -r requirements.txt'
             # }->
          exec{'start_registry':
            path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
            provider=>'shell',
            logoutput=>true,
            command=>"gunicorn --access-logfile - --debug -k gevent -b $IP:$port -w 1 wsgi:application"
        }
}
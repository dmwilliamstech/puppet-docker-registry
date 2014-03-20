class docker-registry::deps{
    if ! defined(Package['python-devel']){package{'python-devel':}}
    if ! defined(Package['libevent-devel']){package{'libevent-devel':}}
    if ! defined(Package['openssl-devel']){package{'openssl-devel':}}
    if ! defined(Package['wget']){package{'wget':}}
    if ! defined(Package['python-setuptools']){package{'python-setuptools':}}
    if ! defined(Package['python-gevent']){package{'python-gevent':}}
    if ! defined(Package['python-gunicorn']){package{'python-gunicorn':}}
    if ! defined(Package['python-flask']){package{'python-flask':}}
    if ! defined(Package['python-werkzeug']){package{'python-werkzeug':}}
    if ! defined(Package['python-urllib3']){package{'python-urllib3':}}
    if ! defined(Package['python-six']){package{'python-six':}}
    if ! defined(Package['python-ordereddict']){package{'python-ordereddict':}}
    if ! defined(Package['python-chardet']){package{'python-chardet':}}
    if ! defined(Package['python-backports-ssl_match_hostname']){package{'python-backports-ssl_match_hostname':}}
    if ! defined(Package['python-backports']){package{'python-backports':}}
    if ! defined(Package['python-requests']){package{'python-requests':}}
    if ! defined(Package['python-redis']){package{'python-redis':}}
    if ! defined(Package['python-blinker']){package{'python-blinker':}}
    if ! defined(Package['python-yaml']){package{'python-yaml':}}
    if ! defined(Package['python-simplejson']){package{'python-simplejson':}}
    if ! defined(Package['python-backports-lzma']){package{'python-backports-lzma':}}
    if ! defined(Package['pyliblzma']){package{'pyliblzma':}}
    if ! defined(Package['Jinja2']){package{'Jinja2':}}
        exec{'easy_install_jinja2':
        path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
        command=>'easy_install Jinja2',
        provider=>shell
        }
        exec{'easy_install_rsa':
        path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
        command=>'easy_install rsa',
        provider=>shell
        }
         exec{'easy_install_pyasn1':
        path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
        command=>'easy_install pyasn1',
        provider=>shell
        }
    exec{'get_latest_pip':
        path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
        cwd=>'/usr/local/share',
        command => "wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py --no-check-certificate",
        creates=>'/usr/local/share/get-pip.py',
        provider=>'shell',
        logoutput => true,
    }
        exec{'install_latest_pip':
            path =>['/usr/bin', '/bin', '/usr/local/bin', '/usr/sbin'],
            cwd=>'/usr/local/share',
            command => "python get-pip.py",
            require=>Exec['get_latest_pip'],
            provider=>'shell',
            logoutput => true,
        }
}
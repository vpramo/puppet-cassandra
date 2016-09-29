class cassandra::install {

    if !defined (Package['java']) {
      package { 'java':
        ensure  => installed,
        name    => 'openjdk-7-jre'
      }
    }

    package { 'dsc':
        ensure  => $cassandra::version,
        name    => $cassandra::package_name,
        require => Package['java']
    }

    $python_cql_name = $::osfamily ? {
        'Debian'    => 'python-cql',
        'RedHat'    => 'python26-cql',
        default     => 'python-cql',
    }

    package { $python_cql_name:
        ensure => installed,
    }

    if ($::osfamily == 'Debian') {
        file { 'CASSANDRA-2356 /etc/cassandra':
            ensure => directory,
            path   => '/etc/cassandra',
            owner  => 'root',
            group  => 'root',
            mode   => '0755',
        }

        exec { 'Fix_cassandra_env':
               command => 'sed -i -e \'s/JVM_PATCH_VERSION\" \\</JVM_PATCH_VERSION\" \-lt/g\' /etc/cassandra/cassandra-env.sh ',
               onlyif => "cat /etc/cassandra/cassandra-env.sh | grep 'JVM_PATCH_VERSION\" \\\<'"
            }

        exec { 'CASSANDRA-2356 Workaround':
            path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
            command => '/etc/init.d/cassandra stop && rm -rf /var/lib/cassandra/*',
            creates => '/etc/cassandra/CASSANDRA-2356',
            user    => 'root',
            require => [
                    Package['dsc'],
                    Exec['Fix_cassandra_env'],
                    File['CASSANDRA-2356 /etc/cassandra'],
                ],
        }
        file { 'CASSANDRA-2356 marker file':
            ensure  => file,
            path    => '/etc/cassandra/CASSANDRA-2356',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => '# Workaround for CASSANDRA-2356',
            require => [
                    File['CASSANDRA-2356 /etc/cassandra'],
                    Exec['CASSANDRA-2356 Workaround'],
                ],
        }
    }
}

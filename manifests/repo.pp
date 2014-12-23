class cassandra::repo (
    $repo_name,
    $baseurl,
    $gpgkey,
    $repos,
    $key_id,
    $release,
    $pin,
    $gpgcheck,
    $enabled,
){
    case $::osfamily {
        'Debian': {
            class { 'cassandra::repo::debian':
                repo_name    => $repo_name,
                location     => $baseurl,
                repos        => $repos,
                release      => $release,
                key          => $key_id,
                key_source   => $gpgkey,
                pin          => $pin,
                before       => Anchor['cassandra::repo::end'],
                require      => Anchor['cassandra::repo::begin'],
            }
        }
        'RedHat': {
            class { 'cassandra::repo::redhat':
                repo_name => $repo_name,
                baseurl   => $baseurl,
                gpgkey    => $gpgkey,
                gpgcheck  => $gpgcheck,
                enabled   => $enabled,
                before    => Anchor['cassandra::repo::end'],
                require   => Anchor['cassandra::repo::begin'],
            }
        }
        default: {
            fail("OS family ${::osfamily} not supported")
        }
    }

    anchor {'cassandra::repo::begin': } -> anchor {'cassandra::repo::end': }
}

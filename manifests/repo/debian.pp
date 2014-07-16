class cassandra::repo::debian(
    $repo_name,
    $location,
    $repos,
    $key,
    $release,
    $key_source,
    $pin,
) {
    apt::source { $repo_name:
        location    => $location,
        release     => $release,
        repos       => $repos,
        key         => $key,
        key_source  => $key_source,
        pin         => $pin,
        include_src => false,
    }

    # pin the package
    # see https://github.com/msimonin/puppet-cassandra/issues/2

    # in case of dsc 1.2.6-1 -> pin cassandra to 1.2.6
    if $cassandra::version != installed {
      $version_pin = regsubst($cassandra::version, '-.*$', '')
      notice("cassandra will be pinned to ${version_pin}")

      apt::pin { "hold_cassandra_at_${version_pin}":
        packages => "cassandra",
        version  => $version_pin,
        priority => 1001,
      }
    }

}

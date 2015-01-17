class cassandra(
    $package_name                           = $cassandra::params::package_name,
    $version                                = $cassandra::params::version,
    $service_name                           = $cassandra::params::service_name,
    $config_path                            = $cassandra::params::config_path,
    $include_repo                           = $cassandra::params::include_repo,
    $repo_name                              = $cassandra::params::repo_name,
    $repo_baseurl                           = $cassandra::params::repo_baseurl,
    $repo_gpgkey                            = $cassandra::params::repo_gpgkey,
    $repo_repos                             = $cassandra::params::repo_repos,
    $repo_key_id                            = $cassandra::params::repo_key_id,
    $repo_release                           = $cassandra::params::repo_release,
    $repo_pin                               = $cassandra::params::repo_pin,
    $repo_gpgcheck                          = $cassandra::params::repo_gpgcheck,
    $repo_enabled                           = $cassandra::params::repo_enabled,
    $max_heap_size                          = $cassandra::params::max_heap_size,
    $heap_newsize                           = $cassandra::params::heap_newsize,
    $jmx_port                               = $cassandra::params::jmx_port,
    $additional_jvm_opts                    = $cassandra::params::additional_jvm_opts,
    $cluster_name                           = $cassandra::params::cluster_name,
    $listen_address                         = $cassandra::params::listen_address,
    $broadcast_address                      = $cassandra::params::broadcast_address,
    $authenticator                          = $cassandra::params::authenticator,
    $authorizer                             = $cassandra::params::authorizer,
    $start_native_transport                 = $cassandra::params::start_native_transport,
    $start_rpc                              = $cassandra::params::start_rpc,
    $rpc_address                            = $cassandra::params::rpc_address,
    $rpc_port                               = $cassandra::params::rpc_port,
    $rpc_server_type                        = $cassandra::params::rpc_server_type,
    $rpc_min_threads                        = $cassandra::params::rpc_min_threads,
    $rpc_max_threads                        = $cassandra::params::rpc_max_threads,
    $native_transport_port                  = $cassandra::params::native_transport_port,
    $storage_port                           = $cassandra::params::storage_port,
    $partitioner                            = $cassandra::params::partitioner,
    $data_file_directories                  = $cassandra::params::data_file_directories,
    $commitlog_directory                    = $cassandra::params::commitlog_directory,
    $saved_caches_directory                 = $cassandra::params::saved_caches_directory,
    $initial_token                          = $cassandra::params::initial_token,
    $num_tokens                             = $cassandra::params::num_tokens,
    $seeds                                  = $cassandra::params::seeds,
    $concurrent_reads                       = $cassandra::params::concurrent_reads,
    $concurrent_writes                      = $cassandra::params::concurrent_writes,
    $incremental_backups                    = $cassandra::params::incremental_backups,
    $snapshot_before_compaction             = $cassandra::params::snapshot_before_compaction,
    $auto_snapshot                          = $cassandra::params::auto_snapshot,
    $multithreaded_compaction               = $cassandra::params::multithreaded_compaction,
    $endpoint_snitch                        = $cassandra::params::endpoint_snitch,
    $internode_compression                  = $cassandra::params::internode_compression,
    $disk_failure_policy                    = $cassandra::params::disk_failure_policy,
    $thread_stack_size                      = $cassandra::params::thread_stack_size,
    $service_enable                         = $cassandra::params::service_enable,
    $service_ensure                         = $cassandra::params::service_ensure,
    $server_encryption_internode            = $cassandra::params::server_encryption_internode,
    $server_encryption_require_auth         = $cassandra::params::server_encryption_require_auth,
    $server_encryption_keystore             = $cassandra::params::server_encryption_keystore,
    $server_encryption_keystore_password    = $cassandra::params::server_encryption_keystore_password,
    $server_encryption_truststore           = $cassandra::params::server_encryption_truststore,
    $server_encryption_truststore_password  = $cassandra::params::server_encryption_truststore_password,
    $server_encryption_cipher_suites        = $cassandra::params::server_encryption_cipher_suites,
    $client_encryption_enabled              = $cassandra::params::client_encryption_enabled,
    $client_encryption_require_auth         = $cassandra::params::client_encryption_require_auth,
    $client_encryption_keystore             = $cassandra::params::client_encryption_keystore,
    $client_encryption_keystore_password    = $cassandra::params::client_encryption_keystore_password,
    $client_encryption_truststore           = $cassandra::params::client_encryption_truststore,
    $client_encryption_truststore_password  = $cassandra::params::client_encryption_truststore_password,
    $client_encryption_cipher_suites        = $cassandra::params::client_encryption_cipher_suites,

) inherits cassandra::params {
    # Validate input parameters
    validate_bool($include_repo)
    validate_absolute_path($commitlog_directory)
    validate_absolute_path($saved_caches_directory)

    validate_string($cluster_name)
    validate_string($partitioner)
    validate_string($initial_token)
    validate_string($endpoint_snitch)

    validate_re($version, '\d*\.\d*\.\d*', 'The version should be x.y.z')
    validate_re($start_rpc, '^(true|false)$')
    validate_re($start_native_transport, '^(true|false)$')
    validate_re($rpc_server_type, '^(hsha|sync|async)$')
    validate_re($incremental_backups, '^(true|false)$')
    validate_re($snapshot_before_compaction, '^(true|false)$')
    validate_re($auto_snapshot, '^(true|false)$')
    validate_re($multithreaded_compaction, '^(true|false)$')
    validate_re("${concurrent_reads}", '^[0-9]+$')
    validate_re("${concurrent_writes}", '^[0-9]+$')
    validate_re("${num_tokens}", '^[0-9]+$')
    validate_re($internode_compression, '^(all|dc|none)$')
    validate_re($disk_failure_policy, '^(stop|best_effort|ignore)$')
    validate_re("${thread_stack_size}", '^[0-9]+$')
    validate_re($service_enable, '^(true|false)$')
    validate_re($service_ensure, '^(running|stopped)$')

    validate_array($additional_jvm_opts)
    validate_array($seeds)
    validate_array($data_file_directories)

    validate_re($server_encryption_internode, '^all|none|dc|rack$')
    validate_string($server_encryption_keystore)
    validate_string($server_encryption_keystore_password)
    validate_string($server_encryption_truststore)
    validate_string($server_encryption_truststore_password)
    validate_array($server_encryption_cipher_suites)

    validate_bool($client_encryption_enabled)
    validate_bool($client_encryption_require_auth)
    validate_string($client_encryption_keystore)
    validate_string($client_encryption_keystore_password)
    validate_string($client_encryption_truststore)
    validate_string($client_encryption_truststore_password)
    validate_array($client_encryption_cipher_suites)

    if(!is_integer($jmx_port)) {
        fail('jmx_port must be a port number between 1 and 65535')
    }

    if(!is_ip_address($listen_address)) {
        fail('listen_address must be an IP address')
    }

    if(!empty($broadcast_address) and !is_ip_address($broadcast_address)) {
        fail('broadcast_address must be an IP address')
    }

    if(!is_ip_address($rpc_address)) {
        fail('rpc_address must be an IP address')
    }

    if(!is_integer($rpc_port)) {
        fail('rpc_port must be a port number between 1 and 65535')
    }

    if(!is_integer($native_transport_port)) {
        fail('native_transport_port must be a port number between 1 and 65535')
    }

    if(!is_integer($storage_port)) {
        fail('storage_port must be a port number between 1 and 65535')
    }

    if(!is_integer($rpc_min_threads)) {
        fail('rpc_min_threads must be a nonnegative integer')
    }

    if(!is_integer($rpc_max_threads)) {
        fail('rpc_max_threads must be a nonnegative integer')
    }

    if(empty($seeds)) {
        fail('seeds must not be empty')
    }

    if(empty($data_file_directories)) {
        fail('data_file_directories must not be empty')
    }

    if(!empty($initial_token)) {
        notice("Starting with Cassandra 1.2 you shouldn't set an initial_token but set num_tokens accordingly.")
    }

    # Anchors for containing the implementation class
    anchor { 'cassandra::begin': }

    if($include_repo) {
        class { 'cassandra::repo':
            repo_name => $repo_name,
            baseurl   => $repo_baseurl,
            key_id    => $repo_key_id,
            gpgkey    => $repo_gpgkey,
            repos     => $repo_repos,
            release   => $repo_release,
            pin       => $repo_pin,
            gpgcheck  => $repo_gpgcheck,
            enabled   => $repo_enabled,
        }
        Class['cassandra::repo'] -> Class['cassandra::install']
    }

    include cassandra::install

    $version_config = $cassandra::version ? {
      default   =>  regsubst($cassandra::version, '^(\d\.\d+).*$', '\1'),
      /^1/      =>  regsubst($cassandra::version, '\..*$', ''),
    }

    class { 'cassandra::config':
        version                               => $version_config,
        config_path                           => $config_path,
        max_heap_size                         => $max_heap_size,
        heap_newsize                          => $heap_newsize,
        jmx_port                              => $jmx_port,
        additional_jvm_opts                   => $additional_jvm_opts,
        cluster_name                          => $cluster_name,
        start_native_transport                => $start_native_transport,
        start_rpc                             => $start_rpc,
        listen_address                        => $listen_address,
        broadcast_address                     => $broadcast_address,
        authenticator                         => $authenticator,
        authorizer                            => $authorizer,
        rpc_address                           => $rpc_address,
        rpc_port                              => $rpc_port,
        rpc_server_type                       => $rpc_server_type,
        rpc_min_threads                       => $rpc_min_threads,
        rpc_max_threads                       => $rpc_max_threads,
        native_transport_port                 => $native_transport_port,
        storage_port                          => $storage_port,
        partitioner                           => $partitioner,
        data_file_directories                 => $data_file_directories,
        commitlog_directory                   => $commitlog_directory,
        saved_caches_directory                => $saved_caches_directory,
        initial_token                         => $initial_token,
        num_tokens                            => $num_tokens,
        seeds                                 => $seeds,
        concurrent_reads                      => $concurrent_reads,
        concurrent_writes                     => $concurrent_writes,
        incremental_backups                   => $incremental_backups,
        snapshot_before_compaction            => $snapshot_before_compaction,
        auto_snapshot                         => $auto_snapshot,
        multithreaded_compaction              => $multithreaded_compaction,
        endpoint_snitch                       => $endpoint_snitch,
        internode_compression                 => $internode_compression,
        disk_failure_policy                   => $disk_failure_policy,
        thread_stack_size                     => $thread_stack_size,
        server_encryption_internode           => $server_encryption_internode,
        server_encryption_require_auth        => $server_encryption_require_auth,
        server_encryption_keystore            => $server_encryption_keystore,
        server_encryption_keystore_password   => $server_encryption_keystore_password,
        server_encryption_truststore          => $server_encryption_truststore,
        server_encryption_truststore_password => $server_encryption_truststore_password,
        server_encryption_cipher_suites       => $server_encryption_cipher_suites,
        client_encryption_enabled             => $client_encryption_enabled,
        client_encryption_keystore            => $client_encryption_keystore,
        client_encryption_keystore_password   => $client_encryption_keystore_password,
        client_encryption_require_auth        => $client_encryption_require_auth,
        client_encryption_truststore          => $client_encryption_truststore,
        client_encryption_truststore_password => $client_encryption_truststore_password,
        client_encryption_cipher_suites       => $client_encryption_cipher_suites,
}


    class { 'cassandra::service':
        service_enable => $service_enable,
        service_ensure => $service_ensure,
    }

    anchor { 'cassandra::end': }

    Anchor['cassandra::begin'] -> Class['cassandra::install'] -> Class['cassandra::config'] ~> Class['cassandra::service'] -> Anchor['cassandra::end']
}

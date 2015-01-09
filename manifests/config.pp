class cassandra::config(
    $version,
    $config_path,
    $max_heap_size,
    $heap_newsize,
    $jmx_port,
    $additional_jvm_opts,
    $cluster_name,
    $start_native_transport,
    $start_rpc,
    $listen_address,
    $broadcast_address,
    $authenticator,
    $authorizer,
    $rpc_address,
    $rpc_port,
    $rpc_server_type,
    $rpc_min_threads,
    $rpc_max_threads,
    $native_transport_port,
    $storage_port,
    $partitioner,
    $data_file_directories,
    $commitlog_directory,
    $saved_caches_directory,
    $initial_token,
    $num_tokens,
    $seeds,
    $concurrent_reads,
    $concurrent_writes,
    $incremental_backups,
    $snapshot_before_compaction,
    $auto_snapshot,
    $multithreaded_compaction,
    $endpoint_snitch,
    $internode_compression,
    $disk_failure_policy,
    $thread_stack_size,
    $server_encryption_internode,
    $server_encryption_require_auth,
    $server_encryption_keystore,
    $server_encryption_keystore_password,
    $server_encryption_truststore,
    $server_encryption_truststore_password,
    $server_encryption_cipher_suites,
    $client_encryption_enabled,
    $client_encryption_keystore,
    $client_encryption_keystore_password,
    $client_encryption_require_auth,
    $client_encryption_truststore,
    $client_encryption_truststore_password,
    $client_encryption_cipher_suites,
) {
    group { 'cassandra':
        ensure  => present,
        require => Class['Cassandra::Install'],
    }

    user { 'cassandra':
        ensure  => present,
        require => Group['cassandra'],
    }

    File {
        owner   => 'cassandra',
        group   => 'cassandra',
        mode    => '0644',
        require => Class['Cassandra::Install'],
    }

    file { $data_file_directories:
        ensure  => directory,
    }

    file { "${config_path}/cassandra-env.sh":
        ensure  => file,
        content => template("${module_name}/cassandra-env${version}.sh.erb"),
    }
    file { "${config_path}/cassandra.yaml":
        ensure  => file,
        content => template("${module_name}/cassandra${version}.yaml.erb"),
    }

}

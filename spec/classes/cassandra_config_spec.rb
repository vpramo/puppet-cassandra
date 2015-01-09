require 'spec_helper'

describe 'cassandra::config' do
  describe 'with supported os Debian' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end
  let(:params) do
    {
      :version                                => '2.1',
      :config_path                            => '/etc/cassandra',
      :max_heap_size                          => '',
      :heap_newsize                           => '',
      :jmx_port                               => 7199,
      :additional_jvm_opts                    => [],
      :cluster_name                           => 'Cassandra',
      :listen_address                         => '1.2.3.4',
      :broadcast_address                      => '4.3.2.1',
      :authenticator                          => 'AllowAllAuthenticator',
      :authorizer                             => 'AllowAllAuthorizer',
      :rpc_address                            => '0.0.0.0',
      :rpc_port                               => 9160,
      :rpc_server_type                        => 'hsha',
      :rpc_min_threads                        => 12,
      :rpc_max_threads                        => 12345,
      :storage_port                           => 7000,
      :partitioner                            => 'org.apache.cassandra.dht.Murmur3Partitioner',
      :data_file_directories                  => ['/var/lib/cassandra/data'],
      :commitlog_directory                    => '/var/lib/cassandra/commitlog',
      :saved_caches_directory                 => '/var/lib/cassandra/saved_caches',
      :initial_token                          => '',
      :seeds                                  => ['1.2.3.4'],
      :concurrent_reads                       => 32,
      :concurrent_writes                      => 32,
      :incremental_backups                    => 'false',
      :snapshot_before_compaction             => 'false',
      :auto_snapshot                          => 'true',
      :multithreaded_compaction               => 'false',
      :endpoint_snitch                        => 'SimpleSnitch',
      :internode_compression                  => 'all',
      :disk_failure_policy                    => 'stop',
      :start_native_transport                 => 'true',
      :start_rpc                              => 'true',
      :native_transport_port                  => 9042,
      :num_tokens                             => 256,
      :thread_stack_size                      => 180,
      :server_encryption_internode            => 'rack',
      :server_encryption_require_auth         => false,
      :server_encryption_keystore             => 'foo',
      :server_encryption_keystore_password    => 'foo',
      :server_encryption_truststore           => 'foo',
      :server_encryption_truststore_password  => 'foo',
      :server_encryption_cipher_suites        => ['foo'],
      :client_encryption_enabled              => false,
      :client_encryption_keystore             => 'foo',
      :client_encryption_keystore_password    => 'foo',
      :client_encryption_require_auth         => false,
      :client_encryption_truststore           => 'foo',
      :client_encryption_truststore_password  => 'foo',
      :client_encryption_cipher_suites        => [],
    }
  end

  it 'does contain group cassandra' do
    should contain_group('cassandra').with({
      :ensure  => 'present',
      :require => 'Class[Cassandra::Install]',
    })
  end

  it 'does contain user cassandra' do
    should contain_user('cassandra').with({
      :ensure  => 'present',
      :require => 'Group[cassandra]',
    })
  end

  it 'does contain file /etc/cassandra/cassandra-env.sh' do
    should contain_file('/etc/cassandra/cassandra-env.sh').with({
      :content  => /CASSANDRA 2\.1/,
      :ensure   => 'file',
      :owner    => 'cassandra',
      :group    => 'cassandra',
      :mode     => '0644',
      :content  => /MAX_HEAP_SIZE/,
    })
  end

  it 'does contain file /etc/cassandra/cassandra.yaml' do
    should contain_file('/etc/cassandra/cassandra.yaml').with({
      :content => /CASSANDRA 2\.1/,
      :ensure  => 'file',
      :owner   => 'cassandra',
      :group   => 'cassandra',
      :mode    => '0644',
      :content => /cluster_name: 'Cassandra'/,
    })
  end
  end

  describe 'with supported os RedHat' do
    let :facts do
      {
        :osfamily => 'Redhat'
      }
    end
  let(:params) do
    {
      :version                                => 4.6,
      :config_path                            => '/etc/cassandra/conf',
      :max_heap_size                          => '',
      :heap_newsize                           => '',
      :jmx_port                               => 7199,
      :additional_jvm_opts                    => [],
      :cluster_name                           => 'Cassandra',
      :listen_address                         => '1.2.3.4',
      :broadcast_address                      => '4.3.2.1',
      :authenticator                          => 'AllowAllAuthenticator',
      :authorizer                             => 'AllowAllAuthorizer',
      :rpc_address                            => '0.0.0.0',
      :rpc_port                               => 9160,
      :rpc_server_type                        => 'hsha',
      :rpc_min_threads                        => 12,
      :rpc_max_threads                        => 12345,
      :storage_port                           => 7000,
      :partitioner                            => 'org.apache.cassandra.dht.Murmur3Partitioner',
      :data_file_directories                  => ['/var/lib/cassandra/data'],
      :commitlog_directory                    => '/var/lib/cassandra/commitlog',
      :saved_caches_directory                 => '/var/lib/cassandra/saved_caches',
      :initial_token                          => '',
      :seeds                                  => ['1.2.3.4'],
      :concurrent_reads                       => 32,
      :concurrent_writes                      => 32,
      :incremental_backups                    => 'false',
      :snapshot_before_compaction             => 'false',
      :auto_snapshot                          => 'true',
      :multithreaded_compaction               => 'false',
      :endpoint_snitch                        => 'SimpleSnitch',
      :internode_compression                  => 'all',
      :disk_failure_policy                    => 'stop',
      :start_native_transport                 => 'true',
      :start_rpc                              => 'true',
      :native_transport_port                  => 9042,
      :num_tokens                             => 256,
      :thread_stack_size                      => 128,
      :server_encryption_internode            => 'all',
      :server_encryption_require_auth         => true,
      :server_encryption_keystore             => 'foo',
      :server_encryption_keystore_password    => 'foo',
      :server_encryption_truststore           => 'foo',
      :server_encryption_truststore_password  => 'foo',
      :server_encryption_cipher_suites        => ['bananacipher', 'applecipher'],
      :client_encryption_enabled              => true,
      :client_encryption_keystore             => 'foo',
      :client_encryption_keystore_password    => 'foo',
      :client_encryption_require_auth         => true,
      :client_encryption_truststore           => 'foo',
      :client_encryption_truststore_password  => 'foo',
      :client_encryption_cipher_suites        => ['clientcipher'],
    }
  end
  it 'does contain group cassandra' do
    should contain_group('cassandra').with({
      :ensure  => 'present',
      :require => 'Class[Cassandra::Install]',
    })
  end

  it 'does contain user cassandra' do
    should contain_user('cassandra').with({
      :ensure  => 'present',
      :require => 'Group[cassandra]',
    })
  end

  it 'does contain file /etc/cassandra/conf/cassandra-env.sh' do
    should contain_file('/etc/cassandra/conf/cassandra-env.sh').with({
      :content => /CASSANDRA 1/,
      :ensure  => 'file',
      :owner   => 'cassandra',
      :group   => 'cassandra',
      :mode    => '0644',
      :content => /MAX_HEAP_SIZE/,
    })
  end

  it 'does contain file /etc/cassandra/conf/cassandra.yaml' do
    should contain_file('/etc/cassandra/conf/cassandra.yaml').with({
      :content => /CASSANDRA 1/,
      :ensure  => 'file',
      :owner   => 'cassandra',
      :group   => 'cassandra',
      :mode    => '0644',
      :content => /cluster_name: 'Cassandra'/,
    }).with_content(/cipher_suites: \[bananacipher,applecipher\]/).with({
      :content => /cipher_suites: \[clientcipher\]/,
    })
  end
  end

end

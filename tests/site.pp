node 'seed1' {
  class { 'cassandra':
    cluster_name   => 'testCassandra',
    package_name   => 'cassandra',
    seeds          => [ '192.168.100.2', '192.168.100.3'],
    version        => '2.0.9',
    listen_address => "192.168.100.2"
  }
}

node 'seed2' {
  class { 'cassandra':
    cluster_name   => 'testCassandra',
    package_name   => 'cassandra',
    seeds          => [ '192.168.100.2', '192.168.100.3'],
    version        => '2.0.9',
    listen_address => "192.168.100.3"
  }
}

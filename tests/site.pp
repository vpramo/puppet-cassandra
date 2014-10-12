node 'seed1' {
  class { 'cassandra':
    cluster_name   => 'testCassandra',
    package_name   => 'cassandra',
    seeds          => [ '192.168.100.2'],
    version        => "2.0.1",
    listen_address => "192.168.100.2",
    rpc_address => "192.168.100.2"
  }
}


node 'node1' {
  class { 'cassandra':
    cluster_name   => 'testCassandra',
    package_name   => 'cassandra',
    seeds          => [ '192.168.100.2'],
    version        => "2.0.1",
    listen_address => "192.168.100.3",
    rpc_address => "192.168.100.3"
  }
}

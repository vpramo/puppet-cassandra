node 'seed1' {
  class { 'cassandra':
    cluster_name      => 'testCassandra',
    package_name      => 'cassandra',
    seeds             => [ '192.168.100.2'],
    listen_address    => "192.168.100.2"
  }
}


node 'node1' {
  class { 'cassandra':
    cluster_name   => 'testCassandra',
    package_name   => 'cassandra',
    seeds          => [ '192.168.100.2'],
    listen_address => "192.168.100.3"
  }
}

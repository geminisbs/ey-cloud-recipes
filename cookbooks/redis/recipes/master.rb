# Install redis
enable_package "dev-db/redis" do
  version "1.3.12_pre1"
end

package "dev-db/redis" do
  version "1.3.12_pre1"
  action :install
end

directory "/data/redis" do
  owner 'redis'
  group 'redis'
  mode 0755
  recursive true
end

template "/etc/redis_util.conf" do
  owner 'root'
  group 'root'
  mode 0644
  source "redis.conf.erb"
  variables({
    :pidfile => '/var/run/redis_util.pid',
    :basedir => '/data/redis',
    :logfile => '/data/redis/redis.log',
    :port  => '6379',
    :loglevel => 'notice',
    :timeout => 300000,
  })
end

template "/data/monit.d/redis_util.monitrc" do
  owner 'root'
  group 'root'
  mode 0644
  source "redis.monitrc.erb"
  variables({
    :profile => '1',
    :configfile => '/etc/redis_util.conf',
    :pidfile => '/var/run/redis_util.pid',
    :logfile => '/data/redis',
    :port => '6379',
  })
end

execute "monit reload" do
  action :run
end

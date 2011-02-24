#
# Cookbook Name:: redis
# Recipe:: default
#

if node[:instance_role] == 'util' && node[:name].match(/^worker/)

  if node[:name].match(/master$/)

    include_recipe "redis::master"

  else
    # Configure as slave?

  end

end

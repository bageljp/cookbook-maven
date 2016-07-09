#
# Cookbook Name:: maven
# Recipe:: default
#
# Copyright 2014, bageljp
#
# All rights reserved - Do Not Redistribute
#

remote_file "/usr/local/src/#{node['maven']['source']['file']}" do
  owner "root"
  group "root"
  mode 00644
  source "#{node['maven']['source']['url']}"
end

bash "install maven" do
  user "root"
  group "root"
  cwd "/usr/local/src"
  code <<-EOC
    rm -rf #{node['maven']['dir']}
    gzip -dc #{node['maven']['source']['file']} | tar xf -
    mv #{node['maven']['dir']} #{node['maven']['root_dir']}
    cd #{node['maven']['root_dir']}
    ln -sf #{node['maven']['dir']} apache-maven
    chown #{node['maven']['user']}:#{node['maven']['group']} -R #{node['maven']['root_dir']}/#{node['maven']['dir']}
    chown #{node['maven']['user']}:#{node['maven']['group']} -h #{node['maven']['root_dir']}/apache-maven
  EOC
  not_if "ls -l #{node['maven']['root_dir']}/#{node['maven']['dir']}/bin/mvn | awk '{print $3}' | grep #{node['maven']['user']}"
end

template "/etc/profile.d/maven.sh" do
  owner "root"
  group "root"
  mode 00644
end

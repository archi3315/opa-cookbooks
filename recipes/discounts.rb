[Chef::Recipe, Chef::Resource].each { |l| l.send :include, ::Extensions }

Erubis::Context.send(:include, Extensions::Templates)

include_recipe 'aws'

# Create user and group
#
group node.discounts[:user] do
  gid node.discounts[:gid]
  action :create
  system true
end

user node.discounts[:user] do
  comment "Discounts User"
  home    "#{node.deploy[:discounts][:deploy_to]}"
  shell   "/bin/bash"
  uid     node.discounts[:uid]
  gid     node.discounts[:user]
  supports :manage_home => false
  action  :create
  system true
end

# Create service
#
template "/etc/init.d/discounts" do
  source "discounts_init.erb"
  owner 'root' and mode 0755
end

service "discounts" do
  supports :status => true, :restart => true
  action [ :enable ]
end

# Create pid path
#
directory node.discounts[:pid][:path] do
  mode '0755'
  recursive true
end

# Create paths
#
[ node.deploy[:discounts][:deploy_to], node.discounts[:log][:path] ].each do |path|
  directory path do
    owner node.discounts[:user] and group node.discounts[:user] and mode 0755
    recursive true
    action :create
  end
end

# Deploy the jar file
#
jarFile = node.discounts[:version].nil? ? "discounts.jar" : "discounts-#{node.discounts[:version]}.jar"
aws_s3_file "#{node.deploy[:discounts][:deploy_to]}/discounts.jar" do
  bucket "opa-deployments"
  remote_path "discounts/"+jarFile
  aws_access_key_id node.s3[:opa_deployments][:access_key]
  aws_secret_access_key node.s3[:opa_deployments][:secret_key]
end

# Create config file
#
template "application.yml" do
  path   "#{node.deploy[:discounts][:deploy_to]}/application.yml"
  source "discounts_application.yml.erb"
  owner  node.discounts[:user] and group node.discounts[:user] and mode 0755

  notifies :restart, 'service[discounts]' unless node.discounts[:skip_restart]
end
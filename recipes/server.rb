#
# Cookbook:: apache
# Recipe:: server
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'httpd' do
  action :install
end

#file '/var/www/html/index.html' do
#  content "<h1>Hello, World!<h1>
#  <h2>IPADDRESS: #{node['ipaddress']} </h2> 
#  <h2> HOSTNAME: #{node['hostname']} </h2> 
#"
#end

#bash 'Inline Script' do
#  user "root"
#  code "mkdir -p /var/www/mysites/ && chown -R apache /var/www/mysites"
#  not_if do
#    File.directory?('/var/www/mysites');
#  end
#end

directory "/var/www/mysites" do
  owner 'apache'
  recursive true
  action :create
end

remote_file '/var/www/html/mahesh.png' do
 source 'http://awallpapersimages.com/wp-content/uploads/2016/09/89.png'
end

cookbook_file '/var/www/html/cookbook_file_demo.html' do
  source 'cbook_file.html'
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  action :create
#  notifies :restart, 'service[httpd]' :immediately
end

service 'httpd' do
  action [:enable, :start]
  subscribes :restart, 'template[/var/www/html/index.html]', :immediately
end

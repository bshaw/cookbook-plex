#
# Cookbook Name:: plex
# Recipe:: default
#

# get the image from dockerhub
docker_image node['plex']['docker_image']

# run the container
docker_container 'plex' do
  repo node['plex']['docker_image']
  tag node['plex']['image_tag']
  env node['plex']['env_variables']
  port "#{node['plex']['host_port']}:#{node['plex']['container_port']}"
  restart_policy 'always'
  host_name node['plex']['host_name']
  domain_name node['plex']['domain_name']
  volumes ["#{node['plex']['config_volume']}:/config", "#{node['plex']['data_volume']}:/data"]
end

# open port in firewall
firewall_rule 'plex' do
  port node['plex']['host_port']
  command :allow
end

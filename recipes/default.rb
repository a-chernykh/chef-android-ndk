arch = 'x86_64' == node['kernel']['machine'] ? '64' : '32'

ark 'android-ndk' do
  url      node['android-ndk'][arch]['url']
  checksum node['android-ndk'][arch]['sha']
  version  node['android-ndk']['version']
end

execute 'Grant all users to read android-ndk files' do
  command "chmod -R a+r #{node['ark']['prefix_root']}/android-ndk/*"
end
execute 'Grant all users to execute android-ndk scripts' do
  command "chmod -R a+X #{node['ark']['prefix_root']}/android-ndk/*"
end

template '/etc/profile.d/android-ndk.sh' do
  variables path: "#{node['ark']['prefix_root']}/android-ndk"
end

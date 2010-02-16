require 'nanoc3/tasks'

desc 'copy assets'
task :copy_assets => :compile do
  system "rsync -gprt --partial assets/ output"
end

desc 'deploy local webserver'
task :deploy_local => :copy_assets do
  system "rsync -gprt --partial output/ ~/Sites"
end

desc 'deploy to production webserver'
task :deploy => :copy_assets do
  system "rsync -r output/ gizmo@gizmomogwai.dyndns.org:/Users/gizmo/Sites"
end

desc 'run nanoc3'
task :compile do
  system "nanoc3 co"
end

desc 'cleanup'
task :clean do
  system "rm -rf output"
end

task :default => :deploy_local

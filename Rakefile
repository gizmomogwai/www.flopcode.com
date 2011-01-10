require 'nanoc3/tasks'

#desc 'copy assets'
#task :copy_assets => :compile do
#  system 'rsync -gprt --partial assets/ output'
#end

desc 'deploy local webserver'
task :deploy_local => :compile do
  system 'rsync -gprt --partial output/ ~/Sites'
#  system 'open http://localhost/~gizmo'
end

desc 'deploy to production webserver'
task :deploy do
  system 'rsync -r output/ gizmo@gizmomogwai.dyndns.org:/Users/gizmo/Sites'
end

desc 'run nanoc3'
task :compile do
  system 'nanoc3 co'
end

desc 'cleanup'
task :clean do
  system 'rm -rf output'
end

task :default => :deploy_local

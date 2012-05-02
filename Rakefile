require 'nanoc3/tasks'

desc 'deploy local webserver'
task :deploy_local => :compile do
  sh 'rsync -gprt --partial output/ ~/Sites'
  sh 'open http://localhost/~gizmo'
end

desc 'deploy to production webserver'
task :deploy do
  sh 'rsync -r output/ gizmo@gizmomogwai.dyndns.org:/Users/gizmo/Sites'
end

desc 'run nanoc3'
task :compile => [:clean] do
  sh 'nanoc co'
end

desc 'cleanup'
task :clean do
  sh 'rm -rf output/*'
end

task :default => :deploy_local

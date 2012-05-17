require 'nanoc3/tasks'

def is_mac?
  RUBY_PLATFORM.downcase.include?("darwin")
end

def open(url)
  if is_mac?
    sh "open #{url}"
  else
    sh "google-chrome #{url} &"
  end
end

desc 'deploy local webserver'
task :deploy_local => :compile do
  sh 'rsync -gprt --partial output/ ~/Sites'
  open('http://localhost/~gizmo')
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

desc 'restores output'
task :restore_output => [:clean] do
  sh 'git git@github.com:gizmomogwai/gizmomogwai.github.com.git output'
end

task :default => :deploy_local

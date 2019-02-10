#require 'nanoc/tasks'

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
  sh "ruby -run -ehttpd output &"
  open('http://localhost:8080/projects/bp/futures/')
end

#desc 'deploy to production webserver'
#task :deploy do
#sh 'rsync -r output/ gizmo@gizmomogwai.dyndns.org:/Users/gizmo/Sites'
#end

desc 'run nanoc'
task :compile => [:clean] do
  sh 'bundle exec nanoc co'
end

desc 'cleanup'
task :clean do
  sh 'rm -rf output/*'
end

desc 'restores output'
task :restore_output => [:clean] do
  sh 'git clone git@github.com:gizmomogwai/gizmomogwai.github.com.git output'
end

task :default => :deploy_local

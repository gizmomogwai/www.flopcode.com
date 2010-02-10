require 'nanoc3/tasks'

task :copy_assets do
  system "rsync -gprt --partial assets/ output"
  system "rsync -gprt --partial output/ ~/Sites"
end

task :compile do
  system "nanoc3 co"
end

task :clean do
  system "rm -rf output"
end

task :build => [ :clean, :compile, :copy_assets ]

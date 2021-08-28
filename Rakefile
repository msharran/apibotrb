task default: %w[install]

task :install do
  puts `bundle config set --local path 'vendor/bundle'`
  puts `bundle install`
end

task :run do
  ruby "lib/main.rb"
end

task :test do
  ruby "test/cool_program_test.rb"
end

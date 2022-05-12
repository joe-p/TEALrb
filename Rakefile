# frozen_string_literal: true

task default: %w[clean test build]

task :clean do
  Dir['*.gem'].each do |gemfile|
    rm gemfile
  rescue StandardError
    nil
  end
end

task :test do
  ruby 'test/test_all.rb'
end

task :build do
  require 'rubygems/commands/build_command'
  Gem::Commands::BuildCommand.new.execute
end

task :lint do
  sh 'rubocop'
end

task :fix do
  sh 'rubocop -a'
end

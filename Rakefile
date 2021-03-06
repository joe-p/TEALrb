# frozen_string_literal: true

task default: %w[clean lint test build]

desc 'Clean up build artifacts (.gem files)'
task :clean do
  Dir['*.gem'].each do |gemfile|
    rm gemfile
  rescue StandardError
    nil
  end
end

desc 'Execute all minitest tests'
task :test do
  ruby 'test/test_all.rb'
end

desc 'Build the gem'
task :build do
  require 'rubygems/commands/build_command'
  Gem::Commands::BuildCommand.new.execute
end

desc 'Run rubocop'
task :lint do
  sh 'rubocop'
end

desc 'Run rubocop --auto-correct'
task :fix do
  sh 'rubocop --auto-correct'
end

desc 'Run all examples'
task :examples do
  Dir.chdir('examples/demo/') { ruby 'demo.rb' }
  Dir.chdir('examples/nft-app/') { ruby 'nft.rb' }
  Dir.chdir('examples/pyteal_comparisons/') { ruby 'atomic_swap.rb' }
  Dir.chdir('examples/pyteal_comparisons/') { ruby 'voting.rb' }
end

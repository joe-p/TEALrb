# frozen_string_literal: true

task default: %w[clean lint test examples build]
multitask examples: %i[demo nft atomic_swap voting]

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

desc 'Run demo example'
task :demo do
  ruby 'examples/demo/demo.rb'
end

desc 'Run nft example'
task :nft do
  ruby 'examples/nft-app/nft.rb'
end

desc 'Run atomic_swap example'
task :atomic_swap do
  ruby 'examples/pyteal_comparisons/atomic_swap.rb'
end

desc 'Run voting example'
task :voting do
  ruby 'examples/pyteal_comparisons/voting.rb'
end

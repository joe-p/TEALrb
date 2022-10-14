# frozen_string_literal: true

require 'simplecov'
require 'minitest/autorun'
require_relative 'simplecov_gh'

SimpleCov.formatters = [SimpleCov::Formatter::GithubFormatter, SimpleCov::Formatter::HTMLFormatter]

SimpleCov.start do
  add_filter 'test/'
  add_filter 'cmd_line/'
end

Dir.chdir __dir__
(Dir['test_*.rb'] - ['test_all.rb']).each do |f|
  require_relative f
  p f
end

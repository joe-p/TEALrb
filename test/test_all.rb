# frozen_string_literal: true

require 'minitest/autorun'
Dir.chdir __dir__
(Dir['test_*.rb'] - ['test_all.rb']).each do |f|
  require_relative f
  p f
end

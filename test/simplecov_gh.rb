# frozen_string_literal: true

require 'terminal-table'

module SimpleCov
  module Formatter
    class GithubFormatter
      attr_reader :result, :headings

      def format(result)
        @result = result
        @headings = ['File', 'Lines of Code', 'Coverage']

        rows = []

        repo_root = `git rev-parse --show-toplevel`.strip

        result.files.sort_by(&:covered_percent).reverse.each do |file|
          file_path = file.filename.gsub("#{repo_root}/", '')
          rows << ["[#{file_path}](#{file_path})", file.lines_of_code, "#{file.covered_percent.round(2)}%"]
        end

        table = Terminal::Table.new do |t|
          t.headings = headings
          t.rows = rows
          t.style = { border_x: '-', border_y: '|', border_i: '|', border_top: false, border_bottom: false }
        end

        content = StringIO.new

        content.puts '# SimpleCov Report'
        rev = `git rev-parse --short HEAD`.strip

        content.puts "Generated on #{Time.now.strftime('%Y-%m-%d %H:%M:%S')} ([#{rev}](https://github.com/joe-p/TEALrb/tree/#{rev}))"
        content.puts table

        File.write(File.join(SimpleCov.coverage_path, 'gh.md'), content.string)
      end
    end
  end
end

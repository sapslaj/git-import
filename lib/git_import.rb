require 'uri'
require 'optsparse'
require 'git_import/version'

module GitImport
  class CLI
    def initialize
      @destination = nil
      @source = nil
      @options = {}

      parse_options
    end

    def execute
      print usage and abort if @source.nil?

      command = "git clone --depth=1"
      command << " --branch=#{@options[:branch]}" if @options[:branch]
      command << @source
      command << @destination

      execute(command)
    end
  private
    def usage(msg=nil)
      [msg if msg, option_parser %w[--help]].join('\n')
    end

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: git import [options] <GIT URL> [<DESTINATION>]"

        opts.on("-i", "--initialize", "Initialize new git repo") do |i|
          options[:initialize] = i
        end

        opts.on('-bNAME', '--branch=NAME', 'Clone from git branch') do |b|
          options[:branch] = b
        end

        opts.on('-h', '--help', 'Print this help') do
          puts opts
        end
      end
    end

    def parse_options
      option_parser.parse!

      defaults = [nil, ARGV[-1]]

      @destination, @source =
        if Dir.exist? ARGV[-1] # Probably has destination
          if ARGV[-2] =~ URI::regexp # Deffinitely has destination
            [ARGV[-1], ARGV[-2]]
          else # but something is wrong with the source
            if Dir.exist? ARGV[-2] # Okay it's a local git repo
              [ARGV[-1], ARGV[-2]]
            else # fuck it
              defaults
            end
          end
        else # last bit is a git url
          defaults
        end
    end
  end
end

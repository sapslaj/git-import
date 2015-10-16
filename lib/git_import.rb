require 'uri'
require 'optparse'
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
      print usage and abort if @source.nil? || @destination.nil?

      command = ["git clone --depth=1"]
      command << "--branch=#{@options[:branch]}" if @options[:branch]
      command << @source
      command << @destination

      system(command.join(' '))

      system("rm -rf #{@destination}/.git")

      if @options[:initialize]
        Dir.chdir(@destination)
        system('git init .')
        Dir.chdir('..')
      end
    end
  private
    def usage(msg=nil)
      [msg, option_parser.parse!(%w[--help])].join("\n")
    end

    def infer_name(url)
      bit_match = url.match(/\A.*\/(.*)\z/)
      print usage("Unknown repository name #{url}") and abort if bit_match.nil?
      bit = bit_match[1]
      bit.reverse.sub('.git'.reverse, '').reverse if bit.end_with? '.git'
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
          abort
        end

        opts.on('-v', '--version', 'Print Version') do
          puts "git-import #{VERSION}"
        end
      end
    end

    def parse_options
      option_parser.parse!

      defaults = [nil, ARGV[-1]]

      if ARGV.empty?
        print usage
        abort
      end

      @destination, @source =
        if Dir.exist? ARGV[-1] # Probably has destination
          if ARGV[-2] =~ URI::regexp # Deffinitely has destination
            [ARGV[-1], ARGV[-2]]
          else # but something is wrong with the source
            if Dir.exist? ARGV[-2] # Okay it's a local git repo
              [ARGV[-1], ARGV[-2]]
            else # fuck it
              print usage and abort
            end
          end
        else # last bit is a git url
          [infer_name(ARGV[-1]), ARGV[-1]]
        end
    end
  end
end

# frozen_string_literal: true

require 'optparse'
require_relative 'version'
require_relative 'store'
require_relative 'seed'
require_relative 'local_wisdom'
require_relative 'client'

module ZenAndMusashi
  class CLI
    BANNER = "Japanese wisdom for your terminal.\nLocal by default. Oracle optional."

    def self.start(argv)
      new.run(argv)
    end

    def run(argv)
      command = argv.shift

      if command.nil? || %w[-h --help].include?(command)
        puts main_help
        exit 0
      end

      case command
      when '-v', '--version'
        puts "musashi version #{ZenAndMusashi::VERSION}"
        exit 0
      when 'zen', 'musashi'
        handle_wisdom(command.to_sym, argv)
      when 'add'
        handle_add(argv)
      when 'list'
        handle_list(argv)
      when 'remove'
        handle_remove(argv)
      else
        warn "Error: Unknown command '#{command}'."
        puts main_help
        exit 1
      end
    rescue StandardError => e
      warn "Error: #{e.message}"
      exit 1
    end

    private

    def main_help
      <<~HELP
        #{BANNER}

        Usage: musashi <command> [options] [args...]

        Commands:
          zen [options] [input]      Calm, poetic reflection
          musashi [options] [input]  Direct, tactical critique
          add [options] <quote>      Add a new quote
          list [options]             List all quotes
          remove [options] <id>      Remove a quote by ID

        Options for zen/musashi:
          --llm                      Use LLM mode (requires ANTHROPIC_API_KEY)
          --api-key KEY              Anthropic API key for LLM mode

        Options for add/list/remove:
          --mode MODE                Target mode: zen or musashi (required for add/list/remove)

        Global options:
          -v, --version              Show version
          -h, --help                 Show this help message

        Examples:
          musashi zen "My code has a bug"
          musashi musashi "My code has a bug"
          musashi add "The mountain does not hurry." --mode zen
          musashi list --mode zen
          musashi remove 5 --mode zen
      HELP
    end

    def handle_wisdom(mode, argv)
      options = { llm: false, api_key: nil }

      parser = OptionParser.new do |p|
        p.on '--llm', 'Use LLM mode (requires ANTHROPIC_API_KEY)' do
          options[:llm] = true
        end

        p.on '--api-key KEY', String, 'Anthropic API key for LLM mode' do |key|
          options[:api_key] = key
        end
      end

      parser.parse!(argv)
      input = gather_input(argv)

      if input.empty?
        puts main_help
        exit 0
      end

      response =
        if options[:llm]
          api_key = options[:api_key] || ENV['ANTHROPIC_API_KEY']
          unless api_key && !api_key.empty?
            warn 'Error: ANTHROPIC_API_KEY is not set. Export it or pass --api-key.'
            exit 1
          end
          Client.new(api_key: api_key).invoke(mode, input)
        else
          LocalWisdom.invoke(mode, input)
        end

      puts response
    end

    def handle_add(argv)
      options = { mode: nil }

      parser = OptionParser.new do |p|
        p.on '--mode MODE', String, 'Target mode: zen or musashi' do |mode|
          options[:mode] = mode
        end
      end

      parser.parse!(argv)

      unless %w[zen musashi].include?(options[:mode])
        warn "Error: --mode must be 'zen' or 'musashi'."
        exit 1
      end

      text = argv.join(' ').strip

      if text.empty?
        warn 'Error: Quote text is required.'
        puts 'Usage: musashi add "your quote" --mode <zen|musashi>'
        exit 1
      end

      store = Store.new
      id = store.add(options[:mode].to_sym, text)
      puts "Added quote ##{id} to #{options[:mode]} mode."
    end

    def handle_list(argv)
      options = { mode: nil }

      parser = OptionParser.new do |p|
        p.on '--mode MODE', String, 'Target mode: zen or musashi' do |mode|
          options[:mode] = mode
        end
      end

      parser.parse!(argv)

      unless %w[zen musashi].include?(options[:mode])
        warn "Error: --mode must be 'zen' or 'musashi'."
        exit 1
      end

      store = Store.new
      quotes = store.all(options[:mode].to_sym)

      if quotes.empty?
        puts "No quotes found in #{options[:mode]} mode."
      else
        puts "Quotes in #{options[:mode]} mode (#{quotes.length} total):"
        puts '-' * 40
        quotes.each do |q|
          puts "  ##{q[:id]} [#{q[:type]}]: #{q[:text]}"
        end
      end
    end

    def handle_remove(argv)
      options = { mode: nil }

      parser = OptionParser.new do |p|
        p.on '--mode MODE', String, 'Target mode: zen or musashi' do |mode|
          options[:mode] = mode
        end
      end

      parser.parse!(argv)

      unless %w[zen musashi].include?(options[:mode])
        warn "Error: --mode must be 'zen' or 'musashi'."
        exit 1
      end

      id_str = argv.shift
      if id_str.nil? || id_str.strip.empty?
        warn 'Error: Quote ID is required.'
        puts 'Usage: musashi remove <id> --mode <zen|musashi>'
        exit 1
      end

      begin
        id = Integer(id_str)
      rescue ArgumentError
        warn 'Error: ID must be a number.'
        exit 1
      end

      store = Store.new
      store.remove(options[:mode].to_sym, id)
      puts "Removed quote ##{id} from #{options[:mode]} mode."
    end

    def gather_input(args)
      return args.join(' ') if args.any?
      return $stdin.read unless $stdin.tty?

      ''
    end
  end
end

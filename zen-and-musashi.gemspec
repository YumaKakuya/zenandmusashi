# frozen_string_literal: true

require_relative 'lib/zen_and_musashi/version'

Gem::Specification.new do |spec|
  spec.name          = 'zen-and-musashi'
  spec.version       = ZenAndMusashi::VERSION
  spec.authors       = ['Sorted.']
  spec.email         = []

  spec.summary       = 'Japanese wisdom for your terminal. Local Zen and Musashi-style critique, with optional LLM mode.'
  spec.description   = 'zen-and-musashi is a Ruby CLI that gives local, structured terminal wisdom in two modes: calm Zen-style reflection and fierce Musashi-style critique. It works without an API key by default, and can optionally use an LLM when explicitly enabled.'
  spec.homepage      = 'https://github.com/YumaKakuya/zenandmusashi'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  spec.files         = Dir.glob('{bin,lib}/**/*') + %w[README.md LICENSE SOURCES.md Rakefile zen-and-musashi.gemspec]
  spec.bindir        = 'bin'
  spec.executables   = ['musashi']
  spec.require_paths = ['lib']

  # No runtime dependencies — stdlib only
end

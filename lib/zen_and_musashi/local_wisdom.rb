# frozen_string_literal: true

require_relative 'store'
require_relative 'seed'

module ZenAndMusashi
  module LocalWisdom
    module_function

    def invoke(mode, _input)
      store = Store.new

      # 初回実行時にseed投入
      Seed.run(store) if store.count(mode).zero?

      quote = store.random(mode)

      if quote.nil?
        "No quotes found for #{mode} mode. Add one with: musashi add \"your quote\" --mode #{mode}"
      else
        quote[:text]
      end
    end
  end
end

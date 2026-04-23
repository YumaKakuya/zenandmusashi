# frozen_string_literal: true

require 'pstore'
require 'fileutils'

module ZenAndMusashi
  class Store
    DB_DIR = File.join(Dir.home, '.config', 'zen-and-musashi')
    DB_PATH = File.join(DB_DIR, 'quotes.db')

    def initialize
      FileUtils.mkdir_p(DB_DIR)
      @pstore = PStore.new(DB_PATH)
    end

    def all(mode)
      @pstore.transaction(true) do
        @pstore[mode.to_s] || []
      end
    end

    def random(mode)
      quotes = all(mode)
      return nil if quotes.empty?

      quotes.sample
    end

    def add(mode, text)
      @pstore.transaction do
        mode_key = mode.to_s
        quotes = @pstore[mode_key] || []

        # 重複チェック
        raise "That quote already exists in #{mode} mode." if quotes.any? { |q| q[:text].casecmp(text).zero? }

        # 文字数制限チェック（200文字）
        raise 'Quote is too long. Maximum 200 characters.' if text.length > 200

        new_id = (quotes.map { |q| q[:id] }.max || 0) + 1
        quotes << { id: new_id, text: text, type: 'composed' }
        @pstore[mode_key] = quotes

        new_id
      end
    end

    def remove(mode, id)
      @pstore.transaction do
        mode_key = mode.to_s
        quotes = @pstore[mode_key] || []

        idx = quotes.index { |q| q[:id] == id }
        raise "Quote ID #{id} not found in #{mode} mode." unless idx

        quotes.delete_at(idx)
        @pstore[mode_key] = quotes

        true
      end
    end

    def count(mode)
      all(mode).length
    end

    def seed(data)
      @pstore.transaction do
        data.each do |mode_key, quotes_array|
          existing = @pstore[mode_key.to_s] || []

          quotes_array.each do |quote_hash|
            # 重複チェック
            next if existing.any? { |q| q[:text].casecmp(quote_hash[:text]).zero? }

            new_id = (existing.map { |q| q[:id] }.max || 0) + 1
            existing << { id: new_id, text: quote_hash[:text], type: quote_hash[:type] || 'composed' }
          end

          @pstore[mode_key.to_s] = existing
        end
      end
    end

    def clear(mode)
      @pstore.transaction do
        @pstore[mode.to_s] = []
      end
    end
  end
end

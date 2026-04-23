# frozen_string_literal: true

require "net/http"
require "json"
require "uri"

module ZenAndMusashi
  class Client
    MODEL = "claude-haiku-4-5"
    API_URL = "https://api.anthropic.com/v1/messages"

    def initialize(api_key: nil)
      @api_key = api_key || ENV["ANTHROPIC_API_KEY"]
      validate_api_key!
    end

    def invoke(mode, input)
      uri = URI(API_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      body = {
        model: MODEL,
        max_tokens: 300,
        system: system_prompt(mode),
        messages: [{ role: "user", content: input }]
      }.to_json

      request = Net::HTTP::Post.new(uri)
      request["anthropic-version"] = "2023-06-01"
      request["content-type"] = "application/json"
      request["x-api-key"] = @api_key
      request.body = body

      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        raise "HTTP Error: #{response.code}"
      end

      parsed = JSON.parse(response.body)
      parsed["content"][0]["text"]
    end

    private

    def validate_api_key!
      unless @api_key && !@api_key.empty?
        raise "ANTHROPIC_API_KEY is not set. Export it or pass --api-key."
      end
    end

    def system_prompt(mode)
      case mode
      when :zen
        "You are a calm, poetic Zen-inspired guide. Respond in 1-3 sentences. Be concise, poetic, and gently insightful. No bullet points. No emoji."
      when :musashi
        "You are a direct, tactical Musashi-inspired critic. Respond in 1-3 sentences. Be sharp, useful, and unflinching. No bullet points. No emoji."
      end
    end
  end
end

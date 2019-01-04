require "nonono_reciever/slack/version"
require "nonono_reciever"
require "slack-ruby-client"

module NononoReciever
  module Slack
    extend NononoReciever
    class Error < StandardError; end
    NononoReciever::R << self

    def init
      raise Error if ENV['SLACK_API_TOKEN'].empty? || ENV['SLACK_CHANNEL'].empty?
      ::Slack.configure do |config|
        config.token = ENV['SLACK_API_TOKEN']
      end
      @@client = ::Slack::Web::Client.new
    end

    def take(event)
      case event.class.to_s
      when 'String' then event
      end
    end

    def recieve(event)
      ch = ENV['SLACK_CHANNEL']
      text = take(event)
      @@client.chat_postMessage(channel: ch, text: text, as_user: false) unless text.nil?
    end

    extend self
  end
end

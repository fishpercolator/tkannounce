require 'logger'
require 'sqlite3'
require 'twitter'

module TkAnnounce
  class Announcer

    attr_accessor :logger, :twitter, :vendors
    attr_reader   :db

    def initialize(args={})
      @logger = args[:logger] || Logger.new(STDERR)
      @twitter = Twitter::REST::Client.new do |config|
        logger.warn "Twitter config not implemented"
      end
      @vendors = []
      @db_file = args[:db]
      @db      = SQLite3::Database.new(@db_file.path)
    end

    def add_vendor(vendor)
      vendors << vendor
    end

  end
end

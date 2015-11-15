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
      @db      = DB.new(args[:db])
    end

    def add_vendor(vendor)
      vendors << vendor
    end

    def vendors_in_db
      db.vendors
    end

    def vendors_not_in_db
      # Can't use Array#- here because reconstructed vendors have different hash values
      db_vendors = vendors_in_db
      vendors.reject { |v| db_vendors.include? v }
    end

    def tweet_new_vendors!
      vendors_not_in_db.each do |vendor|
        twitter.update("New vendor in Trinity Kitchen: Welcome #{vendor.name}! #{vendor.url}")
      end
      db.save_vendors vendors
    end

  end
end

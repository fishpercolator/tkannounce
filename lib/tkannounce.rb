require 'logger'
require 'twitter'
require 'tkannounce/vendor'

class TkAnnounce

  attr_accessor :logger, :twitter, :vendors

  def initialize(args={})
    @logger = args[:logger] || Logger.new(STDERR)
    @twitter = Twitter::REST::Client.new do |config|
      logger.warn "Twitter config not implemented"
    end
    @vendors = []

    if args[:from_db]
      initialize_from_db
    end
  end

  def add_vendor(vendor)
    vendors << vendor
  end

  private

  def initialize_from_db
    logger.warn "No db initialization yet"
  end

end

module TkAnnounce
  class Vendor
    attr_accessor :name, :url

    def initialize(name=nil, url=nil)
      @name = name
      @url  = url
    end

    def ==(other)
      name == other.name && url == other.url
    end
  end
end

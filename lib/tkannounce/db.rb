require 'sqlite3'

module TkAnnounce
  class DB

    attr_reader :sql

    def initialize(file)
      @file = file
      @sql  = SQLite3::Database.new(@file.path)
      initialize_db
    end

    # Replace the contents of the vendors DB with the given array of vendors
    def save_vendors(vendors)
      sql.execute 'delete from vendors'
      query = 'insert into vendors (name, url) values ' + (['(?,?)'] * vendors.length).join(',')
      args = vendors.map {|v| [v.name, v.url] }.flatten
      sql.execute query, args
    end

    # Get all the vendors in the DB as Vendor objects
    def vendors
      sql.execute('select name,url from vendors').map {|row| Vendor.new(*row)}
    end

    private
    def initialize_db
      begin
        sql.execute 'select 1 from vendors'
      rescue SQLite3::SQLException
        sql.execute 'create table vendors (name varchar(50), url varchar(255))'
      end
    end
  end
end

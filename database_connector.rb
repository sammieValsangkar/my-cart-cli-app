require 'pg'
DB_NAME = 'my_cart'
USER = 'postgres'
PASSWORD = 'postgres'

# Database Connecter to establish connection with database,
# TODO: load database configuration from config

class DatabaseConnector
  def initialize(dbname = DB_NAME, user = USER, password = PASSWORD)
    @dbname = dbname
    @user = user
    @password = password
  end

  def connect
    begin
        con = PG.connect :dbname => @dbname, :user =>  @user, :password => @password, host: 'localhost'
    rescue PG::Error => e
        puts e.message
    end

    con if con
  end

  def self.fire_query(sql)
    conn = DatabaseConnector.new.connect
    r = conn.exec(sql)
    conn.close
    r
  end
end
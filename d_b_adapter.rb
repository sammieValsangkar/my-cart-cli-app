require_relative "database_connector"
require 'time'
# Database Adapter handles query dynamically,
# i tried to make it like Rails ActiveRecord


class DBAdapter
  # extend ACHelper

  class << self
    # attr_reader :table_name

    def all
      rs = DatabaseConnector.fire_query "select * from #{table_name}"
      rs.map do |row|
        self.new(row.to_h)
      end
    end

    def print_collection(coll)
      return unless coll.any?

      rs = coll.map { |a| a.attrs }

      keys = rs.first.keys
      puts keys[0..-3].join(' | ')

      rs.each do |row|
        puts row.values[0..-3].join(' | ')
      end
      rs
    end

    def destroy(id)
      DatabaseConnector.fire_query "delete from #{table_name} where id ='#{id}'"
    end

    def find_by_id(id)
      rs = DatabaseConnector.fire_query "select * from #{table_name} where id ='#{id}' limit 1"
      rs = rs.to_a
      self.new(rs.last.to_h) unless rs.last.nil?
    end

    def where(condition)
      rs = DatabaseConnector.fire_query "select * from #{table_name} where #{condition}"
      rs.map do |row|
        self.new(row.to_h)
      end
    end

    def delete_where(condition)
      DatabaseConnector.fire_query "delete from #{table_name} where #{condition}"
    end

    def table_name
      self.class_variable_get(:@@table_name)
    end
  end

  def save
    attrs['created_at'] = attrs['created_at'] || Time.now
    attrs['updated_at'] =  Time.now

    if attrs['id']

     sql = "UPDATE #{self.class.table_name} SET #{attrs.map{|k,v| "#{k}= '#{v}'" }.join(', ')} WHERE id = '#{attrs['id']}' RETURNING *"
    else
      sql = "INSERT INTO #{self.class.table_name} (#{attrs.keys.join(', ')}) VALUES ( #{attrs.values.map{|a| "'#{a}'" }.join(', ')}) RETURNING *"
    end
    # p sql
    r = DatabaseConnector.fire_query(sql)
    r.error_message == ''
  end
end
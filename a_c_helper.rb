module ACHelper
    def where(condition)
      conn = DatabaseConnector.new.connect
      rs = conn.exec "select * from #{table_name} where #{condition}"
      rs.map do |row|
        p self.new(row.to_h)
        # self.class.superclass.new(row.to_h)
      end
    end

end
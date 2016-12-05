require 'byebug'

require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    return @columns if @columns
    res = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    @columns = res[0].map { |el| el.to_sym }
  end

  def self.finalize!
    columns.each do |col|
      define_method(col) { attributes[col] }
      define_method("#{col}=") { |val| attributes[col] = val }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    if @table_name
      @table_name
    else
      self.to_s.tableize
    end
  end

  def self.all
    res = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(res)
  end

  def self.parse_all(results)
    results.map do |el|
      self.new(el)
    end
  end

  def self.find(id)
    res = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{table_name}
      WHERE id = ?
    SQL
    return nil if res.empty?
    self.new(res.first)
  end

  def initialize(params = {})
    params.each do |key, val|
      key = key.to_sym
      unless self.class.columns.include?(key)
        raise "unknown attribute '#{key}'"
      end
      send("#{key}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
     self.attributes.values
  end

  def insert
    col_names = self.class.columns.drop(1).join(", ")
    question_marks = ["?"] * (self.class.columns.size - 1)
    question_marks = question_marks.join(", ")

    DBConnection.execute(<<-SQL, *self.attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.map { |col| "#{col} = ?" }.join(", ")


    DBConnection.execute(<<-SQL, *self.attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    if self.id.nil?
      insert
    else
      update
    end
  end
end

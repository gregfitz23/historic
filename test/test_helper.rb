require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require "active_record"
require 'historic'

class Test::Unit::TestCase
  
  
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

  ActiveRecord::Schema.define(:version => 1) do
    columns = [:field_1, :field_2, :field_3]
    create_table :historic_items do |t|
      t.string *columns
      t.integer :version, :default => 0
    end
    
    create_table :historic_item_histories do |t|
      t.string *columns
      t.integer :position
      t.integer :historic_item_id
      t.integer :version
    end
  end
  
  require "historic_item_history"
  require "historic_item"
end

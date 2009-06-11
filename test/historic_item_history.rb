class HistoricItemHistory < ActiveRecord::Base
  
  acts_as_historic_record
  
end
class HistoricItem < ActiveRecord::Base

  acts_as_historic :on_change_of=>:field_1, :after => :clear_field_3

  def clear_field_3
    self.field_3 = nil
  end
end
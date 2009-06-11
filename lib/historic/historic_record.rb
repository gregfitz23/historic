module ActiveRecord
  module Acts    
    module HistoricRecord
      def self.append_features(base)
        super
        base.extend(Definition)
      end
      
      module Definition
        def acts_as_historic_record
          extend ClassMethods
          acts_as_list
        end        
      end
      
      module ClassMethods
        
        # Same as create_history_from_current! but swallows exceptions and returns false.
        def create_history_from_current(current)
          create_history_from_current!(current) rescue false
        end

        # Create an HistoricRecord record based off of the passed in Object.
        # Copy any fields that are on both the Object and the HistoricRecord object, preserving any changed values.
        #
        def create_history_from_current!(current)
          history_obj = self.new
          attrs_to_copy = current.attributes.reject {|key, value| !history_obj.attribute_names.include?(key)}

          changed_attrs_with_old_values = {}
          current.changes.each_pair {|field, value_ary| changed_attrs_with_old_values[field] = value_ary[0]}

          attrs_to_copy.merge!(changed_attrs_with_old_values)
          self.create(attrs_to_copy)
        end        
      end
        
    end #HistoricRecord
  end #Acts
end #ActiveRecord

ActiveRecord::Base.class_eval do
  include ActiveRecord::Acts::Historic
  include ActiveRecord::Acts::HistoricRecord
end
    
      

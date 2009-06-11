module ActiveRecord
  module Acts
    module Historic
  
      def self.append_features(base) #:nodoc:
        super
        base.extend(Definition)  
      end
      
      module Definition
        # Sets up before_save and before_destroy to create HistoricRecord rows when appropriate.
        def acts_as_historic(options={})
          extend ActiveRecord::Acts::Historic::ClassMethods          
          include ActiveRecord::Acts::Historic::InstanceMethods
          
          historic_extract_options(options)
          
          alias_method_chain :before_save, :historic
          alias_method_chain :before_destroy, :historic
        end        
      end
      
      module ClassMethods

        def historic_table_class
          @historic_table_class
        end

        def historic_options
          @historic_options
        end
        
        
        private
        # Extract the table class to be used or default to this class name + History.
        # Ensure that on_change_of is an array.
        #
        def historic_extract_options(options)
          @historic_table_class = (options.delete(:class_name) || "#{self.to_s}History").constantize  
          
          options[:on_change_of] = [options[:on_change_of]] if options[:on_change_of] && !options[:on_change_of].is_a?(Array)
          @historic_options = options 
        end
        
      end #ClassMethods
      
      module InstanceMethods
        # Chain historic_copy_to_history into before_save.
        # This will only be triggered if:
        #   a. The current record is a new record OR the on_initialize flag is true
        #   b. AND on_change_of is not nil AND one of the fields specified in on_change_of has changed
        def before_save_with_historic
          before_save_without_historic
          
          if historic_should_move_to_history?(historic_options)
            historic_copy_to_history
          end
        end
        
        # Chain historic_copy_to_history into before_destroy.
        #
        def before_destroy_with_historic
          before_destroy_without_historic
          historic_copy_to_history
        end
          
        private
        def historic_should_move_to_history?(options)
          (options[:on_initialize] || !new_record?) && (options[:on_change_of] && options[:on_change_of].any? {|field| self.__send__("#{field}_changed?")})
        end  

        # Copy the current item to the HistoryRecord object and execute the :after hook, if it exists
        #        
        def historic_copy_to_history
          self.class.historic_table_class.__send__("create_history_from_current!", self)
          historic_options[:after].to_proc.call(self) if historic_options[:after]
        end
        
        def historic_options
          self.class.historic_options
        end
      end #InstanceMethods      
    end #Historic
  end
end
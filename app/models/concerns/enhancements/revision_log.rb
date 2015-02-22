module Enhancements
  module RevisionLog
    extend ActiveSupport::Concern

    module ClassMethods
    
      attr_accessor :children
  	  def maintain_revision_log(*children)
        @children ||= []
        children.extract_options!
        @children = @children + children
        @children.map! { |e| e.to_sym }
        @children.uniq!
  	  	after_save :create_log
  	  end

    end

    module InstanceMethods
    
      def create_log
	      object_type = self.class
	      object_id = self.id
	      attributes_modified = self.changes.symbolize_keys!
	      if !attributes_modified.keys.include?(:created_at)
	  	    if !object_type.children.empty?
	  	      save_attributes = attributes_modified.slice(*self.class.children)
	  	    else
	  	    	save_attributes = attributes_modified.except(:updated_at)
	  	    end
          history_params = {object_type: object_type, object_id: object_id, attributes_modified: 	save_attributes}
	        document = History.new(history_params)
	        document.save	  
        end
      end

  	end

	  def self.included(receiver)
	    receiver.extend         ClassMethods
	    receiver.send :include, InstanceMethods
	  end

  end
end

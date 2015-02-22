class Restaurant

  include Mongoid::Document
  include Mongoid::Timestamps 
  include Enhancements::RevisionLog

	field :name, type: String
	field :address, type: String
	field :contact, type: String
  field :cuisines, type: Array

  before_save :flatten_array_fields

  def flatten_array_fields
    self.cuisines = [self.cuisines].flatten.reject { |cuisine| cuisine == '0' }
  end

	maintain_revision_log	

end

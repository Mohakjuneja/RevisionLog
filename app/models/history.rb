class History
  include Mongoid::Document
  include Mongoid::Timestamps 
  include Mongoid::Userstamp

  field :object_type, type: String
  field :object_id, type: String
  field :attributes_modified, type: Hash

  mongoid_userstamp user_model: 'User'

end



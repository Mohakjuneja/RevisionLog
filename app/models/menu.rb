class Menu
  include Mongoid::Document

  belongs_to :restaurant

  field :cuisine, type: Array
  field :offer, type: Array

end

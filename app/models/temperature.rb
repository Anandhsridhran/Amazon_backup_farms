class Temperature < ActiveRecord::Base
  attr_accessible :reading_id, :value
  belongs_to :reading
end

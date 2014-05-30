class Shipment < ActiveRecord::Base
  attr_accessible :barn_id, :pig_supplier, :shipment_date, :total_doa, :total_pigs

  belongs_to :barn
end

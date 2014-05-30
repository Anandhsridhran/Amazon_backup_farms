class PigTreatment < ActiveRecord::Base
  attr_accessible :count, :dosage, :how_administered, :inventory_report_id, :medicine_given

  belongs_to :inventory_report

  validates :count, numericality: { only_integer: true }
  validates :medicine_given, presence: true

end

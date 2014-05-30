class PigDeath < ActiveRecord::Base
  attr_accessible :cause, :count, :inventory_report_id

  belongs_to :inventory_report

  validates :count, numericality: { only_integer: true }
  validates :cause, presence: true
end

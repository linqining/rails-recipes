class Ticket < ApplicationRecord
  validates_presence_of :name, :price
  has_many :registrations
  belongs_to :event
end

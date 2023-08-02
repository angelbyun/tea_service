class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :title, :price, :status, :frequency, presence: true

  enum status: { active: true, canceled: false }
  enum frequency: { weekly: 0, monthly: 1}
end
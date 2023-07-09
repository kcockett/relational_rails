class Store < ApplicationRecord
  has_many :vehicles, dependent: :destroy
end
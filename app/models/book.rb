class Book < ApplicationRecord
  has_many :authors

  accepts_nested_attributes_for :authors, reject_if: :all_blank, allow_destroy: true
end

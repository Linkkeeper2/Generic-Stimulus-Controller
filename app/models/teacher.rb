class Teacher < ApplicationRecord
  has_many :students

  accepts_nested_attributes_for :students, reject_if: :all_blank, allow_destroy: true
end

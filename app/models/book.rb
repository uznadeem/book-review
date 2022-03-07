class Book < ApplicationRecord
  include Reviewable

  belongs_to :author

  validates :title, :description, presence: true
end

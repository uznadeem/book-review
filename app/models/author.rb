class Author < ApplicationRecord
  include Reviewable

  validates :description, presence: true

  has_many :books, dependent: :destroy
end

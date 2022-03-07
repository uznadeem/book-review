class Review < ApplicationRecord
  PROFANITY_WORDS = %w[frak storms gorram nerfherder crivens].freeze

  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5, message: 'rating should be in range of 1..5' }
  validates :reviewable_id, uniqueness: { scope: %i[reviewable_type user_id], message: "can't post multiple reviews" }

  validate :fictional_profanity

  after_save :reviewable_rating

  private

  def fictional_profanity
    profanity = PROFANITY_WORDS.any? { |word| description&.split(" ")&.include?(word) }
    errors.add(:description, 'cannot contain fictional profanity') if profanity
  end

  def reviewable_rating
    # NOTE: It was asked to calculate average rating for books only. Therefore I have added a check for books
    # TODO: We can add rating column for author as well just like books

    if self.reviewable_type == "Book"
      reviews_count = reviewable.reviews.count
      pre_rating = reviewable.rating || 0

      pre_score = pre_rating * (reviews_count - 1)
      new_score = pre_score + self.rating.to_d

      rating = new_score / reviews_count
      reviewable.update!(rating: rating)
    end
  end
end

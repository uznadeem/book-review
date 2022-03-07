class FilterReviews
  def initialize(reviewable, sort_by, order, description_only)
    @reviewable       = reviewable
    @sort_by          = sort_by
    @order            = order
    @description_only = description_only
  end

  def run
    @reviews = @reviewable.reviews
    description_reviews if @description_only.to_s == "true"
    sort_reviews if @sort_by.present?

    @reviews
  end

  private

  def description_reviews
    @reviews = @reviews.descriptive_only
  end

  def sort_reviews
    @reviews = @reviews.order("#{@sort_by} #{@order}")
  end
end

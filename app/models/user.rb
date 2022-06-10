class User < ApplicationRecord
  has_many :recipes, :dependent => :destroy
  scope :recent, -> { order("created_at DESC") }

  # Validations
  validates :name, :email, presence: true

  
  # Usage 
  # User.find_by_date_ranges
  # from = Time.now - 10.days
  # to = Time.now - 2.days
  # users = User.find_by_date_ranges(from, to)
  def self.find_by_date_ranges(from, to)
    raise ArgumentError.new("Please provide a valid from date.") unless from.present? && (from.is_a?(Date) || from.is_a?(Time))
    raise ArgumentError.new("Please provide a valid to date.") unless to.present? && (to.is_a?(Date) || to.is_a?(Time))
    raise StandardError.new("Must be pass valid date range. From date should be less than to date") unless from < to
    
    recent.left_outer_joins(:recipes)
    .where("published_at Between ? AND ?", from, to)
    .distinct.select('users.*, COUNT(recipes.*) AS  recipes_count')
    .group('users.id')
    .having("COUNT(recipes.*) = ?", 1)
  end
end

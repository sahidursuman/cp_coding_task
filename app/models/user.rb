class User < ApplicationRecord
  has_many :recipes, :dependent => :destroy
  has_one :retention_email
  scope :recent, -> { order("created_at DESC") }

  # Validations
  validates :name, :email, presence: true


  def send_recipe_publish_welcome_email(retention_email)
    UserMailer.bulk_email(self, retention_email).deliver_later
  end

  def create_reten_email_record(body, date_from, date_to)
    return nil if retention_email.present?
    re = self.create_retention_email(body: body, date_from: date_from, date_to: date_to)
    send_recipe_publish_welcome_email(re) if re.present?
  end
  
  # class methods start here
  class << self 

    # Usage 
    # User.find_by_date_ranges
    # from = Time.now - 10.days
    # to = Time.now - 2.days
    # users = User.find_by_date_ranges(from, to)
    def find_by_date_ranges(from, to)
      raise ArgumentError.new("Please provide a valid from date.") unless from.present? && (from.is_a?(Date) || from.is_a?(Time))
      raise ArgumentError.new("Please provide a valid to date.") unless to.present? && (to.is_a?(Date) || to.is_a?(Time))
      raise StandardError.new("Must be pass valid date range. From date should be less than to date") unless from < to
      
      recent.left_outer_joins(:recipes)
      .where("published_at Between ? AND ?", from, to)
      .distinct.select('users.*, COUNT(recipes.*) AS  recipes_count')
      .group('users.id')
      .having("COUNT(recipes.*) = ?", 1)
    end

    def to_csv
      attributes = %w{id email name}
  
      CSV.generate(headers: true) do |csv|
        csv << attributes
  
        all.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end

  end
  # class methods end here
  
end

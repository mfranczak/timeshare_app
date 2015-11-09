class Activity < ActiveRecord::Base

  TYPES = [
      :food,
      :work,
      :travel,
      :shopping,
      :relax,
      :learning,
      :sport,
      :family,
      :friends,
      :housekeeping
  ]

  belongs_to :user

  validates :length, presence: true
  validates :what, presence: true
  validates :when, presence: true

  validate :when_not_in_future,
           :activity_length_too_long

  def save
    if (!self.id)
      # check for existing activity
      existing = Activity.find_by user: self.user, when: self.when, what: self.what
      if (existing)
        existing.length += self.length
        return existing.save
      end
    end

    super
  end

  private

  def when_not_in_future
    if self.when > Date::today
      errors.add :when, 'can\'t be in the future'
    end
  end

  def prepared_what
    if self.what.nil?
      return ''
    end

    self.what
  end

  def prepared_length
    if self.length.nil?
      return 0
    end

    self.length
  end

  def activity_length_too_long
    daily_sum = Activity.where(user: self.user, when: self.when).where.not(what: prepared_what).sum(:length)
    count = daily_sum + prepared_length
    if count > DailyActivity::TOP_TIME
      errors.add :length, 'activity is too long'
    end
  end
end

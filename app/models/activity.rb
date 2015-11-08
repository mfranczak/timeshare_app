class Activity < ActiveRecord::Base

  TYPES = [
      :food,
      :work,
      :travel,
      :shopping,
      :relax,
      :learning,
      :sport
  ]

  belongs_to :user

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
end

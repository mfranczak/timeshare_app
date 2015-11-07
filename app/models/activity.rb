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
end

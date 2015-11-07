class Activity < ActiveRecord::Base

  TYPES = [
      :food,
      :work,
      :travel,
      :shopping,
      :relax,
      :learning
  ]

  belongs_to :user
end

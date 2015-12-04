class GroupsBreakdown
  def initialize(activites)
    @activities = activites
  end

  def chart_data
    data = {}
    Activity::TYPES.each do |type|
      data[type.to_s] = 0
    end

    @activities.each do |activity|
      data[activity.what] += activity.length / 4.0
    end

    data
  end
end

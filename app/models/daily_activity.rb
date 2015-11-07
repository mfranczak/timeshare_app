class DailyActivity
  TOP_TIME = 96

  attr_reader :groups, :not_assigned_time

  def initialize
    @groups = {}
    @not_assigned_time = TOP_TIME
  end

  def self.build_by_activities activities
    daily = {}

    activities.each do |activity|
      key = activity.when.to_s
      unless daily.has_key? key
        daily[key] = DailyActivity.new
      end

      daily[key].add_activity activity
    end

    daily
  end

  def add_activity(activity)
    @groups[activity.what] = activity.length
    @not_assigned_time -= activity.length
    @groups[:unknown] = @not_assigned_time
  end
end
class DailyBreakdown
  def initialize(activites)
    @activities = activites
  end

  def chart_data
    data = {}
    @activities.each do |activity|
      data[activity.what] = {name: activity.what, data: []} unless data.has_key? activity.what
      data[activity.what][:data].push [activity.when.to_s, activity.length / 4.0, format_time(activity.length)]
    end

    return data.values
  end

  def format_time time
    calculation = time.to_f / 4
    calculation_string = calculation.to_s.split '.'

    string = ''
    hours = calculation_string.first

    if hours.to_f > 0.0
      string += hours + 'h'
    end

    minutes = calculation_string.last
    if minutes == '25'
      string += '15m'
    elsif minutes == '5'
      string += '30m'
    elsif minutes == '75'
      string += '45m'
    end

    string
  end
end

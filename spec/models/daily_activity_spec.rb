require 'spec_helper.rb'
require 'rails_helper.rb'

describe DailyActivity do
  subject(:daily_activity) { DailyActivity.new }

  context 'with no activities' do
    it '#not_assigned_time' do
      expect(daily_activity.not_assigned_time).to eq DailyActivity::TOP_TIME
    end
  end

  context 'after adding activities' do
    let(:activity) do
      activity = Activity.new
      activity.when = Date.new(2015,9,12)
      activity.what = Activity::TYPES.first
      activity.length = 4
      activity
    end

    it '#add_activity' do
      daily_activity.add_activity activity

      expectedHash = Hash.new
      expectedHash[activity.what] = activity.length
      expectedHash[:unknown] = DailyActivity::TOP_TIME - activity.length
      expect(daily_activity.groups).to eq expectedHash
    end

    it '#not_assigned_time' do
      daily_activity.add_activity activity
      expect(daily_activity.not_assigned_time).to eq DailyActivity::TOP_TIME - activity.length
    end

    it 'build_by_activities' do
      daily = DailyActivity.new
      daily.add_activity activity

      daily_activities = DailyActivity.build_by_activities [activity]
      expect(daily_activities[activity.when.to_s].groups).to eq(daily.groups)
    end
  end
end
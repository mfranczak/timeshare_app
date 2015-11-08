require 'spec_helper.rb'
require 'rails_helper.rb'

describe ActivitiesHelper do
  it { expect(helper.format_time 4).to eq '1h' }
  it { expect(helper.format_time 2).to eq '30m' }
  it { expect(helper.format_time 11).to eq '2h45m' }
end
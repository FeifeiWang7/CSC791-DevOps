require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'is a valid job' do
    expect(build(:job)).to be_valid
  end
  it 'is invalid without a employer_name' do
    expect(build(:job,employer_name:nil)).to_not be_valid
  end
  describe '#outdated'
  it 'returns true if time now is larger than deadline' do
    expect(build(:job,deadline:"2014-09-09").outdated).to be true  
  end
  
  it 'returns false if time now is smaller than deadline' do
    expect(build(:job,deadline:"2015-09-09").outdated).to be false
  end
  describe '#search_jobs(params)'
  it 'returns every job when empty' do
    expect(build(:job).search_jobs({:name => ""})).to_not be_nil
  end
  
end

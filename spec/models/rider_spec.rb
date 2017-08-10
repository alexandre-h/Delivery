RSpec.describe Rider, type: :model do
  it { should validate_presence_of(:x) }
  it { should validate_presence_of(:y) }
  it { should have_many(:orders) }
end
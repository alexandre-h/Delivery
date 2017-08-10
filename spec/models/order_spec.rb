RSpec.describe Order, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to(:rider) }
  it { should belong_to(:restaurant) }
  #it { should validate_presence_of(:x) }
  #it { should validate_presence_of(:y) }
  #it { should have_one(:card) }
  #it { should have_many(:decks) }
end
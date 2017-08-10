RSpec.describe Order, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to(:rider) }
  it { should belong_to(:restaurant) }
end
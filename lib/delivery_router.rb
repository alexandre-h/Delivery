class DeliveryRouter
  def initialize(restaurants, customers, riders)
    @restaurants = restaurants
    @restaurants.each { |restaurant| restaurant.save}
    @customers = customers
    @customers.each { |customer| customer.save }
    @riders = riders
    @riders.each { |rider| rider.save }
  end

  #add_order(:customer => 1, :restaurant => 3)
  def add_order(order)
    customer = Customer.find_by(id: order[:customer])
    restaurant = Restaurant.find_by(id: order[:restaurant])
    added_order = Order.create(customer: customer, restaurant: restaurant)
    distance = calcul_distance([customer.x, customer.y], [restaurant.x, restaurant.y])
  end

  def clear_orders(customer)
    Order.delete_all.where(customer_id: customer[:customer])
  end

  def route(rider)
    rider = Rider.find_by(id: rider[:rider])

  end

  def delivery_time(customer)

  end

  def calcul_distance(p1, p2)
    sum_of_squares = 0
    p1.each_with_index do |p1_coord,index|
      sum_of_squares += (p1_coord - p2[index]) ** 2
    end
    Math.sqrt( sum_of_squares )
  end
end
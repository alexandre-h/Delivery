class DeliveryRouter
  def initialize(restaurants = nil, customers = nil, riders = nil)
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
  end

  def clear_orders(customer)
    Order.where(customer_id: customer[:customer]).delete_all
  end

  def route(rider)
    order = Order.where(rider_id: rider[:rider]).last
     order.nil? ? [] : [order.restaurant, order.customer]
  end

  def delivery_time(customer)
    order = Order.where(customer_id: customer[:customer]).last
    order.define_time(order.rider, order.restaurant, order.distance)
  end

end
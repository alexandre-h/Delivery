class DeliveryRouter
  def initialize(restaurants = nil, customers = nil, riders = nil)
    @restaurants = restaurants
    @restaurants.each { |restaurant| restaurant.save}
    @customers = customers
    @customers.each { |customer| customer.save }
    @riders = riders
    @riders.each { |rider| rider.save }
  end

  def add_order(order)
    customer = Customer.find_by(id: order[:customer])
    restaurant = Restaurant.find_by(id: order[:restaurant])
    Order.create(customer: customer, restaurant: restaurant, status: 'in_progress')
  end

  def clear_orders(customer)
    orders = Order.where(customer_id: customer[:customer], status: 'in_progress')
    orders.each { |order| order.update(status: 'is_cancelled')}
  end

  def route(rider)
    order = Order.where(rider_id: rider[:rider], status: 'in_progress').last
    order.nil? ? [] : [order.restaurant, order.customer]
  end

  def delivery_time(customer)
    order = Order.where(customer_id: customer[:customer]).last
    order.define_time(order.rider, order.restaurant, order.distance)
  end

end
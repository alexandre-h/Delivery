class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant
  belongs_to :rider

  after_create :define_order_rider

  def define_order_rider
    customer = Customer.find_by(id: self.customer)
    restaurant = Restaurant.find_by(id: self.restaurant)
    customer_from_restaurant = DeliveryRouter.calcul_distance([customer.x, customer.y], [restaurant.x, restaurant.y]) unless  customer.nil? || restaurant.nil?
    Rider.all.each_with_index do |rider, index|
      rider_one_from_restaurant = DeliveryRouter.calcul_distance([rider.x, rider.y], [restaurant.x, restaurant.y]) if rider_one_from_restaurant.nil? && !customer.nil? || !restaurant.nil?
      unless rider_one_from_restaurant.nil?
        if rider[index + 1]
          # choose the actual saved rider to compare if have one,
          # if we want more riders
          rider_tmp = self.rider ? self.rider : rider[index + 1]
          rider_two_from_restaurant = DeliveryRouter.calcul_distance([rider_tmp.x, rider_tmp.y], [restaurant.x, restaurant.y])
          final_distance_rider_one = define_distance(customer_from_restaurant, rider_one_from_restaurant)
          final_distance_rider_two = define_distance(customer_from_restaurant, rider_two_from_restaurant)
          if final_distance_rider_one < final_distance_rider_two
            self.update(rider: rider)
          else
            self.update(rider: rider[index + 1])
          end
        end

      end
    end
  end

  def define_distance(customer_from_restaurant, rider_from_restaurant)
    final_distance = customer_from_restaurant + rider_from_restaurant

  end
end

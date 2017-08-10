require 'delivery_router'

class Order < ApplicationRecord

  belongs_to :customer
  belongs_to :restaurant
  belongs_to :rider

  scope :in_progress, -> (customer_id) {where("status IS 'in_progress' AND customer_id IS ?", customer_id)}
  scope :is_cancelled, -> (customer_id) {where("status IS 'is_cancelled' AND customer_id IS ?", customer_id)}

  after_create :define_order_rider

  def define_order_rider
    customer = Customer.find_by(id: self.customer.id)
    restaurant = Restaurant.find_by(id: self.restaurant.id)
    customer_from_restaurant = calcul_distance([customer.x, customer.y], [restaurant.x, restaurant.y])  unless  customer.nil? || restaurant.nil?
    riders = Rider.all.to_a
    riders.each_with_index do |rider, index|
      rider_one_from_restaurant = calcul_distance([rider.x, rider.y], [restaurant.x, restaurant.y]) if rider_one_from_restaurant.nil?
      unless rider_one_from_restaurant.nil?
        if riders[index + 1]
          rider_tmp = self.rider ? self.rider : riders[index + 1]
          rider_two_from_restaurant = calcul_distance([rider_tmp.x, rider_tmp.y], [restaurant.x, restaurant.y])
          final_distance_rider_one = define_distance(customer_from_restaurant, rider_one_from_restaurant, rider: rider, restaurant: restaurant)
          final_distance_rider_two = define_distance(customer_from_restaurant, rider_two_from_restaurant, rider: riders[index + 1], restaurant: restaurant)
          if final_distance_rider_one < final_distance_rider_two
            self.update(rider: rider, distance: final_distance_rider_one)
          else
            self.update(rider: riders[index + 1], distance: final_distance_rider_two)
          end
        end
      end
    end
  end

  def define_distance(customer_from_restaurant, rider_from_restaurant, opts = {})
    customer_from_restaurant + rider_from_restaurant
  end

  def define_time(rider, restaurant, distance)
    (distance / rider.speed) + restaurant.cooking_time
  end

  private

  def calcul_distance(p1, p2)
    sum_of_squares = 0
    p1.each_with_index do |p1_coord,index|
      sum_of_squares += (p1_coord - p2[index]) ** 2
    end
    Math.sqrt( sum_of_squares )
  end
end

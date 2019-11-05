require 'pp'

def find_item_by_name_in_collection(name, collection)
  collection.each do |item|
    if name == item[:item]
      return item
    end
  end
  nil
end

def consolidate_cart(cart)
  new_array = []
  cart.each do |item|
    item_found = false
    new_array.each do |new_item|
      if item[:item] == new_item[:item]
        new_item[:count] += 1 
        item_found = true 
      end 
    end
    if !item_found 
      new_array.push(item.merge({:count => 1}))
    end
  end
  new_array
end


def apply_coupons(cart, coupons)
  for i in 0..cart.length
    item = cart[i]
    coupons.each do |coupon|
      if item[:item] == coupon[:item]
        discounted_item_found = false
        cart.each do |inner_item|
          if inner_item[:item] == "#{item[:item]} W/COUPON"
            inner_item[:count] += coupon[:num]
            discounted_item_found = true
          end
        item[:count] -= coupon[:num]
        end
        if !discounted_item_found
          discounted_item = item.clone()
          discounted_item[:item] = "#{discounted_item[:item]} W/COUPON"
          discounted_item[:price] = coupon[:cost] / coupon[:num]
          discounted_item[:count] = coupon[:num]
          cart.push(discounted_item)
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end

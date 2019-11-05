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
  #loop ONLY through original array
  cart_length = cart.length
  for i in 0..cart_length
  
    # get the cart item at the 'i' index
    item = cart[i]
    
    # loop through each coupon
    coupons.each do |coupon|
      
      # if the cart item is the same as the coupon item
      if item[:item] == coupon[:item]
        
        # boolean to see if we've already added an entry for this coupon
        discounted_item_found = cart.any?{|h| h[:item] == "#{item[:item]} W/COUPON"}
        
        # loop through the cart array again to check for the coupon item
        cart.each do |inner_item|
          
          # if we've found the coupon item
          if inner_item[:item] == "#{item[:item]} W/COUPON"
            
            # update the count of the coupon item to reflect the newly applied coupon
            inner_item[:count] += coupon[:num]
            
            # and notify the loop that we've found the coupon item
            discounted_item_found = true
          end
          
        # decrease the count of the original item by the number in the coupon
        item[:count] -= coupon[:num]
        end
        
        # if we did not find a coupon item
        if !discounted_item_found
          
          # create a copy of the original item
          discounted_item = item.clone()
          
          # update the name so it's 'original item W/COUPON'
          discounted_item[:item] = "#{discounted_item[:item]} W/COUPON"
          
          # set the price to the coupon cost divided by the num covered by the coupon
          discounted_item[:price] = coupon[:cost] / coupon[:num]
          
          # initialize the coupon item's count to the num of the coupon
          discounted_item[:count] = coupon[:num]
          
          # add the coupon item to the cart
          cart.push(discounted_item)
        end
      end
    end
  end
  
  # return the cart (Holy Jebeebus)
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

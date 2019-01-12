def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |item|
    item.each do |food, data|
      item[food][:count] = cart.count(item)
      if cart_hash.has_key?(food) == false
        cart_hash[food] = data
      end
    end
  end
  cart_hash
end


def apply_coupons(cart, coupons)
  coupons.each do |deal|
    if cart.has_key?(deal[:item])
      if cart[deal[:item]][:count] >= deal[:num]
        cart[deal[:item]][:count] = cart[deal[:item]][:count] -   deal[:num]
        if cart.has_key?("#{deal[:item]} W/COUPON")
          cart["#{deal[:item]} W/COUPON"][:count] += 1
        else
          cart["#{deal[:item]} W/COUPON"] = {:price => deal[:cost], :clearance => cart[deal[:item]][:clearance], :count => 1}
        end
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |food, data|
    if data[:clearance] == true
      data[:price] = (data[:price] * 0.8).round(1)
    end
  end
end


def checkout(cart, coupons)
  total = 0
  puts coupons
  puts cart
  consolidate_cart(cart)
  puts cart
  apply_coupons(cart, coupons)
  puts cart
  apply_clearance(cart)
  puts cart
  cart.each do |food, data|
    total = total + (data[:price] * data[:count])
  end
  puts total
  puts cart
  if total > 100
    total = (total * 0.9).round(1)
  end
  total
end

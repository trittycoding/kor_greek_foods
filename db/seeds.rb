require 'csv'

# Resetting all tables
Productorder.delete_all
Order.delete_all
Product.delete_all
User.delete_all
Province.delete_all
Category.delete_all
AdminUser.delete_all
Page.delete_all

Page.create(
  title: 'About Us',
  content: 'Data powered by Unsplash and Faker',
  permalink: 'about_us'
)

Page.create(
  title: 'Contact Us',
  content: 'Feel free to contact us at korgreekproducts@example.com',
  permalink: 'contact_us'
)

# Creating categories
olive_oil = Category.create(name: 'Extra Virgin Olive Oil')
honey = Category.create(name: 'Honey and Bee Products')
olives = Category.create(name: 'Olives')
tea = Category.create(name: 'Tea & Herbs')

# Attaching images to categories
olive_oil.image.attach(io: File.open('app/assets/images/oliveoil.jpg'), filename: 'oliveoil.jpg')
honey.image.attach(io: File.open('app/assets/images/honey.jpg'), filename: 'honey.jpg')
olives.image.attach(io: File.open('app/assets/images/greenolives.jpg'), filename: 'greenolives.jpg')
tea.image.attach(io: File.open('app/assets/images/plants.jpg'), filename: 'plants.jpg')

# Creating Provinces
provinces = [{ name: 'British Columbia', abbreviation: 'B.C.', taxrate: 0.12, pst: 0.07, gst: 0.05, hst: nil },
             { name: 'Alberta', abbreviation: 'AB', taxrate: 0.05, pst: nil, gst: 0.05, hst: nil },
             { name: 'Saskatechewan', abbreviation: 'SK', taxrate: 0.11, pst: 0.06, gst: 0.05, hst: nil },
             { name: 'Manitoba', abbreviation: 'MB', taxrate: 0.12, pst: 0.07, gst: 0.05, hst: nil },
             { name: 'Ontario', abbreviation: 'ON', taxrate: 0.13, pst: nil, gst: nil, hst: 0.13 },
             { name: 'Quebec', abbreviation: 'QC', taxrate: 0.14975, pst: 0.0975, gst: 0.05, hst: nil },
             { name: 'New Brunswick', abbreviation: 'NB', taxrate: 0.15, pst: nil, gst: nil, hst: 0.15 },
             { name: 'Prince Edward Island', abbreviation: 'PE', taxrate: 0.15, pst: nil, gst: nil, hst: 0.15 },
             { name: 'Nova Scotia', abbreviation: 'NS', taxrate: 0.15, pst: nil, gst: nil, hst: 0.15 },
             { name: 'Newfoundland and Labrador', abbreviation: 'NL', taxrate: 0.15, pst: nil, gst: nil, hst: 0.15 },
             { name: 'Nunavut', abbreviation: 'NU', taxrate: 0.05, pst: nil, gst: 0.05, hst: nil },
             { name: 'Northwest Territories', abbreviation: 'NT', taxrate: 0.05, pst: nil, gst: 0.05, hst: nil },
             { name: 'Yukon', abbreviation: 'YK', taxrate: 0.05, pst: nil, gst: 0.05, hst: nil }]

provinces.each do |province|
  Province.create(name: province[:name], abbreviation: province[:abbreviation], province[:taxrate], province[:pst], province[:gst], province[:hst])
end

# Using Faker to generate placeholder data
# Products have a name, price, category, description and stock quantity

100.times do
  product = Product.create(name: Faker::Food.unique.ingredient,
                           price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
                           category: Category.all.sample,
                           stockquantity: Faker::Number.number(digits: 2),
                           description: Faker::Food.description,
                           on_sale: false,
                           amount_off: nil)

  # Calling unsplash API to gather images
  query2 = URI.encode_www_form_component([product.name])
  found_image2 = URI.open("https://source.unsplash.com/600x600?#{query2}")
  product.image.attach(io: found_image2, filename: "#{product.name}.jpg")

  # Output errors if not valid
  next if product&.valid?

  product.errors.messages.each do |column, errors|
    puts "Error with column - #{column}:"
    errors.each do |error|
      puts "Error - #{error}"
    end
  end
end


25.times do
  sale_product = Product.all.sample
  sale_product.on_sale = true
  sale_product.amount_off = Faker::Number.decimal(l_digits: 0, r_digits: 2)
  sale_product.save
end

puts "Created #{Category.count} categories"
puts "Created #{Product.count} products"
puts "Created #{Province.count} provinces"

# If the rails environment is development, use this as admin
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

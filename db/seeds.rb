require 'csv'

# Resetting all tables
Productorder.delete_all
Order.delete_all
Product.delete_all
User.delete_all
CustomerProvince.delete_all
Category.delete_all
AdminUser.delete_all

# filename = Rails.root.join("db/products.csv")
# csv_data = File.read(filename)
# products = CSV.parse(csv_data, headers: true, encoding: "utf-8")

# Creating categories
Category.create(name: 'Extra Virgin Olive Oil')
Category.create(name: 'Honey and Bee Products')
Category.create(name: 'Olives')
Category.create(name: 'Tea & Herbs')

# Creating Provinces
provinces = [{ name: 'British Columbia', abbreviation: 'B.C.' },
             { name: 'Alberta', abbreviation: 'AB' },
             { name: 'Saskatechewan', abbreviation: 'SK' },
             { name: 'Manitoba', abbreviation: 'MB' },
             { name: 'Ontario', abbreviation: 'ON' },
             { name: 'Quebec', abbreviation: 'QC' },
             { name: 'New Brunswick', abbreviation: 'NB' },
             { name: 'Prince Edward Island', abbreviation: 'PE' },
             { name: 'Nova Scotia', abbreviation: 'NS' },
             { name: 'Newfoundland and Labrador', abbreviation: 'NL' },
             { name: 'Nunavut', abbreviation: 'NU' },
             { name: 'Northwest Territories', abbreviation: 'NT' },
             { name: 'Yukon', abbreviation: 'YK' }]

provinces.each do |province|
  CustomerProvince.create(name: province[:name], abbreviation: province[:abbreviation])
end

# Using Faker to generate placeholder data
# Products have a name, price, category, description and stock quantity

100.times do
  product = Product.create(name: Faker::Food.unique.ingredient,
                           price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
                           category: Category.all.sample,
                           stockquantity: Faker::Number.number(digits: 2),
                           description: Faker::Food.description)

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
puts "Created #{Category.count} categories"
puts "Created #{Product.count} products"
puts "Created #{CustomerProvince.count} provinces"

# If the rails environment is development, use this as admin
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

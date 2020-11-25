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
  Province.create(name: province[:name], abbreviation: province[:abbreviation])
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
puts "Created #{Province.count} provinces"

# If the rails environment is development, use this as admin
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

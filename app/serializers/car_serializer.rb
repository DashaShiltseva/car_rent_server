# == Schema Information
#
# Table name: cars
#
#  id            :bigint           not null, primary key
#  condition     :integer          default(10), not null
#  edition_year  :integer          default(0), not null
#  engine_volume :float            default(2.0), not null
#  name          :string           default(""), not null
#  price_per_min :integer          default(1), not null
#  ready_to_rent :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  car_brand_id  :bigint
#  fuel_type_id  :bigint
#
# Indexes
#
#  index_cars_on_car_brand_id  (car_brand_id)
#  index_cars_on_fuel_type_id  (fuel_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_brand_id => car_brands.id)
#  fk_rails_...  (fuel_type_id => fuel_types.id)
#
class CarSerializer
  include JSONAPI::Serializer
  attributes :price_per_min, :name, :engine_volume, :edition_year, :condition,:ready_to_rent

  attribute :created_at do |user|
    user.created_at.to_date
  end

  belongs_to :fuel_type, meta: Proc.new {|o,p|
    {
      name: o.fuel_type.name,
    }
  }

  belongs_to :car_brand, meta: Proc.new {|o,p|
    {
      name: o.car_brand.name,
    }
  }

  has_one :image, meta: Proc.new {|o,p|
    {
      url: o.image.image_url
    }}

end

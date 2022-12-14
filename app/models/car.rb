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
class Car < ApplicationRecord

  # ready_to_rent - f.e. when car is under repair
  include Imagable

  validates :price_per_min, numericality: {greater_than_or_equal_to: 1}
  validates :engine_volume, numericality: {greater_than_or_equal_to: 0.1, less_than: 20.0}
  validates :edition_year, numericality: {greater_than_or_equal_to: 1900, less_than: Time.now.year+1}
  validates :condition, presence: true, numericality: {less_than: 11, greater_than_or_equal_to: 0}

  validates :name, presence: true

  belongs_to :fuel_type
  belongs_to :car_brand
  has_many :car_rents

  def to_restore!
    self.update(ready_to_rent: false)
  end

  def to_rent!
    self.update(ready_to_rent: true)
  end

  def full_name
    "#{self.car_brand.name} #{self.name}"
  end

end

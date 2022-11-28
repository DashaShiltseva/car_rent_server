# == Schema Information
#
# Table name: fuel_types
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FuelTypeSerializer
  include JSONAPI::Serializer
  attributes 
end

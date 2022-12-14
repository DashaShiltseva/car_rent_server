# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  amount      :integer          default(0), not null
#  is_paid     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  car_rent_id :bigint
#
# Indexes
#
#  index_payments_on_car_rent_id  (car_rent_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_rent_id => car_rents.id)
#
require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:payment) {build(:payment)}

  describe 'associations' do
    it { expect(payment).to belong_to(:car_rent) }
  end

  describe 'model methods' do
    describe '#paid!' do
      before do
        payment.paid!
      end

      it "payment paid" do
        expect(payment.is_paid).to be(true)
      end
    end
  end
end

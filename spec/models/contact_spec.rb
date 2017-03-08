# == Schema Information
#
# Table name: contacts
#
#  id            :integer          not null, primary key
#  email         :string
#  name          :string
#  custom_fields :hstore
#  deleted_at    :datetime
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { FactoryGirl.build_stubbed(:contact) }
  let(:contact) { FactoryGirl.build(:contact) }

  # RESPOND TO
  [:email, :name, :custom_fields, :deleted_at].each do |attr|
    it "should respond to #{attr}" do
      should respond_to attr
    end
  end

  # BELONGS TO
  [:user].each do |attr|
    it "should belong to #{attr}" do
      should belong_to attr
    end
  end

  # PRESENCE
  [:email, :user_id].each do |attr|
    it "should validate the presence of #{attr}" do
      should validate_presence_of attr
    end
  end
end

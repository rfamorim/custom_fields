# == Schema Information
#
# Table name: custom_fields
#
#  id         :integer          not null, primary key
#  name       :string
#  field_type :integer
#  options    :text             default("{}"), is an Array
#  deleted_at :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CustomField, type: :model do
  subject { FactoryGirl.build_stubbed(:custom_field) }
  let(:custom_field) { FactoryGirl.build(:custom_field) }

  # RESPOND TO
  [:name, :field_type, :options, :user_id, :deleted_at].each do |attr|
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
  [:name, :field_type, :user_id].each do |attr|
    it "should validate the presence of #{attr}" do
      should validate_presence_of attr
    end
  end

  # UNIQUENESS
  it "should validate the uniqueness of the name scoped to the user_id" do
    custom_field.should validate_uniqueness_of(:name).scoped_to(:user_id)
  end
end

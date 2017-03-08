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

FactoryGirl.define do
  factory :contact do
    email "MyString"
    name "MyString"
    custom_fields ""
    deleted_at "2017-03-08 01:32:34"
    user nil
  end
end

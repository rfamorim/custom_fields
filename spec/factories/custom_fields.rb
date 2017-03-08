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

FactoryGirl.define do
  factory :custom_field do
    name "MyString"
    field_type 1
    user nil
  end
end

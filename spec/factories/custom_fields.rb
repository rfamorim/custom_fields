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
    sequence(:name) { |n| "Nome #{n}" }
    sequence(:field_type) { |n| rand(0..2) }
    association :user

    after(:build) do |cf|
      if cf.field_type == "combobox" and cf.name != "Campo Personalizado Incorreto"
        cf.options = ["Opção 1", "Opção 2", "Opção 3"]
      end
    end

    factory :custom_field_without_options do
      name "Campo Personalizado Incorreto"
      association :user
      field_type "combobox"
      options nil
    end
  end
end

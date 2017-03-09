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
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:name) { |n| "Nome do Contato #{n}" }
    custom_fields {{ "Telefone" => "12345678", "Cidade" => "Florianópolis" }}
    association :user
  end
end

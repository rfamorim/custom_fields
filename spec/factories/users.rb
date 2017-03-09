# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  name                   :string
#  fields                 :string           default("{}"), is an Array
#  deleted_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'password123'
    password_confirmation 'password123'
    sequence(:name) { |n| "Nome do Usuário #{n}" }
  end
end

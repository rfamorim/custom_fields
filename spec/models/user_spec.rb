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
#  fields                 :string           default("{}"), is an Array
#  deleted_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.build_stubbed(:user) }
  let(:user) { FactoryGirl.build(:user) }

  # RESPOND TO
  [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :fields, :deleted_at].each do |attr|
    it "should respond to #{attr}" do
      should respond_to attr
    end
  end

  # HAS MANY DEPENDENDENT DESTROY
  [:contacts, :custom_fields].each do |attr|
    it "should have many #{attr}" do
      should have_many(attr).dependent(:destroy)
    end
  end

  # DEVISE MODULES
  [:database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable].each do |mod|
    it "should include the devise module" do
      expect(User.new.devise_modules).to include(mod)
    end
  end

  # PRESENCE
  [:email].each do |attr|
    it "should validate the presence of #{attr}" do
      should validate_presence_of attr
    end
  end

  # UNIQUENESS
  [:email].each do |attr|
    it "should validate the uniqueness of #{attr}" do
      user.should validate_uniqueness_of(attr).case_insensitive
    end
  end
end

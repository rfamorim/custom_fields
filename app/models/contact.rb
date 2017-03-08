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

class Contact < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  validates_presence_of :email, :user_id
end

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
  pending "add some examples to (or delete) #{__FILE__}"
end

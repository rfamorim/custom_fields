# == Schema Information
#
# Table name: custom_fields
#
#  id         :integer          not null, primary key
#  name       :string
#  type       :integer
#  options    :text             default("{}"), is an Array
#  deleted_at :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CustomField < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  validates_presence_of :name, :type

  enum type: { text: 0, textarea: 1, combobox: 2 }

  validates_presence_of :options, if: -> { self.type == "combobox" }

  validates_uniqueness_of :name, scope: :user_id

  after_create :set_field_on_user
  after_create :set_field_on_contacts

  after_destroy :remove_field_on_user
  after_destroy :remove_field_on_contacts

  private
    def set_field_on_user
      self.user.fields.push self.name
      self.user.save(validate: false)
    end

    def set_field_on_contacts
      self.user.contacts.each do |c|
        c.custom_fields.merge(self.name: "")
        c.save(validate: false)
      end
    end

    def remove_field_on_user
      self.user.fields.delete(self.name)
    end

    def remove_field_on_contacts
      self.user.contacts.each do |c|
        c.custom_fields.delete(self.name)
      end
    end
end

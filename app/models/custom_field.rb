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

class CustomField < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  validates_presence_of :name, :field_type, :user_id

  enum field_type: { text: 0, textarea: 1, combobox: 2 }

  validates_presence_of :options, if: -> { self.field_type == "combobox" }
  validates_absence_of :options, unless: -> { self.field_type == "combobox" }

  validates_uniqueness_of :name, scope: :user_id

  after_create :set_field_on_user, if: -> { self.user_id.present? }
  after_create :set_field_on_contacts, if: -> { self.user_id.present? }

  after_destroy :remove_field_on_user, if: -> { self.user_id.present? }
  after_destroy :remove_field_on_contacts, if: -> { self.user_id.present? }

  def self.field_types_collection_for_select
    self.enum_as_collection_for_select :field_types
  end

  private
    def set_field_on_user
      self.user.fields.push self.name
      self.user.save(validate: false)
    end

    def set_field_on_contacts
      self.user.contacts.each do |c|
        c.custom_fields.merge("#{self.name}": "")
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

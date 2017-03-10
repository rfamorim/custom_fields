class ActiveRecord::Base
  def self.enum_as_collection_for_select attribute
    valid_ones = self.send(attribute).keys

    if self.respond_to?("valid_#{attribute}")
      valid_ones = self.send("valid_#{attribute}")
    end

    valid_ones.map do |k|
      [
        I18n.t("activerecord.attributes.#{self.to_s.underscore}.#{attribute}.#{k}"),
        k.to_s
      ]
    end
  end
end

# frozen_string_literal: true

require 'uniqable/version'

# Generates uniq, random token for ActiveRecord model's fields
module Uniqable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def uniqable(*fields)
      fields = [:uid] if fields.blank?
      fields.each do |name|
        before_create { |record| record.uniqable_uid(name) }
      end
    end
  end

  def uniqable_uid(field)
    loop do
      send("#{field}=", SecureRandom.hex(8))
      break unless self.class.where(field => send(field.to_sym)).exists?
    end
  end
end

# frozen_string_literal: true

require 'uniqable/version'

# Generates uniq, random token for ActiveRecord model's fields
module Uniqable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    # Uniqable fields and options declaration
    # @example:
    #   uniqable :uid, :slug, to_param: :uid
    def uniqable(*fields, to_param: nil)
      fields = [:uid] if fields.blank?
      fields.each do |name|
        before_create { |record| record.uniqable_uid(name) }
      end
      define_singleton_method :uniqable_fields do
        fields
      end

      if to_param # :to_param option
        define_method :to_param do
          public_send(to_param)
        end
      end
    end

    # Find record by one of the uniq field
    # usage @example:
    #   uniqable :uid, :slug
    #   ...
    #   MyModel.find_uniqable params[:uid] # can be uid or slug column
    # @return [self]
    def find_uniqable(uid)
      where_sql = uniqable_fields.map{ |r| "#{table_name}.#{r} = :uid"}.join(' OR ')
      self.where(where_sql, uid: uid).take
    end
  end

  # Generate and set random and uniq field
  # @TODO: split into 2 actions generate and set
  def uniqable_uid(field)
    loop do
      send("#{field}=", SecureRandom.hex(8))
      break unless self.class.where(field => send(field.to_sym)).exists?
    end
  end
end

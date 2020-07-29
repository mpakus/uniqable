# frozen_string_literal: true

require 'uniqable/version'
require 'nanoid'

# Generates uniq, random token for ActiveRecord model's fields
module Uniqable
  def self.included(base)
    base.extend ClassMethods
  end

  # Methods going to be AR model's methods
  module ClassMethods
    # Uniqable fields and options declaration
    # @example:
    #   uniqable :uid, :slug, to_param: :uid
    # rubocop:disable Metrics/MethodLength
    def uniqable(*fields, to_param: nil)
      fields = [:uid] if fields.blank?
      fields.each do |name|
        before_create { |record| record.uniqable_uid(name) }
      end
      define_singleton_method :uniqable_fields do
        fields
      end

      return if to_param.blank? # :to_param option

      define_method :to_param do
        public_send(to_param)
      end
    end
    # rubocop:enable Metrics/MethodLength

    # @return [self]
    def where_uniqable(uid)
      where_sql = key_uid?(uid) ?
                      uniqable_fields.map { |r| "#{table_name}.#{r} = :uid" }.join(' OR ') :
                      "#{table_name}.#{primary_key} = :uid"
      where(where_sql, uid: uid)
    end

    # Find record by one of the uniq field
    # usage @example:
    #   uniqable :uid, :slug
    #   ...
    #   MyModel.find_uniqable params[:uid] # can be uid or slug column
    # @return [self]
    def find_uniqable(uid)
      where_uniqable(uid).take
    end

    # Same as method above just raise exception if nothing is there
    # @return [self]
    def find_uniqable!(uid)
      where_uniqable(uid).take!
    end

    private

    def key_uid?(uid)
      uid.to_s =~ /\D+/ || uid.to_s.length >= 16
    end
  end

  # Generate and set random and uniq field
  # @TODO: split into 2 actions generate and set
  def uniqable_uid(field)
    loop do
      uniq_code = Nanoid.generate(size: 16)
      if uniq_code =~ /\D+/
        send("#{field}=", uniq_code)
        break unless self.class.where(field => uniq_code).exists?
      end
    end
  end
end

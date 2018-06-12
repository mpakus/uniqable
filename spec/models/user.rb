# frozen_string_literal: true

# Simple user model with Uniqable fields and #to_param method generation
class User < ActiveRecord::Base
  include Uniqable

  uniqable :uid, :another_uid, to_param: :uid
end

# User model with own UID generator
class UserOwnUid < User
  def uniqable_uid(field)
    send("#{field}=", 'Darth Vader')
  end
end

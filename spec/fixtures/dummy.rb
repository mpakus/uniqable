# frozen_string_literal: true

# Dummy ActiveRecord simulation class
class DummyModel
  extend ActiveModel::Callbacks
  include ActiveModel::AttributeMethods
  include Uniqable

  attr_accessor :uid, :another_uid
  define_model_callbacks :create
  uniqable :uid, :another_uid

  def create
    run_callbacks :create do
      self
    end
  end

  def self.create
    new.create
  end

  def self.where(*_args)
    self
  end

  def self.exists?
    false
  end
end

# Dummy class
class Dummy < DummyModel; end

# Dummy class with own uid generator
class DummyOwnUid < DummyModel
  def uniqable_uid(field)
    send("#{field}=", 'Darth Vader')
  end
end

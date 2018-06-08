# frozen_string_literal: true

# Dummy ActiveRecord simulation class
class DummyModel
  extend ActiveModel::Callbacks
  include ActiveModel::AttributeMethods
  include Uniqable

  attr_accessor :uid, :another_uid
  define_model_callbacks :create
  uniqable :uid, :another_uid, to_param: :uid

  def create
    run_callbacks :create do
      self
    end
  end

  def take(_)
    self
  end

  class << self
    def table_name
      name.to_s.downcase
    end

    def create
      new.create
    end

    def where(*_args)
      self
    end

    def exists?
      false
    end
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

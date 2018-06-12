# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string :uid
    t.string :another_uid
    t.timestamps
  end
end

class AddParentToAnggarans < ActiveRecord::Migration[6.1]
  def change
    # TODO - Make Self References here | warning
    # NOTE - SKIP THIS MIGRATION , you have been warned twice
    add_reference :anggarans, :parent, class: 'Anggaran'
  end
end
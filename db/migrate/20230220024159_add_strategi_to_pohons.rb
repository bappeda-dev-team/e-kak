class AddStrategiToPohons < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference_concurrently :pohons, :strategi, null: true, index: true
  end
end

class RemoveImmutableStatsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :attack_power, :integer
    remove_column :users, :heal_power, :integer
  end
end

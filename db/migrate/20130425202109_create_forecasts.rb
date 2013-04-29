class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.datetime :day_1_time
      t.integer :day_1_low
      t.integer :day_1_high
      t.string :day_1_icon
      t.datetime :day_2_time
      t.integer :day_2_low
      t.integer :day_2_high
      t.string :day_2_icon
      t.datetime :day_3_time
      t.integer :day_3_low
      t.integer :day_3_high
      t.string :day_3_icon
      t.datetime :day_4_time
      t.integer :day_4_low
      t.integer :day_4_high
      t.string :day_4_icon
      t.datetime :day_5_time
      t.integer :day_5_low
      t.integer :day_5_high
      t.string :day_5_icon
      t.datetime :day_6_time
      t.integer :day_6_low
      t.integer :day_6_high
      t.string :day_6_icon
      t.datetime :day_7_time
      t.integer :day_7_low
      t.integer :day_7_high
      t.string :day_7_icon

      t.timestamps
    end
  end
end

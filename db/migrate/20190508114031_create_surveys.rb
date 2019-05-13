class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.integer :answer_1_place_1
      t.integer :answer_1_place_2
      t.integer :answer_1_place_3

      t.integer :answer_2_place_1
      t.integer :answer_2_place_2
      t.integer :answer_2_place_3

      t.integer :answer_3_place_1
      t.integer :answer_3_place_2
      t.integer :answer_3_place_3

      t.integer :answer_4_place_1
      t.integer :answer_4_place_2
      t.integer :answer_4_place_3

      t.text :note, default: ""
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

 
# Lp	Konkurencja	Wybór jednej delegatury
# 1	Najlepiej zorganizowana ekipa RSP	OBI, lub OBY lub OOL itd.
# 2	Najaktywniejsza ekipa RSP	OBI, lub OBY lub OOL itd.
# 3	Najbardziej merytoryczna ekipa RSP	OBI, lub OBY lub OOL itd.
# 4	Najbardziej zadbana i czysta RSP	OBI, lub OBY lub OOL itd.
 

class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.string :code_category
      t.string :code_cd
      t.string :code_value

      t.timestamps
    end
    create_default
  end

  def self.create_default
    Code.create :code_category   => 'Source of Info',:code_value=>'Friend', :code_cd=>'FN'
     Code.create :code_category   => 'Source of Info',:code_value=>'TV', :code_cd=>'TV'
      Code.create :code_category   => 'Source of Info',:code_value=>'Radio', :code_cd=>'RD'
       Code.create :code_category   => 'Source of Info',:code_value=>'Relative', :code_cd=>'RL'
        Code.create :code_category   => 'Source of Info',:code_value=>'Banner', :code_cd=>'BN'
	Code.create :code_category   => 'Source of Info',:code_value=>'Other', :code_cd=>'OT'
  end

  def self.down
    drop_table :codes
  end
end

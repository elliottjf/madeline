class PopulateCountries < ActiveRecord::Migration
  def up
    Country.create({id:1,name:'Argentina',code:'AR',default_language_id:2,default_currency_id:1})
    Country.create({id:2,name:'Nicaragua',code:'NI',default_language_id:2,default_currency_id:4})
    Country.create({id:3,name:'United States',code:'US',default_language_id:1,default_currency_id:2})
  end

  def down
    Country.destroy_all
  end
end

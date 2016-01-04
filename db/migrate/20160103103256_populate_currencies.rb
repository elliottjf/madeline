class PopulateCurrencies < ActiveRecord::Migration
  def up
    Currency.create({id:1,name:'Argentinean Peso',code:'ARS',symbol:'AR$'})
    Currency.create({id:2,name:'U.S. Dollar',code:'USD',symbol:'US$'})
    Currency.create({id:3,name:'British Pound',code:'GBP',symbol:'£'})
    Currency.create({id:4,name:'Nicaraguan Cordoba',code:'NIO',symbol:'NI$'})
  end

  def down
    Currency.destroy_all
  end
end

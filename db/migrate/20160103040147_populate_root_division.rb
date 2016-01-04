class PopulateRootDivision < ActiveRecord::Migration
  def up
    Division.create({id:Division::ROOT_ID, name:'Root', description:'Special system "root" division intended to be the parent of all other divisions'})
    Division.connection.execute("select setval('divisions_id_seq', greatest((select max(id)+1 from divisions), 100))")
  end

  def down
    Division.destroy_all
  end
end

namespace :tww do


  desc "migrate TWW data from legacy mysql to new postgres db"
  task :migrate_legacy => :environment do
    puts {"divisions: #{Legacy::Division.count}"}
    Legacy::Division.all.each &:migrate
    Division.connection.execute("SELECT setval('divisions_id_seq', (SELECT MAX(id) FROM divisions))")

    puts "loans: #{Legacy::Loan.count}"
    Legacy::Loan.all.each &:migrate
    Loan.connection.execute("SELECT setval('loans_id_seq', (SELECT MAX(id) FROM loans))")

    puts "loan translations: #{ Legacy::Translation.where('RemoteTable' => 'Loans').count }"
    Legacy::Translation.where('RemoteTable' => 'Loans').each &:migrate
    Translation.connection.execute("SELECT setval('translations_id_seq', (SELECT MAX(id) FROM translations))")

  end

  desc "purge target (postgres) data"
  task :purge_target_data => :environment do
    puts "Rails.logger.level: #{Rails.logger.level}"
    puts "Madeline::Translation.where(translatable_type: 'Loan').destroy_all"
    Translation.where(translatable_type: 'Loan').destroy_all
    puts "Madeline::Loan.destoy_all"
    Loan.destroy_all
    puts "Madeline::Division.where('id <> 99').delete_all"
    Division.where('id <> 99').delete_all  # note, destroy_all seems to be behaving erratically here via rake task

  end

end

puts "Seed is running in #{Rails.env} enviroment."
load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))
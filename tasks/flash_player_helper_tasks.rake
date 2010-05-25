namespace :flash_player do

  ROOT = File.dirname(__FILE__) + '/../'

  desc "Installs required files"
  task :install do
    FileUtils.cp_r Dir[ROOT + '/assets/others'], RAILS_ROOT + '/public'
    FileUtils.cp Dir[ROOT + '/assets/javascripts/*.js'], RAILS_ROOT + '/public/javascripts'
  end

  desc "Uninstalls files"
  task :remove do
    FileUtils.rm_rf RAILS_ROOT + '/public/others'
    FileUtils.rm_f %w{swfobject.js}.collect { |file| RAILS_ROOT + "/public/javascripts/" + file  }
  end
end
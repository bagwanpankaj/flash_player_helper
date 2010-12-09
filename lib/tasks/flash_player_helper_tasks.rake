namespace :flash_player do

  ROOT = File.dirname(__FILE__) + '/../../'

  desc "Installs required files"
  task :install do
    FileUtils.cp_r Dir[ROOT + '/assets/others'], ::Rails.root.to_s + '/public'
    FileUtils.cp Dir[ROOT + '/assets/javascripts/*.js'], ::Rails.root.to_s + '/public/javascripts'
  end

  desc "Uninstalls files"
  task :remove do
    FileUtils.rm_rf ::Rails.root.to_s + '/public/others'
    FileUtils.rm_f %w{swfobject.js}.collect { |file| ::Rails.root.to_s + "/public/javascripts/" + file  }
  end
end
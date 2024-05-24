# config/initializers/active_storage.rb

Rails.application.config.after_initialize do
  ActiveStorage::Current.url_options = {
    host: 'watch-list-app-2da478c9c126.herokuapp.com/',
    protocol: 'https'
  }
end

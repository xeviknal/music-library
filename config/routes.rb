MusicLibraryApp.router.config do
  get '/', to: 'home#index'
  post '/albums', to: 'albums#create'
end

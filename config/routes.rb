MusicLibraryApp.router.draw do
  get '/', to: 'albums#index'
  post '/albums', to: 'albums#create'
end

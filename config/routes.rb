MusicLibraryApp.router.draw do
  get     '/albums', to: 'albums#index'
  post    '/albums', to: 'albums#create'
  delete  '/albums', to: 'albums#destroy'

  get     '/tracks', to: 'tracks#index'
  post    '/tracks', to: 'tracks#create'
  delete  '/tracks', to: 'tracks#destroy'
end

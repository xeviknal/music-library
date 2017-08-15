MusicLibraryApp.router.draw do
  get     '/albums', to: 'albums#index'
  post    '/albums', to: 'albums#create'
  delete  '/albums', to: 'albums#destroy'
end

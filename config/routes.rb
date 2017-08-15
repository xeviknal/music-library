MusicLibraryApp.router.draw do
  get     '/albums', to: 'albums#index'
  delete  '/albums', to: 'albums#destroy'
end

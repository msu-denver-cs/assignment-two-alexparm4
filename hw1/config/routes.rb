Rails.application.routes.draw do
  resources :cars do   #parts made into a searchable collection,
    collection do       #citation: Slide 30 from 06RoutesSearch
      get 'search'
    end
  end
  resources :makes do   #parts made into a searchable collection,
    collection do       #citation: Slide 30 from 06RoutesSearch
      get 'search'
    end
  end
  resources :parts do   #parts made into a searchable collection,
    collection do       #citation: Slide 30 from 06RoutesSearch
      get 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

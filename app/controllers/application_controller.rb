class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @all = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    @recipe.save
# binding.pry
    redirect "/recipes/#{@recipe.id}"

  end

  get '/recipes/:id' do
# binding.pry
    @recipe = Recipe.find_by_id(params[:id])
# binding.pry
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
# binding.pry
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
# binding.pry
    @recipe.name = params[:recipe_name]
    @recipe.ingredients = params[:ingredients_names]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
# binding.pry
    recipe = Recipe.find_by_id(params[:id])
    recipe.delete
    redirect '/recipes'
  end



end
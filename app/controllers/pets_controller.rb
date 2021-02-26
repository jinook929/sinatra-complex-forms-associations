class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    # owner = Owner.find_by(id: params[:pet][:owner_id]) || Owner.create(params[:owner])
    # pet = Pet.create(name: params[:pet][:name], owner_id: owner.id)
    pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      pet.owner = Owner.create(params[:owner])
      pet.save
    end
    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])    
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find_by(id: params[:id])
    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    @pet.update(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end
    
    redirect to "pets/#{@pet.id}"
  end
end
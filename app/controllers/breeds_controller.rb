class BreedsController < ApplicationController

  before_action :set_breed, only: [:destroy, :show, :update, :update_tags]

  def index
    @breeds = Breed.all.map do |breed|
      breed_json(breed)
    end
    json_response(@breeds)
  end

  def show
    json_response(breed_json(@breed))
  end

  def create
    @breed = Breed.create!(name: breed_params[:name])
    tags = find_or_create_tags(params[:tags], @breed)
    if !tags.nil?
      @breed.tags = tags
    end
    @breed.save
    json_response(breed_json(@breed), :created)
  end

  def update
    @tags = find_or_create_tags(params[:tags], @breed)
    @breed.name = params[:name] || @breed.name
    @breed.tags = @tags || @breed.tags
    @breed.save
    head :no_content
  end

  def destroy
    @breed.destroy
    head :no_content
  end

  def update_tags
    tags = find_or_create_tags(params[:tags], @breed)
    @breed.tags = tags
    @breed.save
    json_response(breed_json(@breed))
  end

  def stats
    breeds = Breed.all.map do |breed|
        stats_json(breed)
    end
    json_response(breeds)
  end

  def stats_json(breed)
    tags = breed.tags
    {
      id: breed.id,
      name: breed.name,
      tag_count: breed.tags.size,
      tag_ids: tags.map { |tag| tag.id }
    }
  end

  def find_or_create_tags(tag_names, breed)
    if tag_names.nil?
      nil
    else
      tag_names.map do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name) do |tag|
          tag.name = tag_name
        end
        if !tag.breeds.include?(breed)
          tag.breeds.append(breed)
        end
        tag.save
        tag
      end
    end
  end

  def set_breed
    @breed = Breed.find(params[:id])
  end

  def breed_params
    params.permit(['name', 'tags'])
  end

  def update_tags_params
    params.permit(:tags)
  end

  def breed_json(breed)
    {
      name: breed.name,
      tags: breed.tags.map { |tag| tag.name  },
      id: breed.id
    }
  end

end

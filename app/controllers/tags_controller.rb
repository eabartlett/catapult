class TagsController < ApplicationController
  before_action :set_tag, only: [:destroy, :show, :update]

  def index
    json_response(Tag.all)
  end

  def show
    json_response(@tag)
  end

  def update
    @tag.name = tag_params[:name] || @tag.name
    @tag.save
    head :no_content
  end

  def destroy
    @tag.destroy
    head :no_content
  end

  def stats
    tags = Tag.all.map do |tag|
      stats_json(tag)
    end
    json_response(tags)
  end

  def stats_json(tag)
    breeds = tag.breeds
    {
      id: tag.id,
      name: tag.name,
      breed_count: breeds.size,
      breed_ids: breeds.map { |breed| breed.id }
    }
  end

  def tag_params
    params.permit([:name])
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end

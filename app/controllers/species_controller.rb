class SpeciesController < ApplicationController
  def index
    @species = Species.all
  end

  def new
    @species = Species.new

    set_kingdoms
  end

  def create
    @species = Species.new(species_params)

    if @species.save
      redirect_to species_index_path, notice: "Especie creada correctamente"
    else
      set_kingdoms
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_kingdoms
    @kingdoms ||= Species.kingdoms.keys.map { |k| [ k.titleize, k ] }
  end

  def species_params
    params.expect(species: [ :scientific_name, :kingdom, :phylum, :class_name, :order, :family, :genus, :epithet, :common_name ])
  end
end

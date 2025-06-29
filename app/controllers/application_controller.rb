class ApplicationController < ActionController::Base
  def load_species_map
    @species_map = Species.all.map { |s| [ "#{s.common_name} (#{s.scientific_name})", s.id ] }
  end
end

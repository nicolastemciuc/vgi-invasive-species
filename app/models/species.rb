class Species < ApplicationRecord
  enum :kingdom, [ :animalia, :plantae, :fungi, :protista, :bacteria, :archaea ]
end

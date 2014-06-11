class ApplicationSerializer < ActiveModel::Serializer
  # Sideload related data by default
  embed :ids, include: true
end
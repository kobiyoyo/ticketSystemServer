class DepartmentSerializer < ActiveModel::Serializer
  has_many :users
  attributes :id, :title, :created_at, :updated_at
end

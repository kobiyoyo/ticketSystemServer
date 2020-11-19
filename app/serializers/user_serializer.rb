class UserSerializer < ActiveModel::Serializer
  attributes :id ,:first_name, :last_name,:email,:role,:phone_no,:created_at,:updated_at,:active
  has_one :department
end

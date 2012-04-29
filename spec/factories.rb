Factory.define :user do |user|
  user.name                 	"Example User"
  user.email                	"intray@example.com"
  user.password             	"foobar"
  user.password_confirmation	"foobar"
  user.sign_up_code             "henry"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.define :shared_item do |shared_item|
  shared_item.id              "1"
  shared_item.user_id	      "1"
  shared_item.resource_id     "2"
  shared_item.resource_type   "image"
  shared_item.created_at      "2011-08-14 14:39:21.883906"
  shared_item.updated_at      "2011-08-14 14:39:21.883906"
  shared_item.shared_with_id  "2"
end

Factory.define :resource do |resource|
  resource.reference "example.com"
  resource.resource_type "link"
  resource.association :user
end

Factory.define :upload, :class => Resource do |f|
  f.upload { File.open(File.join(Rails.root, 'spec', 'fixtures', 'file.png')) }
  f.resource_type "file"
  f.association :user
end



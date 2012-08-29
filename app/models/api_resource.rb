class ApiResource < ActiveResource::Base
  self.site = "http://localhost:4000/services/"
  self.format = :json
end

# monkey patch for this issue: https://github.com/rails/rails/issues/2908
# should have been patched already, however still or again missing in 1.9.3p194

require 'active_resource/base'
require 'active_resource/validations'

module ActiveResource
  class Errors < ActiveModel::Errors
    def from_json(json, save_cache = false)
      array = ActiveSupport::JSON.decode(json).map { |k, v| v.map { |val| "#{k.humanize} #{val}" } }.flatten rescue []
      from_array array, save_cache
    end
  end
end

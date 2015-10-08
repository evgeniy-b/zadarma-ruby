require "active_support"
require "active_support/core_ext"
require "active_support/json"
require "active_support/hash_with_indifferent_access"

require "zadarma/methods.rb"
require "zadarma/client.rb"
require "zadarma/error.rb"

module Zadarma
  mattr_accessor :api_key, :api_secret, :log_requests
end

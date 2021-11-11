# frozen_string_literal: true

module Validation
  class ValidateNewCmd
    def call(storage_exists)
      !storage_exists
    end
  end
end

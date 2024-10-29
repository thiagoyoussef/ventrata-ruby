# frozen_string_literal: true

require "httparty"
require "json"
require "ventrata/version"
require "ventrata/base"
require "ventrata/supplier"
require "ventrata/product"
require "ventrata/availability"
require "ventrata/booking"

module Ventrata
  class Error < StandardError; end

  class << self
    attr_accessor :api_key
  end
end

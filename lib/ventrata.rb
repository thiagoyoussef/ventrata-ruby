# frozen_string_literal: true

require "httparty"
require "json"
require "ventrata/version"
require "ventrata/base"
require "ventrata/availability"
require "ventrata/booking"
require "ventrata/checkin"
require "ventrata/gift"
require "ventrata/identity"
require "ventrata/mapping"
require "ventrata/order"
require "ventrata/product"
require "ventrata/redemption"
require "ventrata/supplier"
require "ventrata/webhook"

module Ventrata
  class Error < StandardError; end

  class << self
    attr_accessor :api_key
  end
end

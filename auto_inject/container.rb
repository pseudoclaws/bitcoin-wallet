# frozen_string_literal: true

require 'dry-auto_inject'

Container = Dry::Container.new
Import = Dry::AutoInject(Container)

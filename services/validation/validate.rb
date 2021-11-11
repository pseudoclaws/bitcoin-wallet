# frozen_string_literal

def validate_new(storage_exists)
  !storage_exists

  puts 'Address has been already initialized'
  exit
end

def validate(storage_exists)
  storage_exists

  puts 'You should initialize address first'
  exit
end
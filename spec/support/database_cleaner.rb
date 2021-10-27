RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(
      :truncation,
      except: %w(ar_internal_metadata)
    )
  end

  config.before(:each) do
    Rails.cache.clear
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner.strategy = :truncation # for dookeeper application id
  end
end

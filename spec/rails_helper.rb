# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'simplecov'
SimpleCov.start
# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  # config.filter_sensitive_data('tmdb_key') { ENV['tmdb_key'] }
  config.default_cassette_options = { re_record_interval: 7.days }
  config.configure_rspec_metadata!
end

def test_data
  @market1 = create(:market)
  @market2 = create(:market)
  @market3 = create(:market)
  @market4 = create(:market)

  @vendor1 = create(:vendor)
  @vendor2 = create(:vendor)
  @vendor3 = create(:vendor)
  @vendor4 = create(:vendor)
  @vendor5 = create(:vendor)
  @vendor6 = create(:vendor)

  @market_vendor1 = create(:market_vendor, market: @market1, vendor: @vendor1)
  @market_vendor2 = create(:market_vendor, market: @market1, vendor: @vendor2)
  @market_vendor3 = create(:market_vendor, market: @market1, vendor: @vendor3)
  @market_vendor4 = create(:market_vendor, market: @market2, vendor: @vendor1)
  @market_vendor5 = create(:market_vendor, market: @market2, vendor: @vendor4)
  @market_vendor6 = create(:market_vendor, market: @market3, vendor: @vendor5)
  @market_vendor7 = create(:market_vendor, market: @market3, vendor: @vendor6)
  @market_vendor8 = create(:market_vendor, market: @market4, vendor: @vendor3)
end

def market_test_data
  # Market.destroy_all
  @market1 = create(:market,
                    name: 'King Soopers',
                    city: 'Cityville',
                    state: 'Colorado',
                    lat: '35.077529',
                    lon: '-106.600449')
  @market2 = create(:market,
                    name: 'Super kings',
                    city: 'Broomfield',
                    state: 'Colorado',
                    lat: '33.077529',
                    lon: '-104.600449')
  @market3 = create(:market,
                    name: 'FoodZone',
                    city: 'Naperville',
                    state: 'Illinois')
  @market4 = create(:market,
                    name: 'King Soopers',
                    city: 'Broomfield',
                    state: 'Colorado')
  @market5 = create(:market,
                    name: 'Cub Foods',
                    city: 'Edina',
                    state: 'Minnesota')
  @market6 = create(:market,
                    name: 'Marianos',
                    city: 'Minneapolis',
                    state: 'Colorado')
end

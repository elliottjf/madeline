Note: most configuration params which are specific to a local deployment can be factored out into yaml files or env vars.

Quick-start
- cp config/local_configs/_reference.yml config/local_configs/`hostname`.yml


Non-secure file
- used as a base file name which expanded to "#{Rails.root}/config/local_configs/#{ENV[MADELINE_LOCAL_CONFIG_NAME]}.yml"
- if MADELINE_LOCAL_CONFIG_NAME is not set, then defaults to hostname
- this file is expected to be checked into source control and should contain any system dependent config values which
  are not security sensitive
- naming convention proposal: "dev-[name]-[host]" for developer builds.  i.e. dev-elliott-kombucha
- this value is assigned to the system global 'LOCAL_CONFIG_NAME', and can be used to futher conditionalize any
  configuration blocks or code logic if needed.

Secure config data
  - #{Rails.root}/config/local_configs/#{local_config}-secure.yml
  - can be stored in a local .yml file pointed to by ENV[MADELINE_SECURE_LOCAL_CONFIG_PATH]
  - or relevant keys can simply be assigned in the system environment


These values can be pulled in by using an ERB snippet in any ERB processed .yaml file.
here is an example from database.yml:
  bucket: <%= LocalConfig.resolve('db_dev_username', 'madeline') %>

The first param to resolve() is the key, and the second param is a default value if not assigned in the environment
or a local config file.
The resolve order is: system environment, secure config file, local config file, default param

LocalConfig.resolve() can also be used directly in code for any configuration needs.

Further implementation details can be reviewed at the bottom of application.rb

Important caveat.  YAML files need to be loaded with the below pattern in order to be ERB processed:
  YAML::load(ERB.new(File.read(config_file)).result)


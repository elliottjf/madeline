#JFE: support for per deployment system config values which can be plugged into other erb yaml files
require 'socket'

class LocalConfig
  def self.load_config_map
    # beware, somehow when loading via the rails console there can be inconsistency with which system environment
    # is being accessed during the initial load
    hostname = ENV['HOSTNAME'] || Socket.gethostname
    local_name = ENV['MADELINE_LOCAL_CONFIG_NAME'] || hostname

    puts "base path: #{File.expand_path('.')}"
    local_config_file = File.expand_path("config/local_configs/#{local_name}.yml")

    local_config_secure_file = ENV['MADELINE_SECURE_LOCAL_CONFIG_PATH'] ||
        File.expand_path("config/local_configs/#{local_name}-secure.yml")

    result = {hostname: hostname, local_name: local_name, local_config_file: local_config_file}
    merge_file(result, local_config_file, 'local config')
    merge_file(result, local_config_secure_file, 'secure local config')

    result
  end

  def self.merge_file(base_hash, file_name, debug_name)
    if File.exists?(file_name)
      hash = load_config_file(file_name)
      if hash.is_a?(Hash)
        status = 'using'
        base_hash.merge!(hash)
      else
        status = 'invalid'
      end
    else
      status = 'missing'
    end
    puts "#{status} #{debug_name}:\n  #{file_name}\n\n"
  end

  def self.load_config_file(config_file)
    YAML::load(ERB.new(File.read(config_file)).result)
  end

  def self.config_map
    THE_CONFIG
  end

  def self.resolve(key, default=nil)
    key = key.to_s  # allow usage of symbol keys
    result = ENV[key]
    result ||= config_map.has_key?(key) ? config_map[key] : default  # can't just do an CONFIG[key] || default because of potentially blank values like db password
    begin
      log_result = key.downcase =~ /secret|access|password|secure/ && result.is_a?(String) ? "...#{result[-3,3]}" : result
      log_message = "LocalConfig.resolve(#{key}) = '#{log_result}'"
      if defined?(Rails.logger)
        Rails.logger.debug(log_message)
      else
        puts log_message
      end
    rescue Exception => e
      puts "e: #{e.inspect}\n#{e.backtrace.join('\n')}"
    end
    result
  end

   THE_CONFIG = load_config_map

end


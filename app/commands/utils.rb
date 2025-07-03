require 'addressable/uri'

module Utils
  module_function

  def logger_color(message, color = :default)
    colors = {
      red: "\e[31m",
      green: "\e[32m",
      yellow: "\e[33m",
      blue: "\e[34m",
      default: "\e[32m"
    }

    ::Rails.logger.info("\n")
    ::Rails.logger.info("#{colors[color]}Logger debugging: #{message}")
    ::Rails.logger.info("\n")
  end

  def parse_expired_time(signed_url)
    uri = Addressable::URI.parse(signed_url)
    query_params = uri.query_values || {}
  
    if uri.host&.include?('cloudfront') && query_params['Expires']
      return Time.at(query_params['Expires'].to_i)
    elsif query_params['X-Amz-Expires'] && query_params['X-Amz-Date']
      created_at = Time.strptime(query_params['X-Amz-Date'], '%Y%m%dT%H%M%SZ')
      return created_at + query_params['X-Amz-Expires'].to_i
    end

    nil
  end
  
  def key_from_filename(filename)
    logger_color(filename)
    ::File.basename(filename, '.*').parameterize
  end
end

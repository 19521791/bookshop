module Utils
  module_function

  def logger_color(string)
    green = "\033[32m"
    reset = "\033[0m"

    ::Rails.logger.info("\n")
    ::Rails.logger.info("#{green}Logger debugging: #{string}#{reset}")
    ::Rails.logger.info("\n")
  end

  def parse_expired_time(signed_url)
    query_params = URI.parse(signed_url).query
    return nil unless query_params
  
    params_hash = URI.decode_www_form(query_params).to_h
    
    amz_date = params_hash['X-Amz-Date']
    expires_in = params_hash['X-Amz-Expires']
  
    return nil unless amz_date && expires_in
  
    created_at = Time.strptime(amz_date, '%Y%m%dT%H%M%SZ')
    expired_at = created_at + expires_in.to_i
  
    expired_at
  end
  
  
end

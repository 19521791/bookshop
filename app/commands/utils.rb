module Utils
  module_function

  def logger_color(string)
    green = "\033[32m"
    reset = "\033[0m"

    ::Rails.logger.info("\n")
    ::Rails.logger.info("#{green}Logger debugging: #{string}#{reset}")
    ::Rails.logger.info("\n")
  end
end

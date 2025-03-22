module V1
  module Aws
    class CheckSignedUrl
      prepend ::SimpleCommand
  
      def call
        ::Attachment.all.map { |attachment| presenter(attachment) } 
      end
  
      def presenter(attachment)
        {
          file: attachment.file_name,
          expired_at: attachment.expired_at.iso8601,
          time_remaining: calculate_time_remaining(attachment)
        }
      end
  
      def calculate_time_remaining(attachment)
        time_left = attachment.expired_at - ::Time.current
  
        days = (time_left / ( 60 * 60 * 24 )).to_i
        hours = ((time_left % (60 * 60 * 24)) / (60 * 60)).to_i
        minutes = ((time_left % (60 * 60)) / 60).to_i
        seconds = (time_left % 60).to_i
  
        "#{days} days, #{hours} hours, #{minutes} minutes, #{seconds} seconds"
      end
    end
  end
end
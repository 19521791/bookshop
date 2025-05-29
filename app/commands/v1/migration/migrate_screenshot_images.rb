module V1
  module Migration
    class MigrateScreenshotImages
      prepend ::SimpleCommand
  
      def call
        img_arr.each do |file_name|
          ::Attachment.find_or_create_by!(file_name: file_name) do |attachment|
            attachment.container = 'aws-s3'
          end
        end
      end

      def img_arr
        [
          'ninedash-5.png',
          'ninedash-4.png',
          'ninedash-3.png',
          'ninedash-2.png',
          'ninedash-1.png',
          'laneline-1.png',
          'laneline-2.png',
          'laneline-3.png',
          'laneline-4.png',
          'laneline-5.png',
          'note-1.png',
          'note-2.png',
          'note-3.png',
          'note-4.png',
          'trello-1.png',
          'trello-2.png',
          'trello-3.png',
          'trello-4.png',
          'portfolio-1.png',
          'portfolio-2.png',
          'portfolio-3.png',
          'portfolio-4.png',
          'portfolio-5.png',
          'trafficlight-1.jpg',
          'trafficlight-2.jpg',
          'trafficlight-3.jpg',
          'trafficlight-4.jpg',
          'trafficlight-5.jpg',
          'trafficlight-6.jpg',
          'trafficlight-7.jpg'
        ]
      end
    end
  end
end


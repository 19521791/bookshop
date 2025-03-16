require 'uri'
require 'time'
require 'active_support/all'

module V1
  module Migration
    class MigrateSignedUrl
      prepend ::SimpleCommand

      def call
        signed_urls.each do |name, signed_url|
          expired_at_vn = parse_expired_time(signed_url)

          ::Attachment.create(
            file_name: name.to_s,
            container: 'aws-s3',
            signed_url:,
            expired_at: expired_at_vn
          )
        end
      end

      private

      def parse_expired_time(signed_url)

        query_params = ::URI.parse(signed_url).query
        params_hash = ::URI.decode_www_form(query_params).to_h

        amz_date = params_hash['X-Amz-Date']
        created_at = ::Time.strptime(amz_date, "%Y%m%dT%H%M%SZ").in_time_zone("UTC")

        expired_at = params_hash["X-Amz-Expires"].to_i
        expired_at_vn = (created_at + expired_at.seconds).in_time_zone("Asia/Ho_Chi_Minh")

        expired_at_vn
      end

      def signed_urls
        clown = 'https://douglus.s3.ap-southeast-1.amazonaws.com/clown.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T020204Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6fbceb68150ccc720d869a581fb9d4cea9ddd6e1e53198b5a96b77d76645e095'
        pencil = 'https://douglus.s3.ap-southeast-1.amazonaws.com/image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T060944Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=90a15ef0cc11b4a2e0108a64424fa52087440b16448018a2fcc2eebcd357f218'
        ninedash = 'https://douglus.s3.ap-southeast-1.amazonaws.com/project_icons/nine-dash.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061512Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=3232dfb4d70fbe9c73c58d7ccee133f826e21a6f5fcca4f0858c6a1e3badd2fe'
        note = 'https://douglus.s3.ap-southeast-1.amazonaws.com/project_icons/note.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061604Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f74767111d1703296a436c1a07a802796005cfc8d07172ddc04d0dde239800cb'
        trelloboard = 'https://douglus.s3.ap-southeast-1.amazonaws.com/project_icons/trello-board.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061649Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=48c6f46a8a88ab43cdcfb2bfb3c1ccecc286fddea261d328e091e59262a126b2'
        helloclever = 'https://douglus.s3.ap-southeast-1.amazonaws.com/project_icons/hello-clever.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T095951Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5da2053edde2d56f279b273b7d6eb233c61524785f687a126ed6c52d1cebe34d'

        css = 'https://douglus.s3.ap-southeast-1.amazonaws.com/css.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T054741Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=bc44839192c63e814ed7fd4d688d9a2a3d111a90f114aa29c0478361314de157'
        express = 'https://douglus.s3.ap-southeast-1.amazonaws.com/express.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T054845Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d879dc534c96837f1c5afc0cf941500ac9e6b17d54a979abbfa2e503fa263430'
        git = 'https://douglus.s3.ap-southeast-1.amazonaws.com/git.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T054919Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4267633115cd95220cf00073dc4ca073428cf40d36202d7118b8070f5f208a92'
        github = 'https://douglus.s3.ap-southeast-1.amazonaws.com/github.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T060701Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4ef131c05a175859f77128c18fbc1112ba1fe298b813e17560f8e7d07eb940b6'
        html = 'https://douglus.s3.ap-southeast-1.amazonaws.com/html.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T060756Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=dd58a7b87fc239699151255a668f8a34cb082916bb8298e97f1f678db4d211e3'
        favicon = 'https://douglus.s3.ap-southeast-1.amazonaws.com/ice_favicon.ico?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T060840Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=1b05b298f907b316161564d5cb32816f24f989aebfc2524c28deb9eed569a497'
        javascript = 'https://douglus.s3.ap-southeast-1.amazonaws.com/javascript.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061014Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=7621a4feb07a08b03c7d279b0fde608a7d523f1c94358f4347ed18e197f3144b'
        linkedin = 'https://douglus.s3.ap-southeast-1.amazonaws.com/linkedin.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061048Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4f3eeebbf9a903466592a6b41955893e5c042daa349adde52f2644da90dd1057'
        mongodb = 'https://douglus.s3.ap-southeast-1.amazonaws.com/mongodb.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061128Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=3fc0b26404e522cdcb139ffffbf6df17fefae961ca2aa5727caa6c9d3506fc66'
        nodejs = 'https://douglus.s3.ap-southeast-1.amazonaws.com/nodejs.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061152Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=fb4b5451e32148c794112229c327e017bac746a35787a9795f50dde23d512a04'
        python = 'https://douglus.s3.ap-southeast-1.amazonaws.com/python-svgrepo-com.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061258Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=92a510cad25df34968c36427543dd9b7b7252492f567e05d4683834c5fc80618'
        rails = 'https://douglus.s3.ap-southeast-1.amazonaws.com/rails-svgrepo-com.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061343Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=90ff9801f0e162dc7fb0fedc6cdb04a70ede7e011ad07e2a5b7e2e3c7001402f'
        ruby = 'https://douglus.s3.ap-southeast-1.amazonaws.com/ruby-svgrepo-com.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061407Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c89f43095cc8dbae897699a1c950732a988def5661504de8f9a22dd2095d18a8'
        reactjs = 'https://douglus.s3.ap-southeast-1.amazonaws.com/react.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T061428Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ea6a9ee25240c026f39f9b9a81a09c6f72a07f1667f742a07ebb702158edd913'
        arrow = 'https://douglus.s3.ap-southeast-1.amazonaws.com/arrow.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250312%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250312T100112Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=732b5c41c37fed41f5ba26bc34df502692e361349bd64eee767fcb0f7a1686e2'
        whale = 'https://douglus.s3.ap-southeast-1.amazonaws.com/whale.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAWAA66FXGPGBUMN6S%2F20250314%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250314T145022Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=039e4ea7c726ca1b71d65f816a99a13d65e5a54b65368c03b0a834b1b1725817'

        signed_urls = {
          'clown.png': clown,
          'image.png': pencil,
          'project_icons/nine-dash.png': ninedash,
          'project_icons/note.png': note,
          'project_icons/trello-board.png': trelloboard,
          'project_icons/hello-clever.png': helloclever,
          'css.svg': css,
          'express.svg': express,
          'git.svg': git,
          'github.svg': github,
          'html.svg': html,
          'ice_favicon.ico': favicon,
          'javascript.svg': javascript,
          'linkedin.svg': linkedin,
          'mongodb.svg': mongodb,
          'nodejs.svg': nodejs,
          'python-svgrepo-com.svg': python,
          'rails-svgrepo-com.svg': rails,
          'ruby-svgrepo-com.svg': ruby,
          'react.svg': reactjs,
          'arrow.svg': arrow,
          'whale.png': whale
        }
      end
    end
  end
end

class HelloController < ApplicationController
    def index
        @data = User.all
    end
end

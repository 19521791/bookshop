class V1::Users::Register
    prepend SimpleCommand

    def call
        @user = User.new
        return @user
    end
end
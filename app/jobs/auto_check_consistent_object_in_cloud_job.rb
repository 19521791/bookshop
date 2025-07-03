class AutoCheckConsistentObjectInCloudJob < ApplicationJob
  queue_as :default

  def perform
    ::V1::Aws::CheckConsistentS3Object.call
  end
end

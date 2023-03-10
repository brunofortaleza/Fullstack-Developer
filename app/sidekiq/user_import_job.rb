class UserImportJob
  include Sidekiq::Worker

  def perform(file_path, import_id)
    UserImportService.new(file_path, import_id).run
  end
end

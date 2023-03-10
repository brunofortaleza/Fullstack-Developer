class UserImportsController < ApplicationController

  def index
    authorize! :access, :user_imports

    @imports = Import.order(created_at: :desc)
  end

  def create
    authorize! :access, :user_imports

    if params[:file].present?
      import = Import.create(file_name: params[:file].original_filename, status: :processing)
      UserImportService.new(params[:file].path, import.id).run
      redirect_to user_imports_path, notice: "A importação foi iniciada com sucesso!"
    end

    # @import = Import.new(import_params)
    # if @import.save
    #   ImportWorker.perform_async(@import.id)
    #   redirect_to imports_path, notice: "A importação foi iniciada com sucesso!"
    # else
    #   render :new
    # end
  end

  private

  def import_params
    params.require(:import).permit(:file)
  end
end

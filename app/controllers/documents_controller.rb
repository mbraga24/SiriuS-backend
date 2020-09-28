class DocumentsController < ApplicationController
  def index
    documents = Document.all
    
    render json: documents
  end

  def create
    img_file = Cloudinary::Uploader.upload(params[:file], "format" => 'jpg')

    document = Document.create(name: params[:fileName], url: img_file["url"], project_id: params[:projectId], user_id: params[:userId])
    render json: document

    # current date
    # Time.now
    # display date as "September/28/2020" 
    # Document.first.created_at.strftime("%B/%d/%Y")
    # Time.now.strftime("%B/%d/%Y")
  end
end

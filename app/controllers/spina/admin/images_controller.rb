module Spina
  module Admin
    class ImagesController < AdminController
      before_action :set_breadcrumbs

      layout "spina/admin/media_library"

      def index
        add_breadcrumb I18n.t('spina.website.images'), spina.admin_images_path
        @media_folders = MediaFolder.order(:name)
        @images = Image.sorted.where(media_folder_id: nil).with_attached_file.page(params[:page])
        @image = Image.new
      end

      def create
        image = Image.create
        image.file.attach(params[:image][:file])
        redirect_to spina.admin_images_path
      end

      private

        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.website.media_library'), spina.admin_media_library_path
        end

    end
  end
end
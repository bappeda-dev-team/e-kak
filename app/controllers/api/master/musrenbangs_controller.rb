module Api
  module Master
    class MusrenbangsController < ActionController::API
      before_action :set_musrenbang,
                    only: %i[show edit update destroy aktifkan_usulan non_aktifkan_usulan diambil_asn]
      respond_to :json
      # GET /musrenbangs or /musrenbangs.json
      def index
        @tahun = params[:tahun]
        @musrenbangs = Musrenbang.where(tahun: @tahun)
                                 .order(:updated_at)
      end

      def usulan_musrenbang
        # TODO: Pisah per OPD user masing masing ( nunggu API )
        @musrenbangs = Musrenbang.belum_diajukan
                                 .or(Musrenbang.where(nip_asn: current_user.nik))
                                 .order(:updated_at)
                                 .select { |m| m.opd_dituju&.id_opd_skp == current_user.opd.id_opd_skp or current_user.has_role? :super_admin }
        render 'user_musrenbang'
      end

      def diambil_asn
        @musrenbang = Musrenbang.find(params[:id])
        @status = 'aktif'
        @nip_asn = params[:nip_asn]
        if @musrenbang.update(nip_asn: @nip_asn, status: @status)
          @musrenbang.toggle! :is_active
          flash.now[:success] = 'Usulan berhasil diambil'
        else
          flash.now[:error] = 'Usulan gagal diambil'
          :unprocessable_entity
        end
      end

      # TODO: delete, depreceated
      def asn_musrenbang
        nip_asn = params[:nip]
        @musrenbangs = Musrenbang.where(nip_asn: nip_asn)
        @musrenbang = Musrenbang.new
      end

      def musrenbang_search
        param = params[:q] || ''
        @musrenbangs = Search::AllUsulan
                       .where(
                         "searchable_type = 'Musrenbang' and sasaran_id is null and usulan ILIKE ?", "%#{param}%"
                       )
                       .where(searchable: Musrenbang.where(nip_asn: current_user.nik))
                       .order(searchable_id: :desc)
                       .includes(:searchable)
                       .collect(&:searchable)
      end

      def toggle_is_active
        @musrenbang = Musrenbang.find(params[:id])
        respond_to do |format|
          if @musrenbang.update(status: 'aktif')
            @musrenbang.toggle! :is_active
            flash.now[:success] = 'Usulan diaktifkan'
            format.js { render 'toggle_is_active' }
          else
            flash.now[:alert] = 'Gagal Mengaktifkan'
            format.js { :unprocessable_entity }
          end
        end
      end

      def setujui_usulan_di_sasaran
        @musrenbang = Musrenbang.find(params[:id])
        respond_to do |format|
          if @musrenbang.update(status: 'disetujui')
            @musrenbang.toggle! :is_active
            flash.now[:success] = 'Usulan disetujui'
            format.js { render 'toggle_is_active' }
          else
            flash.now[:alert] = 'Gagal Mengaktifkan'
            format.js { :unprocessable_entity }
          end
        end
      end

      def update_opd
        @musrenbang = Musrenbang.with_kamus
        @musrenbang.map do |m|
          m.update(opd: m.kamus_usulans.first.id_unit)
          m.update(usulan: m.kamus_usulans.first.usulan)
        end
        flash[:success] = 'Usulan disesuaikan dengan kamus'
        redirect_to musrenbangs_path
      end

      # TODO: hapus nanti
      def aktifkan_usulan
        respond_to do |format|
          format.js { render :aktifkan_usulan } if @musrenbang.update_attribute(:is_active, 1)
        end
      end

      def non_aktifkan_usulan
        respond_to do |format|
          format.js { render :non_aktifkan_usulan } if @musrenbang.update_attribute(:is_active, 0)
        end
      end

      # GET /musrenbangs/1 or /musrenbangs/1.json
      def show; end

      # GET /musrenbangs/new
      def new
        @musrenbang = Musrenbang.new
      end

      # GET /musrenbangs/1/edit
      def edit; end

      # POST /musrenbangs or /musrenbangs.json
      def create
        @musrenbang = Musrenbang.new(musrenbang_params)

        if @musrenbang.save
          render json: { resText: "Entri Musrenbang ditambahkan" }.to_json,
                 status: :created
        else
          render json: { resText: "Terjadi kesalahan", errors: @musrenbang.errors }.to_json,
                 status: :unprocessable_entity
        end
      end

      # PATCH/PUT /musrenbangs/1 or /musrenbangs/1.json
      def update
        if @musrenbang.update(musrenbang_params)
          render json: { resText: "Perubahan tersimpan",
                         html_content: html_content({ musrenbang: @musrenbang },
                                                    partial: 'musrenbangs/musrenbang') }.to_json,
                 status: :ok
        else
          render json: { resText: "Terjadi kesalahan",
                         html_content: error_content({ musrenbang: @musrenbang },
                                                     partial: 'musrenbangs/form') }.to_json,
                 status: :unprocessable_entity
        end
      end

      # DELETE /musrenbangs/1 or /musrenbangs/1.json
      def destroy
        @musrenbang.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_musrenbang
        @musrenbang = Musrenbang.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def musrenbang_params
        params.require(:musrenbang).permit!
      end
    end
  end
end

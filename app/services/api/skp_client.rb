# frozen_string_literal: true

module Api
  # Client for SKP API
  class SkpClient
    require 'http'
    require 'oj'
    URL = 'https://skp.madiunkota.go.id/api'
    H = HTTP.accept(:json)
    attr_accessor :kode_opd, :bulan, :tahun, :nip_asn

    USERNAME = 'bappeda'
    PASSWORD = 'bapp7832KH'

    def initialize(kode_opd, tahun, bulan = '', nip_asn = '')
      # @kode_opd = '2.16.2.20.2.21.04.0000'
      # @tahun = 2022
      # @bulan = 2
      # tipe_asn = 'pns' | 'non_pns'
      @kode_opd = kode_opd
      @tahun = tahun
      @bulan = bulan
      @nip_asn = nip_asn
    end

    def data_sasaran_asn_opd
      request_skp(kode_opd, tahun, bulan, nip_asn)
    end

    def data_pegawai
      request_pegawai(kode_opd, tahun, bulan)
    end

    def update_pegawai
      request = data_pegawai
      update_data_pegawai(request)
    end

    def update_sasaran
      request = data_sasaran_asn_opd
      update_data_sasaran(request)
    end

    def update_struktur
      request = request_struktur(kode_opd, tahun, bulan)
      update_struktur_pegawai(request)
    end

    def update_opd
      request = request_sasaran_opd(kode_opd, tahun)
      update_sasaran_opd(request)
    end

    def update_kota
      request = reqeust_sasaran_kota
      update_sasaran_kota(request)
    end

    def tujuan_opd
      request = request_tujuan_opd(kode_opd, tahun)
      update_tujuan_opd(request)
    end

    def request_skp(kode_opd, tahun, bulan, nip_asn)
      H.post("#{URL}/sasaran-kinerja-pegawai/#{kode_opd}/#{tahun}/#{bulan}/#{nip_asn}",
             form: { username: USERNAME, password: PASSWORD })
    end

    def request_pegawai(kode_opd, tahun, bulan)
      H.post("#{URL}/data-pegawai-all/#{kode_opd}/#{tahun}/#{bulan}",
             form: { username: USERNAME, password: PASSWORD })
    end

    def request_struktur(kode_opd, tahun, bulan)
      H.post("#{URL}/struktur_pegawai/#{kode_opd}/#{tahun}/#{bulan}",
             form: { username: USERNAME, password: PASSWORD })
    end

    def request_sasaran_opd(kode_opd, tahun)
      H.post("#{URL}/opd-sasaran",
             form: { username: USERNAME, password: PASSWORD, unit_id: kode_opd, tahun: tahun })
    end

    def request_tujuan_opd(kode_opd, tahun)
      H.post("#{URL}/opd-tujuan",
             form: { username: USERNAME, password: PASSWORD, unit_id: kode_opd, tahun: tahun })
    end

    def reqeust_sasaran_kota
      H.post("#{URL}/kota-sasaran",
             form: { username: USERNAME, password: PASSWORD })
    end

    private

    def update_data_sasaran(response)
      data = Oj.load(response.body)
      pegawais = data['data']['data_pegawai']
      pegawais.each do |pegawai|
        next unless pegawai['list_rencana_kinerja']

        sasaran_items(pegawai)
      end
    end

    def update_data_pegawai(response)
      kode_opd = Opd.find_by(kode_unik_opd: @kode_opd).kode_opd || '0'
      data = Oj.load(response.body)
      pegawais = data['data']
      data_pegawais = []
      pegawais.each do |pegawai|
        email = "#{pegawai['nip']}@madiunkota.go.id"
        nip = pegawai['nip']
        nama = pegawai['nama']
        jabatan = pegawai['jabatan']
        eselon = pegawai['eselon']
        pangkat = pegawai['pangkat']
        nama_pangkat = pegawai['nama_pangkat']
        id_bidang = pegawai['id_bidang']
        nama_bidang = pegawai['nama_bidang']
        password = User.new(password: 123_456).encrypted_password
        data_pegawais << { kode_opd: kode_opd, nik: nip, nama: nama, jabatan: jabatan,
                           eselon: eselon, pangkat: pangkat, nama_pangkat: nama_pangkat,
                           id_bidang: id_bidang, nama_bidang: nama_bidang, email: email,
                           encrypted_password: password,
                           created_at: Time.now, updated_at: Time.now }
      end
      data_pegawais.each do |data_p|
        User.upsert(data_p, unique_by: :nik)
      end
    end

    def update_struktur_pegawai(response)
      kode_opd = Opd.find_by(kode_unik_opd: @kode_opd).kode_opd || '0'
      data = Oj.load(response.body)
      pegawais = data['data']['data_pegawai']
      data_pegawais = []
      pegawais.each do |pegawai|
        nip = pegawai['nip']
        atasan = pegawai['atasan_nip']
        atasan_nama = pegawai['atasan_nama']
        data_pegawais << { kode_opd: kode_opd, nik: nip, atasan: atasan, atasan_nama: atasan_nama }
      end
      kepala = data_pegawais.select { |pegawai| pegawai[:atasan].blank? }.first[:nik]
      data_pegawais.each do |data_p|
        tipe = ''
        tipe = if data_p[:atasan].blank?
                 'Kepala'
               elsif data_p[:atasan].present? && data_p[:atasan] == kepala
                 'Atasan'
               else
                 'User'
               end
        data_p.store(:type, tipe)
        u = User.find_by(nik: data_p[:nik])
        u&.update(data_p)
      end
    end

    # TODO: DRY UP THIS, DUPLICATE CODE !!!
    def update_sasaran_opd(response)
      data = Oj.load(response.body)
      sasarans = data['data']
      sasarans.each do |sasaran|
        data_sasaran = {
          id_rencana: sasaran['id'],
          sasaran_kinerja: sasaran['sasaran'],
          sasaran_opd: sasaran['unit_id'], type: 'SasaranOpd',
          created_at: Time.now, updated_at: Time.now
        }

        sasaran['indikators'].each do |indikator|
          data_indikator = {
            indikator: indikator['indikator'],
            jenis: 'Sasaran',
            sub_jenis: 'Opd',
            kode: indikator['id_sasaran']
          }
          ranges = (2020..2024).to_a
          ranges.each.with_index(1) do |tahun, index|
            data_tahun = {
              tahun: tahun,
              target: indikator["target_#{index}"],
              satuan: indikator["target_#{index}"]
            }
            data_input = data_indikator.merge(data_tahun)
            Indikator.insert(data_input)
          end
        end
        SasaranOpd.upsert(data_sasaran, unique_by: :id_rencana)
      end
    end

    def update_tujuan_opd(response)
      data = Oj.load(response.body)
      tujuans = data['data']
      tujuans.each do |tujuan|
        data_tujuan = {
          id_tujuan: tujuan['id'],
          tujuan: tujuan['tujuan'],
          type: 'TujuanOpd',
          kode_unik_opd: tujuan['unit_id'],
          created_at: Time.now, updated_at: Time.now
        }

        tujuan['indikators'].each do |indikator|
          data_indikator = {
            indikator: indikator['indikator'],
            jenis: 'Tujuan',
            sub_jenis: 'Opd',
            kode: indikator['id_tujuan']
          }
          ranges = (2020..2024).to_a
          ranges.each.with_index(1) do |tahun, index|
            data_tahun = {
              tahun: tahun,
              target: indikator["target_#{index}"],
              satuan: indikator["target_#{index}"]
            }
            data_input = data_indikator.merge(data_tahun)
            Indikator.insert(data_input)
          end
        end
        TujuanOpd.upsert(data_tujuan, unique_by: :id_tujuan)
      end
    end

    def update_sasaran_kota(response)
      data = Oj.load(response.body)
      sasarans = data['data']
      sasarans.each do |sasaran|
        data_sasaran = {
          id_rencana: sasaran['id'],
          tahun: "#{sasaran['tahun_awal']}-#{sasaran['tahun_akhir']}",
          sasaran_kinerja: sasaran['sasaran_teks'],
          type: 'SasaranKota',
          sasaran_atasan: sasaran['tujuan_teks'],
          sasaran_opd: sasaran['misi_teks'],
          sasaran_kota: sasaran['visi_teks'],
          created_at: Time.now, updated_at: Time.now
        }
        SasaranKota.upsert(data_sasaran, unique_by: :id_rencana)
        next unless sasaran['indikators']

        sasaran['indikators'].each do |ind_sas_kota|
          data_indikator = {
            indikator_kinerja: ind_sas_kota['indikator'],
            target: ind_sas_kota['target_3'],
            satuan: ind_sas_kota['satuan_3'],
            sasaran_id: ind_sas_kota['id_sasaran_lokal'],
            id_indikator: ind_sas_kota['id'],
            type: 'IndikatorSasaranKota',
            created_at: Time.now, updated_at: Time.now
          }
          IndikatorSasaran.upsert(data_indikator, unique_by: :id_indikator)
        end
      end
    end

    def sasaran_items(sasarans)
      sasarans['list_rencana_kinerja'].each do |rencana|
        data_sasaran = {
          sasaran_atasan_id: rencana['id_referensi'],
          sasaran_atasan: rencana['rekin_atasan'],
          sasaran_kota: rencana['sasaran_kota'],
          sasaran_kinerja: rencana['rencana_kerja'],
          indikator_kinerja: nil, target: nil, satuan: nil,
          nip_asn: sasarans['nip'], id_rencana: rencana['id'],
          created_at: Time.now, updated_at: Time.now
        }
        Sasaran.upsert(data_sasaran, unique_by: :id_rencana)
        next unless rencana['list_indikator']

        indikator_items(rencana)
        next unless rencana['list_rencana_aksi']

        tahapan_items(rencana)
      end
    end

    def indikator_items(rencana)
      rencana['list_indikator'].each do |indikator|
        data_indikator = { indikator_kinerja: indikator['iki'],
                           target: indikator['target'], satuan: indikator['satuan'],
                           aspek: indikator['aspek'], sasaran_id: rencana['id'],
                           id_indikator: indikator['id'],
                           created_at: Time.now, updated_at: Time.now }
        IndikatorSasaran.upsert(data_indikator, unique_by: :id_indikator)
        manual_ik_items(indikator)
      end
    end

    def manual_ik_items(indikator)
      indikator['list_manual_ik'].each do |manual_ik|
        sasaran_id = IndikatorSasaran.find_by(id_indikator: indikator['id']).sasaran.id
        gambaran_umum = "#{manual_ik['tujuan_rencana_kinerja']}, #{manual_ik['definisi']}"
        data_manual_ik = {
          gambaran_umum: gambaran_umum, sasaran_id: sasaran_id,
          id_indikator_sasaran: indikator['id'],
          created_at: Time.now, updated_at: Time.now
        }
        LatarBelakang.upsert(data_manual_ik, unique_by: :id_indikator_sasaran)
      end
    end

    def tahapan_items(rencana)
      rencana['list_rencana_aksi'].each do |rencana_aksi|
        id_rencana = rencana_aksi['id_rencana_kerja']
        tahapan_kerja = rencana_aksi['tahapan_kerja']
        id_rencana_aksi = rencana_aksi['id']
        data_tahapan = {
          tahapan_kerja: tahapan_kerja,
          id_rencana_aksi: id_rencana_aksi,
          id_rencana: id_rencana, created_at: Time.now, updated_at: Time.now
        }
        Tahapan.upsert(data_tahapan, unique_by: :id_rencana_aksi) unless data_tahapan.blank?
        rencana_aksi_items(rencana_aksi)
      end
    end

    def rencana_aksi_items(rencana_aksi)
      rencana_aksi['list_bulan'].each do |aksi|
        bulan = aksi['bulan']
        target = aksi['target']
        id_rencana_aksi = aksi['id_tahapan']
        id_aksi_bulan = aksi['id']
        next if target.to_i.zero?

        data_renaksi = {
          bulan: bulan, target: target.to_i,
          id_rencana_aksi: id_rencana_aksi,
          id_aksi_bulan: id_aksi_bulan,
          created_at: Time.now, updated_at: Time.now
        }
        Aksi.upsert(data_renaksi, unique_by: :id_aksi_bulan) unless data_renaksi.blank?
      end
    end
  end
end

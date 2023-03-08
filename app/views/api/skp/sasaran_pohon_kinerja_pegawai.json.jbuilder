json.message "Data Sasaran Kinerja ASN Pohon Kinerja - KAK"
json.data do
  json.nama_asn @user.nama
  json.nip @nip
  json.tahun @tahun
  json.kode_opd @user.opd.kode_unik_opd
  json.opd @user.opd.nama_opd
  json.jumlah_sasaran @sasarans.size
  json.sasaran_asn @sasarans do |sasaran|
    json.id_sasaran sasaran.id_rencana
    json.tahun_sasaran sasaran.tahun
    json.nip_asn sasaran.nip_asn
    json.sasaran sasaran.sasaran_kinerja
  end
end

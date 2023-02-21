json.results do
  json.id 0
  json.name "Perangkat Daerah"
  json.type "root"
  json.description @nama_opd
  json.tahun @tahun
  if @pohons.any?
    json.children @pohons do |pohon|
      json.id pohon.id
      json.name "Isu Strategis"
      json.type "isu_strategis"
      json.description pohon.keterangan
      json.children pohon.strategis do |strategi|
        json.id "#{strategi.id}_objective"
        json.name "Strategic Objective"
        json.type "strategic_objective"
        json.description strategi.strategi
        json.children strategi.strategi_eselon_tigas do |tactical|
          json.id "#{tactical.id}_tactical"
          json.name "Tactical Objective"
          json.type "tactical_objective"
          json.description tactical.strategi || "dibagikan ke #{tactical.nip_asn}"
          json.children tactical.strategi_eselon_empats do |operational|
            json.id "#{operational.id}_operational"
            json.name "Operational Objective"
            json.type "operational_objective"
            json.description operational.strategi || "dibagikan ke #{operational.nip_asn}"
            json.children operational.strategi_staffs do |staff|
              json.id "#{staff.id}_staff"
              json.name "Operational Objective 2"
              json.type "operational_2"
              json.description staff.strategi || "dibagikan ke #{staff.nip_asn}"
            end
          end
        end
      end
    end
  else
    json.children do
      json.id 100
      json.name "Strategic Objective"
      json.type "strategic_objective"
      json.description "Belum Menyusun Pohon Kinerja"
    end
  end
end
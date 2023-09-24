module AnggaranPohon
  class Strategic
    def initialize(strategi)
      @strategi = strategi
    end

    def hitung_anggaran
      anggaran_total
    end

    def programs
      child_pohons.map(&:programs).flatten.uniq.compact_blank
    end

    private

    def child_pohons
      @strategi.strategi_bawahans.map do |tact|
        AnggaranPohon::Tactical.new(tact)
      end
    rescue NoMethodError
      []
    end

    def anggaran_childs
      @strategi.strategi_bawahans.map do |tact|
        anggarans = AnggaranPohon::Tactical.new(tact)
        anggarans.hitung_anggaran
      end
    rescue NoMethodError
      false
    end

    def anggaran_total
      return unless anggaran_childs

      anggaran_childs
        .flatten
        .compact_blank.sum
    end
  end
end

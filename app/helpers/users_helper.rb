module UsersHelper
  def nama_asn(nik:)
    User.find_by(nik: nik)&.nama
  end

  def dropdown_opd_user(user)
    if super_admin?
      options_for_select(Opd.where.not(kode_opd: nil).pluck(:nama_opd, :kode_opd), user.opd.kode_opd)
    else
      options_for_select(Opd.where.not(kode_opd: nil).where(kode_opd: user.opd.kode_opd).pluck(:nama_opd, :kode_opd),
                         user.opd.kode_opd)
    end
  end

  def subkegiatan_data(kode_sub_giat)
    ProgramKegiatan.find_by(kode_sub_giat: kode_sub_giat)
  end

  def komentator?
    current_user.has_any_role?(:super_admin, :reviewer)
  end

  def super_admin?
    current_user.has_role?(:super_admin)
  end

  def reviewer?
    current_user.has_role?(:reviewer_kak)
  end

  def selected_user(user)
    options_for_select([[user.nama, user.nik]], selected: user.nik)
  end
end

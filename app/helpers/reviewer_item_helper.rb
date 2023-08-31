module ReviewerItemHelper
  def reviewer_items
    [
      {
        title: 'Pohon Kinerja Kota', href: kota_pohon_kinerja_index_path,
        icon: 'fas fa-tree', identifier: 'pohon_kinerja/kota'
      },
      {
        title: 'Pohon Kinerja OPD', href: manual_pohon_kinerja_index_path,
        icon: 'fas fa-tree', identifier: 'pohon_kinerja'
      },
      {
        title: 'Pohon Kinerja Cascading', href: cascading_pohon_kinerja_index_path,
        icon: 'fas fa-tree', identifier: 'pohon_kinerja'
      }
    ]
  end

  def laporan_reviewer_items
    [
      {
        title: 'Rencana Kinerja (KAK)', href: laporan_kak_laporans_path,
        icon: 'fas fa-bullseye', identifier: 'laporan_kak'
      },
      {
        title: 'Rincian Belanja', href: laporan_rka_laporans_path,
        icon: 'fas fa-money-check', identifier: 'laporan_rka'
      },
      {
        title: 'Renstra', href: renstra_laporans_path,
        icon: 'fas fa-stream', identifier: 'renstra'
      },
      {
        title: 'Renja', href: "#",
        multi: true,
        collections: laporan_renja_items,
        id_target: 'renja-items',
        icon: 'fas fa-tasks', identifier: 'renja'
      }
    ]
  end
end

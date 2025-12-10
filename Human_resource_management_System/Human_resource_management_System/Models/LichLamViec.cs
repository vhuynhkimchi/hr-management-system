namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LichLamViec")]
    public partial class LichLamViec
    {
        public int id { get; set; }

        [Required]
        [StringLength(20)]
        public string maNhanVien { get; set; }

        public int maCa { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayLamViec { get; set; }

        [StringLength(200)]
        public string ghiChu { get; set; }

        public virtual CaLamViec CaLamViec { get; set; }

        public virtual NhanVien NhanVien { get; set; }
    }
}

﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Avakids2.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class AVAKIDEntities2 : DbContext
    {
        public AVAKIDEntities2()
            : base("name=AVAKIDEntities2")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<CTHoaDon> CTHoaDons { get; set; }
        public virtual DbSet<Hang> Hangs { get; set; }
        public virtual DbSet<HoaDon> HoaDons { get; set; }
        public virtual DbSet<KhachHang> KhachHangs { get; set; }
        public virtual DbSet<Nganh> Nganhs { get; set; }
        public virtual DbSet<NhanVien> NhanViens { get; set; }
        public virtual DbSet<SanPham> SanPhams { get; set; }
    
        public virtual int NHANVIEN_TimKiem(string manv, string tennv)
        {
            var manvParameter = manv != null ?
                new ObjectParameter("Manv", manv) :
                new ObjectParameter("Manv", typeof(string));
    
            var tennvParameter = tennv != null ?
                new ObjectParameter("Tennv", tennv) :
                new ObjectParameter("Tennv", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("NHANVIEN_TimKiem", manvParameter, tennvParameter);
        }
    
        public virtual int SANPHAM_TimKiem(string masp, string tensp)
        {
            var maspParameter = masp != null ?
                new ObjectParameter("Masp", masp) :
                new ObjectParameter("Masp", typeof(string));
    
            var tenspParameter = tensp != null ?
                new ObjectParameter("Tensp", tensp) :
                new ObjectParameter("Tensp", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SANPHAM_TimKiem", maspParameter, tenspParameter);
        }
    }
}

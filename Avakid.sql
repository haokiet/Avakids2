create database AVAKID
go
use AVAKID
go
create table NhanVien(	MaNV varchar(10) primary key,
						TenDangNhap varchar(50) not null,
						MatKhau varchar(20) not null,
						HoNV nvarchar(20) not null,
						TenNV nvarchar(20) not null,
						NgaySinh date ,
						NgayLamViec date not null,
						DiaChi nvarchar(100),
						GioiTinh bit,
						SoDT char(11))

create table Hang(	MaHang varchar(10) primary key,
					TenHang nvarchar(50) not null,
					DiaChi nvarchar(100) not null,
					Email varchar(50) not null,
					SoDT char(11) )

create table Nganh(	MaNganh varchar(10) primary key,
						TenNganh nvarchar(50) not null)

create table KhachHang(	MaKH varchar(10) primary key,
						HoKH nvarchar(20) not null,
						TenKH nvarchar(20) not null,
						SoDT char(11) not null,
						DiaChi nvarchar(100),
						TenDN varchar(50) not null,
						MatKhau varchar(20) not null)

create table HoaDon(	SoHD varchar(10) primary key,
						MaKH varchar(10) references KhachHang(MaKH) not null,
						MaNVDuyet varchar(10) references NhanVien(MaNV) not null,
						MaNVGiaoHang varchar(10) references NhanVien(MaNV) not null,
						DiaChiGiaoHang nvarchar(100) not null,
						TinhTrang nvarchar(20) not null,
						NgayDatHang date not null,
						NgayGiaoHang date)


create table SanPham(	MaSP varchar(10) primary key,
						MaHang varchar(10) references Hang(MaHang) not null,
						MaNganh varchar(10) references Nganh(MaNganh) not null,
						TenSP nvarchar(50) not null,
						MoTaSP ntext,
						AnhSP varchar(100),
						Dongia int,
						DonViTinh nvarchar(10),
						SoLuong int)

create table CTHoaDon(	SoHD varchar(10) ,
						MaSP varchar(10),
						SoLuong int,
						DonGia int,
						primary key(SoHD,MaSP),
						foreign key(SoHD) references HoaDon(SoHD),
						foreign key(SoHD) references SanPham(MaSP))

go

CREATE PROCEDURE SANPHAM_TimKiem
    @Masp varchar(10)=NULL,
	@Tensp nvarchar(20)=NULL
AS
BEGIN
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM SanPham
       WHERE  (1=1)
       '
IF @Masp IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (MaSP LIKE ''%'+@Masp+'%'')
              '
IF @Tensp IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (TenSP LIKE N''%'+@Tensp+'%'')
              '

	EXEC SP_EXECUTESQL @SqlStr
END

go

CREATE PROCEDURE NHANVIEN_TimKiem
    @Manv varchar(10)=NULL,
	@Tennv nvarchar(40)=NULL
AS
BEGIN
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM NhanVien
       WHERE  (1=1)
       '
IF @Manv IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (MaNV LIKE ''%'+@Manv+'%'')
              '
IF @Tennv IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (HoNV+'' '' + TenNV LIKE N''%'+@Tennv+'%'')
              '

	EXEC SP_EXECUTESQL @SqlStr
END


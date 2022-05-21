create database AVAKID
go
use AVAKID
go
create table NhanVien(	MaNV varchar(10) primary key,
						TenDangNhap varchar(20) not null,
						MatKhau varchar(20) not null,
						HoNV nvarchar(20) not null,
						TenNV nvarchar(20) not null,
						NgaySinh date ,
						NgayLamViec date not null,
						DiaChi nvarchar(50),
						GioiTinh bit,
						SoDT char(11))

create table Hang(	MaHang varchar(10) primary key,
					TenHang nvarchar(20) not null,
					DiaChi nvarchar(50) not null,
					Email varchar(20) not null,
					SoDT char(11) )

create table Nganh(	MaNganh varchar(10) primary key,
						TenNganh nvarchar(20) not null)

create table KhachHang(	MaKH varchar(10) primary key,
						HoKH nvarchar(20) not null,
						TenKH nvarchar(20) not null,
						SoDT char(11) not null,
						DiaChi nvarchar(50),
						TenDN varchar(20) not null,
						MatKhau varchar(20) not null)

create table HoaDon(	SoHD varchar(10) primary key,
						MaKH varchar(10) references KhachHang(MaKH) not null,
						MaNVDuyet varchar(10) references NhanVien(MaNV) not null,
						MaNVGiaoHang varchar(10) references NhanVien(MaNV) not null,
						DiaChiGiaoHang nvarchar(50) not null,
						TinhTrang nvarchar(20) not null,
						NgayDatHang date not null,
						NgayGiaoHang date)


create table SanPham(	MaSP varchar(10) primary key,
						MaHang varchar(10) references Hang(MaHang) not null,
						MaNganh varchar(10) references Nganh(MaNganh) not null,
						TenSP nvarchar(20) not null,
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


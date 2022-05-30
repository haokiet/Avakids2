create database AVAKID
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
						TenSP nvarchar(200) not null,
						MoTaSP ntext,
						AnhSP varchar(200),
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
GO
INSERT INTO dbo.Hang(MaHang, TenHang, DiaChi, Email, SoDT)
VALUES ('119616','Nestle Cerelac','Viet Nam','cerelac@gmail.com','0123456789'),
	('119044','Vinamilk','Viet Nam','vinamilk@gmail.com','0123456789'),
	('201725','Abbott grow','Viet Nam','abbottgrow@gmail.com','0123456789'),
	('118617','Pediasure','Viet Nam','pediasure@gmail.com','0123456789'),
	('118637','Bobby','Viet Nam','bobby@gmail.com','0123456789'),
	('119430','Huggies','Viet Nam','huggies@gmail.com','0123456789'),
	('119448','Pampers','Viet Nam','pampers@gmail.com','0123456789'),
	('119677','Optimum','Viet Nam','optimum@gmail.com','0123456789'),
	('119675','Nutifood','Viet Nam','nutifood@gmail.com','0123456789'),
	('119440','Merries','Viet Nam','merries@gmail.com','0123456789'),
	('118640','Moony','Viet Nam','moony@gmail.com','0123456789'),
	('119617','Nutifood','Viet Nam','nutifood@gmail.com','0123456789'),
	('164928','GOO.N','Viet Nam','goo.n@gmail.com','0123456789'),
	('157379','Caryn','Viet Nam','caryn@gmail.com','0123456789'),
	('118618','Similac','Viet Nam','similac@gmail.com','0123456789'),
	('119650','Dielac','Viet Nam','dielac@gmail.com','0123456789'),
	('118613','Similac','Viet Nam','similac@gmail.com','0123456789'),
	('137592','Ensure','Viet Nam','ensure@gmail.com','0123456789'),
	('129885','Friso','Viet Nam','friso@gmail.com','0123456789'),
	('118976','Pigeon','Viet Nam','pigeon@gmail.com','0123456789'),
	('119021','Gerber','Viet Nam','gerber@gmail.com','0123456789'),
	('119669','Meta Care','Viet Nam','metacare@gmail.com','0123456789'),
	('119676','Nutricare','Viet Nam','nutricare@gmail.com','0123456789'),
	('119670','Morinaga','Viet Nam','morinaga@gmail.com','0123456789'),
	('119030','Manna','Viet Nam','manna@gmail.com','0123456789'),
	('150766','Meiji','Viet Nam','meiji@gmail.com','0123456789'),
	('119688','Vinamilk','Viet Nam','vinamilk@gmail.com','0123456789'),
	('119015','Boro','Viet Nam','boro@gmail.com','0123456789'),
	('150763','Meiji','Viet Nam','meiji@gmail.com','0123456789'),
	('119014','Bellamys Organic','Viet Nam','sorganic@gmail.com','0123456789'),
	('121932','Glico','Viet Nam','glico@gmail.com','0123456789'),
	('119037','Pigeon','Viet Nam','pigeon@gmail.com','0123456789'),
	('118982','Wesser','Viet Nam','wesser@gmail.com','0123456789'),
	('138019','Nestlé Nan','Viet Nam','nestlénan@gmail.com','0123456789'),
	('140296','BioJunior','Viet Nam','biojunior@gmail.com','0123456789'),
	('152334','Piyopiyo','Viet Nam','piyopiyo@gmail.com','0123456789'),
	('119654','Friso','Viet Nam','friso@gmail.com','0123456789'),
	('118972','Kuku','Viet Nam','kuku@gmail.com','0123456789'),
	('118615','Aptamil','Viet Nam','aptamil@gmail.com','0123456789'),
	('151024','Aptakid','Viet Nam','aptakid@gmail.com','0123456789'),
	('129872','DK Pharma','Viet Nam','dkpharma@gmail.com','0123456789'),
	('130550','Lansinoh','Viet Nam','lansinoh@gmail.com','0123456789'),
	('143870','Plasmon','Viet Nam','plasmon@gmail.com','0123456789'),
	('122894','Heinz','Viet Nam','heinz@gmail.com','0123456789'),
	('119226','Optimum','Viet Nam','optimum@gmail.com','0123456789'),
	('118977','Pur','Viet Nam','pur@gmail.com','0123456789'),
	('152354','KuKu','Viet Nam','kuku@gmail.com','0123456789'),
	('118967','Gluck','Viet Nam','gluck@gmail.com','0123456789'),
	('118611','Enfa','Viet Nam','enfa@gmail.com','0123456789'),
	('118616','Enfa','Viet Nam','enfa@gmail.com','0123456789'),
	('119657','Hipp','Viet Nam','hipp@gmail.com','0123456789'),
	('119023','Hipp','Viet Nam','hipp@gmail.com','0123456789'),
	('118964','Chuchu Baby','Viet Nam','chuchubaby@gmail.com','0123456789'),
	('118975','Philips Avent','Viet Nam','avent@gmail.com','0123456789'),
	('142596','Indofood','Viet Nam','indofood@gmail.com','0123456789'),
	('142599','Sun','Viet Nam','sun@gmail.com','0123456789'),
	('150205','Wakodo','Viet Nam','wakodo@gmail.com','0123456789'),
	('150217','Wakodo','Viet Nam','wakodo@gmail.com','0123456789'),
	('165614','Colosbaby','Viet Nam','colosbaby@gmail.com','0123456789'),
	('188602','Nutren','Viet Nam','nutren@gmail.com','0123456789')
GO
INSERT INTO dbo.Nganh(MaNganh, TenNganh)
VALUES ('2605',N'Ăn dặm cho bé'),
	('9079',N'Sữa bột cho bé'),
	('2427',N'Tã cho bé'),
	('2382',N'Sữa bầu'),
	('8683',N'Bình sữa')
GO
INSERT INTO dbo.SanPham(MaSP, MaNganh, MaHang, TenSP, MoTaSP, AnhSP, Dongia, DonViTinh, SoLuong)
VALUES ('76073','2605','119616',N'Bột ăn dặm Nestlé Cerelac gà hầm cà rốt hộp 200g (từ 8 tháng)',N'Ăn dặm cho bé Nestle Cerelac','bot-an-dam-nestle-cerelac-ga-ham-ca-rot-tu-8-thang-200g-060122-013754-600x600.jpg','58900','Cái','100'),
('76074','2605','119616',N'Bột ăn dặm Nestlé Cerelac gạo lức trộn sữa hộp 200g (từ 6 tháng)',N'Ăn dặm cho bé Nestle Cerelac','bot-an-dam-nestle-cerelac-gao-luc-tron-sua-hop-200g-tu-6-thang-600x600.jpg','58900','Cái','100'),
('76075','2605','119616',N'Bột ăn dặm Nestlé Cerelac gạo và trái cây hỗn hợp hộp 200g (từ 6 tháng)',N'Ăn dặm cho bé Nestle Cerelac','bot-an-dam-nes-gao-tcay-hon-hop-060122-012140-600x600.jpg','58900','Cái','100'),
('76076','2605','119616',N'Bột ăn dặm Nestlé Cerelac lúa mì sữa hộp 200g (từ 6 tháng)',N'Ăn dặm cho bé Nestle Cerelac','bot-an-dam-nes-lua-mi-sua-100522-124546-600x600.jpg','58900','Cái','100'),
('76082','2605','119044',N'Bột ăn dặm Ridielac Gold heo và cà rốt hộp 200g (7 - 24 tháng)',N'Ăn dặm cho bé Vinamilk','bot-ad-ridielac-heo-ca-rot-hg-200g-160422-042513-600x600.jpg','58900','Cái','100'),
('76687','9079','201725',N'Sữa bột Abbott Grow số 2 hương vani 900g (6 - 12 tháng)',N'Sữa bột cho bé Abbott grow','sua-bot-abbott-grow-2-lon-900g-6-12-thang-600x600.jpg','536000','Hộp','100'),
('76688','9079','201725',N'Sữa bột Abbott Grow số 3 hương vani 900g (1 - 2 tuổi)',N'Sữa bột cho bé Abbott grow','sua-bot-abbott-grow-3-lon-900g-1-2-tuoi-9-600x600.jpg','536000','Hộp','100'),
('76689','9079','201725',N'Sữa bột Abbott Grow Gold 3+ hương vani 900g (3 - 6 tuổi)',N'Sữa bột cho bé Abbott grow','sua-bot-grow-g-power-vanila-900g-050122-040017-600x600.jpg','536000','Hộp','100'),
('76700','9079','118617',N'Sữa bột Abbott PediaSure BA hương vani 850g (1 - 10 tuổi)',N'Sữa bột cho bé Pediasure','sua-bot-pediasure-850g-100122-084639-600x600.jpg','536000','Hộp','100'),
('76701','9079','118617',N'Sữa bột Abbott PediaSure BA hương vani 1.6 kg (1 - 10 tuổi)',N'Sữa bột cho bé Pediasure','sua-bot-abbott-pediasure-ba-huong-vani-16kg-1-10-tuoi-130322-033512-600x600.jpg','536000','Hộp','100'),
('77436','2427','118637',N'Tã quần Bobby size L 52 miếng (9 - 13 kg)',N'Tã cho bé Bobby','ta-quan-bobby-size-l-52-mieng-9-13-kg-140522-110821-600x600.jpg','379000','Bịch','100'),
('77438','2427','118637',N'Tã quần Bobby size M 60 miếng (6 - 11 kg)',N'Tã cho bé Bobby','ta-quan-bobby-size-m-62-mieng-cho-be-6-11kg-190222-024646-600x600.png','379000','Bịch','100'),
('77442','2427','118637',N'Tã quần Bobby size XXL 42 miếng (15 - 25 kg)',N'Tã cho bé Bobby','ta-quan-bobby-size-xxl-44-mieng-cho-be-15-25kg-600x600.png','379000','Bịch','100'),
('78694','2427','119430',N'Tã quần Huggies Dry size L 68 miếng (9 - 14 kg)',N'Tã cho bé Huggies','ta-quan-huggies-dry-size-l-68-mieng-cho-be-9-14kg-260122-032548-600x600.png','379000','Bịch','100'),
('78699','2427','119448',N'Tã quần Pampers Baby Dry size L 36 miếng (9 - 14 kg)',N'Tã cho bé Pampers','ta-quan-pampers-baby-dry-size-l-36-mieng-cho-be-9-14kg-15-600x600.png','379000','Bịch','100'),
('78703','2427','119448',N'Tã quần Pampers size XL 32 miếng (12 - 17 kg)',N'Tã cho bé Pampers','ta-quan-pampers-size-xl-32-mieng-cho-be-12-17kg-600x600.png','379000','Bịch','100'),
('78793','9079','119677',N'Sữa bột Optimum Gold số 1 400g (0 - 6 tháng)',N'Sữa bột cho bé Optimum','sua-bot-optimun-gold-so-1-400g-0-6-thang-140522-075916-600x600.jpg','180000','Hộp','100'),
('78799','9079','119675',N'Sữa bột Nutifood Grow Plus 900g (trên 1 tuổi)',N'Sữa bột cho bé Nutifood','sua-bot-grow-plus-do-ht-900g-161221-064104-600x600.jpg','355000','Hộp','100'),
('78800','9079','201725',N'Sữa bột Abbott Grow 1 900g (0 - 6 tháng)',N'Sữa bột cho bé Abbott grow','sua-bot-grow-1-900g-100122-081057-600x600.jpg','355000','Hộp','100'),
('81465','2427','119440',N'Tã quần Merries size L 44 miếng (9 - 14 kg)',N'Tã cho bé Merries','ta-quan-merries-size-l-44-mieng-cho-be-9-14kg-600x600.png','379000','Bịch','100'),
('81466','2427','118640',N'Tã quần Moony man bé gái size L 44 miếng (9 - 14 kg)',N'Tã cho bé Moony','ta-quan-moony-man-be-gai-size-l-44-mieng-cho-be-9-14kg-190222-020659-600x600.png','310200','Bịch','100'),
('81467','2427','119440',N'Tã quần Merries size XL 38 miếng (12 - 22 kg)',N'Tã cho bé Merries','ta-quan-merries-size-xl-38-mieng-cho-be-12-22kg-600x600.jpg','379000','Bịch','100'),
('81469','2427','119440',N'Tã quần Merries size M 58 miếng (6 - 11 kg)',N'Tã cho bé Merries','ta-quan-merries-size-m-58-mieng-cho-be-6-11kg-600x600.png','370000','Bịch','100'),
('81478','2427','119440',N'Tã dán Merries size NB 90 miếng (Dưới 5 kg)',N'Tã cho bé Merries','ta-dan-merries-nb-90-mieng-600x600.png','370000','Bịch','100'),
('81488','2427','118640',N'Tã quần Moony man bé gái size XL 38 miếng (12 - 22 kg)',N'Tã cho bé Moony','ta-quan-moony-man-be-gai-size-xl-38-mieng-cho-be-12-17kg-600x600.png','370000','Bịch','100'),
('81495','2427','118640',N'Tã quần Moony man bé trai size XL 38 miếng (12 - 22 kg)',N'Tã cho bé Moony','ta-quan-moony-man-be-trai-size-xl-38-mieng-cho-be-12-17kg-190222-021048-600x600.png','370000','Bịch','100'),
('81496','2427','118640',N'Tã quần Moony man bé trai size L 44 miếng (9 - 14 kg)',N'Tã cho bé Moony','ta-quan-moony-man-l-44-mieng-cho-be-9-14kg-190222-020543-600x600.png','370000','Bịch','100'),
('84055','9079','201725',N'Sữa bột Abbott Grow số 4 hương vani 900g (trên 2 tuổi)',N'Sữa bột cho bé Abbott grow','sb-abbott-grow-4-900g-100122-082349-600x600.jpg','355000','Hộp','100'),
('84057','9079','201725',N'Sữa bột Abbott Grow 3+ hương vani 1.7 kg ( 3 - 6 tuổi)',N'Sữa bột cho bé Abbott grow','sb-grow-g-power-vanila-1700g-avatar-1-300x300.jpg','355000','Hộp','100'),
('85189','2605','119616',N'Bột ăn dặm Nestlé Cerelac cá và rau xanh hộp 200g (từ 8 tháng)',N'Ăn dặm cho bé Nestle Cerelac','bot-an-dam-nestle-cerelac-ca-va-rau-xanh-hop-200g-tu-8-thang-600x600.jpg','58900','Cái','100'),
('85234','9079','119675',N'Sữa bột Nutifood Grow Plus 1.5 kg (trên 1 tuổi)',N'Sữa bột cho bé Nutifood','sua-bot-nutifood-grow-plus-lon-1-5kg-tren-1-tuoi-600x600.jpg','355000','Hộp','100'),
('87382','2605','119616',N'Bột ăn dặm Nestlé Cerelac rau xanh và bí đỏ hộp 200g (từ 6 tháng)',N'Ăn dặm cho bé Nestle Cerelac','bot-an-dam-nestle-cerelac-rau-xanh-va-bi-do-hop-200g-tu-6-thang-240222-030042-600x600.jpg','58900','Cái','100'),
('90194','2605','119044',N'Bột ăn dặm Ridielac Gold yến mạch và sữa hộp 200g (6 - 24 tháng)',N'Ăn dặm cho bé Vinamilk','bot-an-dam-ridielac-yen-mach-sua-hop-200g-6-24-thang-1-600x600.jpg','58900','Cái','100'),
('92043','9079','119677',N'Sữa bột Optimum Gold số 2 400g (6 - 12 tháng)',N'Sữa bột cho bé Optimum','sua-bot-optimum-gold-so-2-400g-6-12-thang-140522-081503-600x600.jpg','355000','Hộp','100'),
('95490','9079','118618',N'Sữa bột Abbott Similac Neosure Eye-Q số 1 850g (0 - 12 tháng)',N'Sữa bột cho bé Similac','sua-bot-abbott-similac-neosure-eye-q-1-lon-850g-0-12-thang-201908051449027832-300x300.jpg','355000','Hộp','100'),
('95497','9079','201725',N'Sữa bột Abbott Grow Gold hương vani 900g (trên 6 tuổi)',N'Sữa bột cho bé Abbott grow','sua-bot-abbott-grow-gold-6-vanilla-lon-900g-avatar-1-300x300.jpg','355000','Hộp','100'),
('96874','9079','201725',N'Sữa bột Abbott Grow số 4 hương vani 1.7 kg (trên 2 tuổi)',N'Sữa bột cho bé Abbott grow','sua-bot-abbott-grow-4-lon-1-7kg-tren-2-tuoi-600x600.jpg','355000','Hộp','100'),
('167237','2605','119616',N'Bánh ăn dặm Nestlé Cerelac gạo sữa hộp 200g (từ 6 tháng)',N'Ăn dặm cho bé Nestle Cerelac','bad-nestle-cerelac-gao-sua-dinh-duong-200g-201221-085315-600x600.jpg','58900','Cái','100'),
('184771','9079','119650',N'Sữa bột Dielac Alpha Gold IQ số 1 900g (0 - 6 tháng)',N'Sữa bột cho bé Dielac','sua-bot-dielac-alpha-gold-iq-so-1-900g-0-6-thang-140522-085547-600x600.jpg','299000','Hộp','100'),
('184773','9079','119650',N'Sữa bột Dielac Alpha Gold IQ số 2 900g (6 - 12 tháng)',N'Sữa bột cho bé Dielac','sua-bot-dielac-alpha-gold-iq-2-ht-900g-140522-091303-600x600.jpg','289000','Hộp','100'),
('184775','9079','119650',N'Sữa bột Dielac Alpha Gold IQ số 3 900g (1 - 2 tuổi)',N'Sữa bột cho bé Dielac','sua-bot-dielac-alpha-gold-iq-3-ht-900g-140522-095722-600x600.jpg','248000','Hộp','100'),
('184776','9079','119650',N'Sữa bột Dielac Alpha Gold IQ số 4 lon 900g',N'Sữa bột cho bé Dielac','sua-bot-dielac-alpha-gold-iq-4-ht-900g-140522-100146-600x600.jpg','248000','Hộp','100'),
('193924','2382','118613',N'Sữa bầu Similac Mom 900g',N'Sữa bầu Similac','sua-bau-abbott-similac-mom-eye-q-plus-vani-900g-600x600.jpg','219000','Hộp','100'),
('196918','9079','118618',N'Sữa bột Similac 5G số 1 400g (0 - 6 tháng)',N'Sữa bột cho bé Similac','sua-bot-abbott-1-lon-400g-0-6-thang-050122-021634-600x600.jpg','248000','Hộp','100'),
('196921','9079','118618',N'Sữa bột Similac 5G số 1 900g (0 - 6 tháng)',N'Sữa bột cho bé Similac','sua-bot-abbott-similac-newborn-iq-hmo-lon-900g-0-6-thang-050122-023035-600x600.jpg','536000','Hộp','100'),
('196925','9079','118618',N'Sữa bột Similac 5G số 2 900g (6 - 12 tháng)',N'Sữa bột cho bé Similac','sua-bot-abbott-similac-eye-q-2-plus-hmo-vani-lon-900g-6-12-thang-050122-024645-600x600.jpg','530000','Hộp','100'),
('196927','9079','118618',N'Sữa bột Similac 5G số 3 900g (1 - 2 tuổi)',N'Sữa bột cho bé Similac','sua-bot-abbott-vani-lon-900g-1-2-tuoi-050122-025242-600x600.jpg','530000','Hộp','100'),
('197213','9079','118618',N'Sữa bột Similac 5G số 4 900g (2 - 6 tuổi)',N'Sữa bột cho bé Similac','sua-bot-abbott-similac-eye-q-4-plus-hmo-vani-lon-900g-2-6-tuoi-050122-025946-600x600.jpg','530000','Hộp','100'),
('197348','2382','118613',N'Sữa bầu Similac Mom 400g',N'Sữa bầu Similac','sua-bau-abbott-similac-mom-eye-q-plus-it-beo-400g-600x600.jpg','219000','Hộp','100'),
('197349','2382','137592',N'Sữa bột Ensure Gold hương vani 850g',N'Sữa bầu Ensure','sua-bot-ensure-gold-vani-850g-050122-041552-600x600.jpg','219000','Hộp','100'),
('197350','2382','137592',N'Sữa bột Ensure Gold hương vani 400g',N'Sữa bầu Ensure','sua-bot-ensure-gold-vani-400g-600x600.jpg','219000','Hộp','100'),
('197352','2382','129885',N'Sữa bầu Frisomum Gold hương cam 900g',N'Sữa bầu Friso','sua-bot-frisomum-gold-cam-lon-900g-201221-110407-600x600.jpg','219000','Hộp','100'),
('205790','2605','119044',N'Bột ăn dặm Ridielac Gold 4 gói vị mặn hộp 200g (7 - 24 tháng)',N'Ăn dặm cho bé Vinamilk','bot-an-dam-ridielac-gold-4-goi-vi-man-7-24-thang-200g-600x600.jpg','58900','Cái','100'),
('205791','2605','119044',N'Bột ăn dặm Ridielac Gold bò rau củ hộp 200g (7 - 24 tháng)',N'Ăn dặm cho bé Vinamilk','bot-an-dam-ridielac-gold-bo-rau-cu-7-24-thang-200g-600x600.jpg','58900','Cái','100'),
('205796','2605','119044',N'Bột ăn dặm Ridielac Gold cá hồi bông cải xanh hộp 200g (7 - 24 tháng)',N'Ăn dặm cho bé Vinamilk','bot-an-dam-ridielac-gold-ca-hoi-bong-cai-xanh-7-24-thang-200g-201221-085450-600x600.jpg','58900','Cái','100'),
('222394','8683','118976',N'Bình sữa nhựa PP Pigeon Plus SoftTouch siêu mềm 330 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-plus-softtouch-330ml-201221-101123-600x600.jpg','136800','Cái','100'),
('222410','8683','118976',N'Bình sữa nhựa PP Pigeon Plus SoftTouch siêu mềm 240 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-plus-softtouch-sieu-mem-240ml-600x600.jpg','136800','Cái','100'),
('222430','8683','118976',N'Bình sữa nhựa PP Pigeon Plus SoftTouch siêu mềm 160 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-plus-softtouch-160ml-221221-014059-600x600.jpg','136800','Cái','100'),
('222432','8683','118976',N'Bình sữa nhựa PP Pigeon Streamline 250 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-streamline-250ml-1-600x600.jpg','136800','Cái','100'),
('222435','8683','118976',N'Bình sữa nhựa PP Pigeon Streamline 150 ml hồng',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-streamline-150ml-600x600.jpg','125100','Cái','100'),
('222438','8683','118976',N'Bình sữa nhựa PP Pigeon vuông 120 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-vuong-120ml-600x600.jpg','125100','Cái','100'),
('222439','8683','118976',N'Bình sữa nhựa PP Pigeon vuông 240 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-vuong-240ml-600x600.jpg','103500','Cái','100'),
('222440','8683','118976',N'Bình uống nước nhựa PP Pigeon tiêu chuẩn 50 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-tieu-chuan-50ml-600x600.jpg','86400','Cái','100'),
('222441','8683','118976',N'Bình sữa nhựa PP Pigeon tiêu chuẩn 120 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-tieu-chuan-120ml-600x600.jpg','86400','Cái','100'),
('222442','8683','118976',N'Bình sữa nhựa PP Pigeon tiêu chuẩn 240 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-tieu-chuan-240ml-giao-mau-ngau-nhien-600x600.jpg','86400','Cái','100'),
('222445','8683','118976',N'Bình sữa nhựa PP Pigeon cao cấp 120 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-cao-cap-120ml-giao-mau-ngau-nhien-danh-cho-be-0-4-thang-600x600.jpg','86400','Cái','100'),
('222446','8683','118976',N'Bình sữa nhựa PP Pigeon cao cấp 240 ml',N'Bình sữa Pigeon','binh-sua-cho-be-pigeon-cao-cap-240ml-600x600.jpg','86400','Cái','100'),
('222450','8683','118976',N'Núm ti Pigeon siêu mềm plus SofTTuch size LL',N'Bình sữa Pigeon','num-vu-pigeon-plus-softtouch-sieu-mem-size-ll-600x600.jpg','154800','Cái','100'),
('222458','8683','118976',N'Bộ 2 núm ti Pigeon Plus SofTouch siêu mềm (size L)',N'Bình sữa Pigeon','num-vu-pigeon-plus-softtouch-sieu-mem-size-l-030122-123132-600x600.png','154800','Cái','100'),
('230513','2382','150766',N'Sữa bầu Meiji Mama 350g',N'Sữa bầu Meiji','sua-bot-meiji-mama-lon-350g-600x600.jpg','219000','Hộp','100'),
('256284','2382','129872',N'20 gói/hộp cốm lợi sữa DK Pharma Curmilk 100g',N'Sữa bầu DK Pharma','com-loi-sua-dk-pharma-curmilk-hop-100g-danh-cho-ba-me-mang-thai-cho-con-bu-202110301441419142.png','219000','Hộp','100'),
('260218','2382','118611',N'Sữa bầu Enfamama A+ hương vani 360° Brain Plus 400g',N'Sữa bầu Enfa','sua-bot-enfamama-a-huong-vanilla-360-brain-plus-400g-600x600.jpg','219000','Hộp','100'),
('260219','2382','118611',N'Sữa bầu Enfamama A+ hương vani 360° Brain Plus 830g',N'Sữa bầu Enfa','sua-bot-enfamama-a-huong-vanilla-360-brain-plus-830g-7-600x600.jpg','219000','Hộp','100'),
('261516','2382','129885',N'Sữa bầu Frisomum hương cam 400g',N'Sữa bầu Friso','sua-bot-frisomum-huong-cam-400g-600x600.jpg','219000','Hộp','100'),
('266221','2382','150217',N'Sữa bầu Wakodo Mom 300g',N'Sữa bầu Wakodo','sua-bau-wakodo-mom-300g-7-600x600.jpg','219000','Hộp','100'),
('266222','2382','150217',N'Sữa bầu Wakodo Mom 830g',N'Sữa bầu Wakodo','sua-bau-wakodo-mom-830g-2-600x600.jpg','219000','Hộp','100')

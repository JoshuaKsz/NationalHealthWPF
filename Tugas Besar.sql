-- Query hasil akhir final
-- 

create database NationalHealth
use NationalHealth


create table provinsi
    (id_provinsi varchar(16) primary key,
    nama_provinsi varchar(50)
    );

create table kota
	(id_kota varchar(16) primary key,
	id_provinsi varchar(16) REFERENCES provinsi(id_provinsi),
	nama_kota varchar(50)
	);

create table kecamatan
	(id_kecamatan varchar(16) primary key,
	id_kota varchar (16) references kota(id_kota),
	nama_kecamatan varchar(50)	
	);


--CREATE table lokasi
--	(id_lokasi varchar(16) primary key,	
	
-- drop table penduduk
create table penduduk
    (id_penduduk varchar(16) primary key,
    nama varchar(50),
    tanggal_lahir datetime,
    jenis_kelamin varchar(10),
    golongan_darah varchar(4),
    alamat varchar(50),
    nomor_hp varchar(15),
    status varchar(15),
	id_kecamatan varchar(16) references kecamatan(id_kecamatan)
    );

--drop table penyakit;
-- drop table rumah_sakit
-- drop table riwayat_penyakit

CREATE table penyakit
	(id_penyakit varchar(40) primary key,
	mikroorganisme varchar(50),
	nama_family varchar(16)
	);

create table rumah_sakit
    (id_rumah_sakit varchar(16) primary key,
    nama_rumah_sakit varchar(50),
	id_kecamatan varchar(16) references kecamatan(id_kecamatan)
    );

create table riwayat_penyakit
    (id_riwayat varchar(16) primary key,
    id_penduduk varchar(16) references penduduk(id_penduduk),
	id_rumah_sakit varchar (16) references rumah_sakit(id_rumah_sakit),
	id_penyakit varchar(40) references penyakit(id_penyakit),
	awal_sakit datetime,
	akhir_sakit datetime);





-- Ins, Del, Upd
CREATE PROCEDURE SPInsPenyakit
	@id_penyakit varchar(40), 
	@mikroorganisme varchar(50),
	@nama_family varchar(16) = NULL
AS
BEGIN
	INSERT INTO penyakit (id_penyakit, mikroorganisme, nama_family)
	VALUES (@id_penyakit, @mikroorganisme, @nama_family);
END
GO
CREATE PROCEDURE SPDelPenyakit	
	@id_penyakit varchar(40)
AS
BEGIN

	DELETE FROM penyakit
	WHERE id_penyakit = @id_penyakit;
END
GO	
CREATE PROCEDURE SPUpdPenyakit	
	@id_penyakit varchar(40),
	@mikroorganisme varchar(50),
	@nama_family varchar(16) = NULL
AS
BEGIN
	UPDATE penyakit
	set mikroorganisme = @mikroorganisme,
	nama_family = @nama_family
	WHERE id_penyakit = @id_penyakit;
END
GO


-- kecamatan
CREATE PROCEDURE SPInsKecamatan
	@id_kecamatan varchar(16),
	@id_kota varchar (16),
	@nama_kecamatan varchar(50)
AS
BEGIN
	INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan)
	VALUES (@id_kecamatan, @id_kota, @nama_kecamatan);
END
GO

CREATE PROCEDURE SPDelKecamatan	
	@id_kecamatan varchar(16)
AS
BEGIN

	DELETE FROM kecamatan
	WHERE id_kecamatan = @id_kecamatan;
END
GO

CREATE PROCEDURE SPUpdKecamatan
	@id_kecamatan varchar(16),
	@id_kota varchar (16),
	@nama_kecamatan varchar(50)
AS
BEGIN
	UPDATE kecamatan
	set id_kota = @id_kota,
	nama_kecamatan = @nama_kecamatan
	WHERE id_kecamatan = @id_kecamatan;

END
GO

-- kota
CREATE PROCEDURE SPInsKota
	@id_kota varchar(16),
	@id_provinsi varchar(16),
	@nama_kota varchar(50)
AS
BEGIN
	INSERT INTO kota (id_kota, id_provinsi, nama_kota)
	VALUES (@id_kota, @id_provinsi, @nama_kota);
END
GO

CREATE PROCEDURE SPDelKota
	@id_kota varchar(16)
AS
BEGIN

	DELETE FROM kota
	WHERE id_kota = @id_kota;
END
GO

CREATE PROCEDURE SPUpdKota
	@id_kota varchar(16),
	@id_provinsi varchar(16),
	@nama_kota varchar(50)
AS
BEGIN
	UPDATE kota
	set id_provinsi = @id_provinsi,
	nama_kota = @nama_kota
	WHERE id_kota = @id_kota;

END
GO

-- provinsi
CREATE PROCEDURE SPInsProvinsi
	@id_provinsi varchar(16),
    @nama_provinsi varchar(50)
AS
BEGIN
	INSERT INTO provinsi (id_provinsi, nama_provinsi)
	VALUES (@id_provinsi, @nama_provinsi);
END
GO

CREATE PROCEDURE SPDelProvinsi
	@id_provinsi varchar(16)
AS
BEGIN

	DELETE FROM provinsi
	WHERE id_provinsi = @id_provinsi;
END
GO

CREATE PROCEDURE SPUpdProvinsi
	@id_provinsi varchar(16),
    @nama_provinsi varchar(50)
AS
BEGIN
	UPDATE provinsi
	set nama_provinsi = @nama_provinsi
	WHERE id_provinsi = @id_provinsi;
END
GO

-- Lokasi (semuanya sekaligus)

CREATE PROCEDURE SPInsLokasi
	@id_kecamatan varchar(16),
	@nama_kecamatan varchar(50),
	@id_kota varchar (16),
	@nama_kota varchar(50),
	@id_provinsi varchar(16),
    @nama_provinsi varchar(50)
AS
BEGIN
	INSERT INTO provinsi(id_provinsi, nama_provinsi)
	VALUES (@id_provinsi, @nama_provinsi);
	INSERT INTO kota (id_kota, id_provinsi, nama_kota)
	VALUES (@id_kota, @id_provinsi, @nama_kota);
	INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan)
	VALUES (@id_kecamatan, @id_kota, @nama_kecamatan);
END
GO

CREATE PROCEDURE SPDelLokasi
	@id_kecamatan varchar(16),
	@id_kota varchar (16),
	@id_provinsi varchar(16)
AS
BEGIN
	DELETE FROM kecamatan
	WHERE id_kecamatan = @id_kecamatan;
	DELETE FROM kota
	WHERE id_kota = @id_kota;
	DELETE FROM provinsi
	WHERE id_provinsi = @id_provinsi;
END
GO

CREATE PROCEDURE SPUpdLokasi
	@id_kecamatan varchar(16),
	@nama_kecamatan varchar(50),
	@id_kota varchar (16),
	@nama_kota varchar(50),
	@id_provinsi varchar(16),
    @nama_provinsi varchar(50)
AS
BEGIN
	UPDATE kecamatan
	set id_kota = @id_kota,
	nama_kecamatan = @nama_kecamatan
	WHERE id_kecamatan = @id_kecamatan;
	UPDATE kota
	set id_provinsi = @id_provinsi,
	nama_kota = @nama_kota
	WHERE id_kota = @id_kota;
	UPDATE provinsi
	set nama_provinsi = @nama_provinsi
	WHERE id_provinsi = @id_provinsi;
END
GO

-- view lokasi
CREATE VIEW VWLokasi
AS
SELECT        dbo.kecamatan.id_kecamatan, dbo.kecamatan.nama_kecamatan, dbo.kota.id_kota, dbo.kota.nama_kota, dbo.provinsi.id_provinsi, dbo.provinsi.nama_provinsi
FROM            dbo.kecamatan INNER JOIN
                         dbo.kota ON dbo.kecamatan.id_kota = dbo.kota.id_kota INNER JOIN
                         dbo.provinsi ON dbo.kota.id_provinsi = dbo.provinsi.id_provinsi
-- Penduduk
CREATE PROCEDURE SPInsPenduduk
	@id_penduduk varchar(16),
    @nama varchar(50),
    @tanggal_lahir datetime,
    @jenis_kelamin varchar(10),
    @golongan_darah varchar(4),
    @alamat varchar(50),
    @nomor_hp varchar(15),
    @status varchar(15),
	@id_kecamatan varchar(16)
AS
BEGIN
	INSERT INTO penduduk(id_penduduk,
    nama,
    tanggal_lahir,
    jenis_kelamin,
    golongan_darah,
    alamat,
    nomor_hp,
    status,
	id_kecamatan)
	values (@id_penduduk ,
    @nama,
    @tanggal_lahir,
    @jenis_kelamin,
    @golongan_darah,
    @alamat,
    @nomor_hp,
    @status,
	@id_kecamatan)
END
GO

CREATE PROCEDURE SPDelPenduduk
	@id_penduduk varchar(16)
AS
BEGIN
	DELETE FROM penduduk
	WHERE id_penduduk = @id_penduduk;
END
GO

CREATE PROCEDURE SPUpdPenduduk
	@id_penduduk varchar(16),
    @nama varchar(50),
    @tanggal_lahir datetime,
    @jenis_kelamin varchar(10),
    @golongan_darah varchar(4),
    @alamat varchar(50),
    @nomor_hp varchar(15),
    @status varchar(15),
	@id_kecamatan varchar(16)
AS
BEGIN
	UPDATE penduduk
	set nama = @nama,
	tanggal_lahir = @tanggal_lahir,
	jenis_kelamin = @jenis_kelamin,
    golongan_darah = @golongan_darah,
    alamat = @alamat,
    nomor_hp = @nomor_hp,
    status = @status,
	id_kecamatan = @id_kecamatan
	WHERE id_penduduk = @id_penduduk;
END
GO



-- rumah sakit

CREATE PROCEDURE SPInsRumah
	@id_rumah_sakit varchar(16),
    @nama_rumah_sakit varchar(50),
	@id_kecamatan varchar(16)
AS
BEGIN
	INSERT INTO rumah_sakit(id_rumah_sakit,
    nama_rumah_sakit,
	id_kecamatan)
	values (@id_rumah_sakit,
    @nama_rumah_sakit,
	@id_kecamatan)
END
GO

CREATE PROCEDURE SPDelRumah
	@id_rumah_sakit varchar(16)
AS
BEGIN
	DELETE FROM rumah_sakit
	WHERE id_rumah_sakit = @id_rumah_sakit;
END
GO

CREATE PROCEDURE SPUpdRumah
	@id_rumah_sakit varchar(16),
    @nama_rumah_sakit varchar(50),
	@id_kecamatan varchar(16)
AS
BEGIN
	UPDATE rumah_sakit
	set nama_rumah_sakit = @nama_rumah_sakit,
	id_kecamatan = @id_kecamatan
	WHERE id_rumah_sakit = @id_rumah_sakit;
END
GO

SELECT * FROM rumah_sakit;

-- Riwayat
create PROCEDURE SPInsRiwayat
	@id_riwayat varchar(16),
    @id_penduduk varchar(16),
	@id_rumah_sakit varchar (16),
	@id_penyakit varchar(50),
	@awal_sakit datetime,
	@akhir_sakit datetime = NULL
AS
BEGIN
	INSERT INTO riwayat_penyakit(
	id_riwayat,
    id_penduduk,
	id_rumah_sakit,
	id_penyakit,
	awal_sakit,
	akhir_sakit)
	VALUES (@id_riwayat,
    @id_penduduk,
	@id_rumah_sakit,
	@id_penyakit,
	@awal_sakit,
	@akhir_sakit)
END
GO

CREATE PROCEDURE SPDelRiwayat
	@id_riwayat varchar(16)
AS
BEGIN
	DELETE FROM riwayat_penyakit
	WHERE id_riwayat = @id_riwayat;
END
GO

CREATE PROCEDURE SPUpdRiwayat
	@id_riwayat varchar(16),
    @id_penduduk varchar(16),
	@id_rumah_sakit varchar (16),
	@id_penyakit varchar(50),
	@awal_sakit datetime,
	@akhir_sakit datetime = NULL
AS
BEGIN
	UPDATE riwayat_penyakit
	set id_penduduk = @id_penduduk,
	id_rumah_sakit = @id_rumah_sakit,
	id_penyakit = @id_penyakit,
	awal_sakit = @awal_sakit,
	akhir_sakit = @akhir_sakit
	WHERE id_riwayat = @id_riwayat;
END
GO

CREATE VIEW VWJumlahSakit
AS
SELECT        dbo.provinsi.id_provinsi, dbo.provinsi.nama_provinsi, COUNT(dbo.penduduk.id_penduduk) AS Jumlah
FROM            dbo.kota INNER JOIN
                         dbo.provinsi ON dbo.kota.id_provinsi = dbo.provinsi.id_provinsi INNER JOIN
                         dbo.kecamatan ON dbo.kota.id_kota = dbo.kecamatan.id_kota INNER JOIN
                         dbo.penduduk ON dbo.kecamatan.id_kecamatan = dbo.penduduk.id_kecamatan INNER JOIN
                         dbo.riwayat_penyakit ON dbo.penduduk.id_penduduk = dbo.riwayat_penyakit.id_penduduk
GROUP BY dbo.provinsi.id_provinsi, dbo.provinsi.nama_provinsi

CREATE FUNCTION dbo.GetProvinsiByPenyakit2D
(
    @id_penyakit VARCHAR(50),
    @awal_mulai DATE,
	@akhir_selesai DATE
)
RETURNS @ResultTable TABLE
(
    id_provinsi VARCHAR(4),
    Jumlah INT
)
AS
BEGIN
	INSERT INTO @ResultTable
    SELECT
        RIGHT(p.id_provinsi, 2), 
        COUNT(pd.id_penduduk) AS Jumlah
    FROM 
        dbo.kota k
        INNER JOIN dbo.provinsi p ON k.id_provinsi = p.id_provinsi
        INNER JOIN dbo.kecamatan kc ON k.id_kota = kc.id_kota
        INNER JOIN dbo.penduduk pd ON kc.id_kecamatan = pd.id_kecamatan
        INNER JOIN dbo.riwayat_penyakit rp ON pd.id_penduduk = rp.id_penduduk
    WHERE 
        rp.id_penyakit = @id_penyakit
        AND rp.awal_sakit >= @awal_mulai
        AND (rp.akhir_sakit <= @akhir_selesai OR rp.akhir_sakit IS NULL)
    GROUP BY 
        p.id_provinsi
	RETURN;
END;


	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-AC', 'Aceh');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-BA', 'Bali');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-BT', 'Banten');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-BE', 'Bengkulu');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-GO', 'Gorontalo');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-JK', 'Jakarta');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-JA', 'Jambi');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-JB', 'Jawa Barat');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-JT', 'Jawa Tengah');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-JI', 'Jawa Timur');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-KB', 'Kalimantan Barat');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-KS', 'Kalimantan Selatan');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-KT', 'Kalimantan Tengah');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-KI', 'Kalimantan Timur');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-KU', 'Kalimantan Utara');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-BB', 'Kepulauan Bangka Belitung');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-KR', 'Kepulauan Riau');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-LA', 'Lampung');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-MA', 'Maluku');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-MU', 'Maluku Utara');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-NB', 'Nusa Tenggara Barat');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-NT', 'Nusa Tenggara Timur');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-PA', 'Papua');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-PB', 'Papua Barat');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-RI', 'Riau');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-SR', 'Sulawesi Barat');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-SN', 'Sulawesi Selatan');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-ST', 'Sulawesi Tengah');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-SG', 'Sulawesi Tenggara');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-SA', 'Sulawesi Utara');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-SB', 'Sumatera Barat');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-SS', 'Sumatera Selatan');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-SU', 'Sumatera Utara');
	INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES ('ID-YO', 'Yogyakarta');


	INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-AC-01', 'ID-AC', 'Banda Aceh');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-AC-02', 'ID-AC', 'Langsa');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-AC-03', 'ID-AC', 'Lhokseumawe');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-AC-04', 'ID-AC', 'Sabang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-AC-05', 'ID-AC', 'Subulussalam');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-BA-01', 'ID-BA', 'Denpasar');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-BT-01', 'ID-BT', 'Cilegon');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-BT-02', 'ID-BT', 'Serang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-BT-03', 'ID-BT', 'Tangerang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-BT-04', 'ID-BT', 'Tangerang Selatan');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JK-01', 'ID-JK', 'Jakarta Barat');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JK-02', 'ID-JK', 'Jakarta Pusat');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JK-03', 'ID-JK', 'Jakarta Selatan');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JK-04', 'ID-JK', 'Jakarta Timur');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JK-05', 'ID-JK', 'Jakarta Utara');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-YO-01', 'ID-YO', 'Yogyakarta');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-PA-01', 'ID-PA', 'Jayapura');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-01', 'ID-SU', 'Medan');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-02', 'ID-SU', 'Binjai');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-03', 'ID-SU', 'Tebing Tinggi');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-04', 'ID-SU', 'Pematangsiantar');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-05', 'ID-SU', 'Tanjungbalai');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-06', 'ID-SU', 'Sibolga');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-07', 'ID-SU', 'Padang Sidempuan');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SU-08', 'ID-SU', 'Gunungsitoli');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-01', 'ID-JB', 'Bandung');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-02', 'ID-JB', 'Bekasi');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-03', 'ID-JB', 'Bogor');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-04', 'ID-JB', 'Cimahi');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-05', 'ID-JB', 'Cirebon');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-06', 'ID-JB', 'Depok');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-07', 'ID-JB', 'Sukabumi');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JB-08', 'ID-JB', 'Tasikmalaya');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JT-01', 'ID-JT', 'Semarang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JT-02', 'ID-JT', 'Surakarta');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JT-03', 'ID-JT', 'Salatiga');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JT-04', 'ID-JT', 'Pekalongan');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JT-05', 'ID-JT', 'Tegal');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JT-06', 'ID-JT', 'Magelang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-01', 'ID-JI', 'Surabaya');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-02', 'ID-JI', 'Malang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-03', 'ID-JI', 'Madiun');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-04', 'ID-JI', 'Blitar');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-05', 'ID-JI', 'Kediri');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-06', 'ID-JI', 'Probolinggo');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-07', 'ID-JI', 'Pasuruan');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-08', 'ID-JI', 'Mojokerto');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-JI-09', 'ID-JI', 'Batu');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KB-01', 'ID-KB', 'Pontianak');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KB-02', 'ID-KB', 'Singkawang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KS-01', 'ID-KS', 'Banjarmasin');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KS-02', 'ID-KS', 'Banjarbaru');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KT-01', 'ID-KT', 'Palangka Raya');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KI-01', 'ID-KI', 'Balikpapan');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KI-02', 'ID-KI', 'Samarinda');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KI-03', 'ID-KI', 'Bontang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KU-01', 'ID-KU', 'Tanjung Selor');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-KU-02', 'ID-KU', 'Tarakan');
-- Sulawesi Barat
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SR-01', 'ID-SR', 'Mamuju');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SR-02', 'ID-SR', 'Majene');

-- Sulawesi Selatan
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SN-01', 'ID-SN', 'Makassar');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SN-02', 'ID-SN', 'Palopo');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SN-03', 'ID-SN', 'Parepare');

-- Sulawesi Tengah
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-ST-01', 'ID-ST', 'Palu');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-ST-02', 'ID-ST', 'Poso');

-- Sulawesi Tenggara
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SG-01', 'ID-SG', 'Kendari');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SG-02', 'ID-SG', 'Baubau');

-- Sulawesi Utara
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SA-01', 'ID-SA', 'Manado');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SA-02', 'ID-SA', 'Bitung');
-- Sumatera Barat
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SB-01', 'ID-SB', 'Padang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SB-02', 'ID-SB', 'Bukittinggi');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SB-03', 'ID-SB', 'Padang Panjang');

-- Sumatera Selatan
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SS-01', 'ID-SS', 'Palembang');
INSERT INTO kota (id_kota, id_provinsi, nama_kota) VALUES ('ID-SS-02', 'ID-SS', 'Prabumulih');



-- Banda Aceh
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-001', 'ID-AC-01', 'Baiturrahman');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-002', 'ID-AC-01', 'Kutaraja');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-003', 'ID-AC-01', 'Syiah Kuala');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-004', 'ID-AC-01', 'Ulee Lheue');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-005', 'ID-AC-01', 'Meuraxa');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-006', 'ID-AC-01', 'Lueng Bata');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-007', 'ID-AC-01', 'Kuta Alam');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-01-008', 'ID-AC-01', 'Banda Raya');

-- Lhokseumawe
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-02-001', 'ID-AC-02', 'Muara Dua');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-02-002', 'ID-AC-02', 'Banda Sakti');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-02-003', 'ID-AC-02', 'Lhokseumawe');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-02-004', 'ID-AC-02', 'Blang Mangat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-02-005', 'ID-AC-02', 'Muara Satu');

-- Sabang
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-03-001', 'ID-AC-03', 'Sukakarya');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-03-002', 'ID-AC-03', 'Sukajaya');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-03-003', 'ID-AC-03', 'Suka Makmur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-AC-03-004', 'ID-AC-03', 'Sukajadi');

-- Denpasar
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-01-001', 'ID-BA-01', 'Denpasar Selatan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-01-002', 'ID-BA-01', 'Denpasar Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-01-003', 'ID-BA-01', 'Denpasar Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-01-004', 'ID-BA-01', 'Denpasar Utara');

-- Badung
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-02-001', 'ID-BA-02', 'Kuta');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-02-002', 'ID-BA-02', 'Mengwi');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-02-003', 'ID-BA-02', 'Abiansemal');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-BA-02-004', 'ID-BA-02', 'Petang');

-- Jakarta Barat
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-01-001', 'ID-JK-01', 'Tambora');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-01-002', 'ID-JK-01', 'Kalideres');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-01-003', 'ID-JK-01', 'Kebon Jeruk');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-01-004', 'ID-JK-01', 'Cengkareng');

-- Jakarta Selatan
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-02-001', 'ID-JK-02', 'Kebayoran Lama');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-02-002', 'ID-JK-02', 'Kebayoran Baru');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-02-003', 'ID-JK-02', 'Pesanggrahan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-JK-02-004', 'ID-JK-02', 'Cilandak');

-- Banjarmasin
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-01-001', 'ID-KS-01', 'Banjarmasin Selatan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-01-002', 'ID-KS-01', 'Banjarmasin Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-01-003', 'ID-KS-01', 'Banjarmasin Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-01-004', 'ID-KS-01', 'Banjarmasin Utara');

-- Tanah Laut
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-02-001', 'ID-KS-02', 'Pelaihari');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-02-002', 'ID-KS-02', 'Juai');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-02-003', 'ID-KS-02', 'Kandangan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KS-02-004', 'ID-KS-02', 'Batu Licin');

-- Balikpapan
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-01-001', 'ID-KI-01', 'Balikpapan Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-01-002', 'ID-KI-01', 'Balikpapan Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-01-003', 'ID-KI-01', 'Balikpapan Selatan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-01-004', 'ID-KI-01', 'Balikpapan Utara');

-- Palangka Raya
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-001', 'ID-KT-01', 'Jekan Raya');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-002', 'ID-KT-01', 'Bukit Batu');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-003', 'ID-KT-01', 'Rakumpit');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-004', 'ID-KT-01', 'Pahandut');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-005', 'ID-KT-01', 'Mentawa Baru Ketapang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-006', 'ID-KT-01', 'Pahandut Seberang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-007', 'ID-KT-01', 'Jekan Raya');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KT-01-008', 'ID-KT-01', 'Bukit Batu');

-- Tarakan
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-001', 'ID-KU-01', 'Tarakan Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-002', 'ID-KU-01', 'Tarakan Tengah');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-003', 'ID-KU-01', 'Tarakan Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-004', 'ID-KU-01', 'Tarakan Utara');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-005', 'ID-KU-01', 'Tarakan Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-006', 'ID-KU-01', 'Tarakan Tengah');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-007', 'ID-KU-01', 'Tarakan Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KU-01-008', 'ID-KU-01', 'Tarakan Utara');
-- Mataram
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-001', 'ID-NB-01', 'Ampenan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-002', 'ID-NB-01', 'Mataram');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-003', 'ID-NB-01', 'Cakranegara');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-004', 'ID-NB-01', 'Sekarbela');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-005', 'ID-NB-01', 'Selaparang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-006', 'ID-NB-01', 'Ampenan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-007', 'ID-NB-01', 'Mataram');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NB-01-008', 'ID-NB-01', 'Cakranegara');

-- Kupang
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-001', 'ID-NT-01', 'Alak');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-002', 'ID-NT-01', 'Kelapa Lima');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-003', 'ID-NT-01', 'Oebobo');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-004', 'ID-NT-01', 'Kupang Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-005', 'ID-NT-01', 'Kupang Tengah');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-006', 'ID-NT-01', 'Kupang Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-007', 'ID-NT-01', 'Kupang Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-NT-01-008', 'ID-NT-01', 'Kupang Tengah');
-- Jayapura
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-PA-01-001', 'ID-PA-01', 'Jayapura Utara');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-PA-01-002', 'ID-PA-01', 'Jayapura Selatan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-PA-01-003', 'ID-PA-01', 'Abepura');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-PA-01-004', 'ID-PA-01', 'Muara Tami');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-PA-01-005', 'ID-PA-01', 'Sentani');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-PA-01-006', 'ID-PA-01', 'Doyo Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-PA-01-007', 'ID-PA-01', 'Doyo Timur');

-- Samarinda
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-003', 'ID-KI-02', 'Samarinda Seberang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-004', 'ID-KI-02', 'Samarinda Ulu');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-005', 'ID-KI-02', 'Samarinda Ilir');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-006', 'ID-KI-02', 'Samarinda Kota');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-007', 'ID-KI-02', 'Samarinda Seberang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-008', 'ID-KI-02', 'Samarinda Ulu');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-009', 'ID-KI-02', 'Samarinda Ilir');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-KI-02-010', 'ID-KI-02', 'Samarinda Kota');


-- Palu
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-001', 'ID-ST-01', 'Palu Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-002', 'ID-ST-01', 'Palu Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-003', 'ID-ST-01', 'Palu Selatan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-004', 'ID-ST-01', 'Palu Utara');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-005', 'ID-ST-01', 'Palu Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-006', 'ID-ST-01', 'Palu Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-007', 'ID-ST-01', 'Palu Selatan');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-ST-01-008', 'ID-ST-01', 'Palu Utara');


-- Makassar
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-001', 'ID-SN-01', 'Ujung Pandang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-002', 'ID-SN-01', 'Mamajang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-003', 'ID-SN-01', 'Makassar');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-004', 'ID-SN-01', 'Bontoala');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-005', 'ID-SN-01', 'Ujung Pandang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-006', 'ID-SN-01', 'Mamajang');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-007', 'ID-SN-01', 'Makassar');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SN-01-008', 'ID-SN-01', 'Bontoala');


-- Palembang
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-001', 'ID-SS-01', 'Ilir Barat I');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-002', 'ID-SS-01', 'Ilir Timur I');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-003', 'ID-SS-01', 'Bukit Kecil');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-004', 'ID-SS-01', 'Kemuning');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-005', 'ID-SS-01', 'Ilir Barat II');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-006', 'ID-SS-01', 'Ilir Timur II');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-007', 'ID-SS-01', 'Sako');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SS-01-008', 'ID-SS-01', 'Kalidoni');


-- Medan
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-001', 'ID-SU-01', 'Medan Barat');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-002', 'ID-SU-01', 'Medan Timur');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-003', 'ID-SU-01', 'Medan Tenggara');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-004', 'ID-SU-01', 'Medan Johor');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-005', 'ID-SU-01', 'Medan Amplas');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-006', 'ID-SU-01', 'Medan Denai');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-007', 'ID-SU-01', 'Medan Area');
INSERT INTO kecamatan (id_kecamatan, id_kota, nama_kecamatan) VALUES ('ID-SU-01-008', 'ID-SU-01', 'Medan Marelan');


INSERT INTO penyakit (id_penyakit, mikroorganisme, nama_family)
 VALUES ('COVID-19', 'SARS-CoV-2', 'coronavirus'),
 ('SARS', 'SARS-CoV', 'coronavirus'),
 ('MERS', 'MERS-CoV', 'coronavirus'),
 ('AIDS', 'HIV', 'retrovirus'),
 ('TB', 'Mycobacterium tuberculosis', 'Mycobacteriaceae'),
 ('Influenza', 'Influenza virus', 'Orthomyxoviridae'),
 ('Ebola', 'Ebola virus', 'Filoviridae'),
 ('Zika', 'Zika virus', 'Flaviviridae'),
 ('Malaria', 'Plasmodium falciparum', 'Plasmodiidae'),
 ('Lyme disease', 'Borrelia burgdorferi', 'Spirochaetaceae'),
 ('Cholera', 'Vibrio cholerae', 'Vibrionaceae'),
 ('Hepatitis B', 'Hepatitis B virus', 'Hepadnaviridae'),
 ('Rabies', 'Rabies virus', 'Rhabdoviridae'),
 ('Chickenpox', 'Varicella-zoster virus', 'Herpesviridae'),
 ('Measles', 'Measles virus', 'Paramyxoviridae');

CREATE TABLE log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    table_name VARCHAR(50),
    operation VARCHAR(10),
    old_data NVARCHAR(MAX),
    new_data NVARCHAR(MAX),
    operation_time DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER after_insert_provinsi
ON provinsi
AFTER INSERT
AS
BEGIN
    INSERT INTO log (table_name, operation, new_data)
    SELECT 'provinsi', 'INSERT', CONCAT('{"id_provinsi": "', INSERTED.id_provinsi, '", "nama_provinsi": "', INSERTED.nama_provinsi, '"}')
    FROM INSERTED;
END;
CREATE TRIGGER after_update_provinsi
ON provinsi
AFTER UPDATE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data, new_data)
    SELECT 'provinsi', 'UPDATE',
           CONCAT('{"id_provinsi": "', DELETED.id_provinsi, '", "nama_provinsi": "', DELETED.nama_provinsi, '"}'),
           CONCAT('{"id_provinsi": "', INSERTED.id_provinsi, '", "nama_provinsi": "', INSERTED.nama_provinsi, '"}')
    FROM DELETED
    JOIN INSERTED ON DELETED.id_provinsi = INSERTED.id_provinsi;
END;
CREATE TRIGGER after_delete_provinsi
ON provinsi
AFTER DELETE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data)
    SELECT 'provinsi', 'DELETE',
           CONCAT('{"id_provinsi": "', DELETED.id_provinsi, '", "nama_provinsi": "', DELETED.nama_provinsi, '"}')
    FROM DELETED;
END;
CREATE TRIGGER after_insert_kota
ON kota
AFTER INSERT
AS
BEGIN
    INSERT INTO log (table_name, operation, new_data)
    SELECT 'kota', 'INSERT', CONCAT('{"id_kota": "', INSERTED.id_kota, '", "id_provinsi": "', INSERTED.id_provinsi, '", "nama_kota": "', INSERTED.nama_kota, '"}')
    FROM INSERTED;
END;
CREATE TRIGGER after_update_kota
ON kota
AFTER UPDATE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data, new_data)
    SELECT 'kota', 'UPDATE',
           CONCAT('{"id_kota": "', DELETED.id_kota, '", "id_provinsi": "', DELETED.id_provinsi, '", "nama_kota": "', DELETED.nama_kota, '"}'),
           CONCAT('{"id_kota": "', INSERTED.id_kota, '", "id_provinsi": "', INSERTED.id_provinsi, '", "nama_kota": "', INSERTED.nama_kota, '"}')
    FROM DELETED
    JOIN INSERTED ON DELETED.id_kota = INSERTED.id_kota;
END;
CREATE TRIGGER after_delete_kota
ON kota
AFTER DELETE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data)
    SELECT 'kota', 'DELETE',
           CONCAT('{"id_kota": "', DELETED.id_kota, '", "id_provinsi": "', DELETED.id_provinsi, '", "nama_kota": "', DELETED.nama_kota, '"}')
    FROM DELETED;
END;
CREATE TRIGGER after_insert_kecamatan
ON kecamatan
AFTER INSERT
AS
BEGIN
    INSERT INTO log (table_name, operation, new_data)
    SELECT 'kecamatan', 'INSERT', CONCAT('{"id_kecamatan": "', INSERTED.id_kecamatan, '", "id_kota": "', INSERTED.id_kota, '", "nama_kecamatan": "', INSERTED.nama_kecamatan, '"}')
    FROM INSERTED;
END;
CREATE TRIGGER after_update_kecamatan
ON kecamatan
AFTER UPDATE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data, new_data)
    SELECT 'kecamatan', 'UPDATE',
           CONCAT('{"id_kecamatan": "', DELETED.id_kecamatan, '", "id_kota": "', DELETED.id_kota, '", "nama_kecamatan": "', DELETED.nama_kecamatan, '"}'),
           CONCAT('{"id_kecamatan": "', INSERTED.id_kecamatan, '", "id_kota": "', INSERTED.id_kota, '", "nama_kecamatan": "', INSERTED.nama_kecamatan, '"}')
    FROM DELETED
    JOIN INSERTED ON DELETED.id_kecamatan = INSERTED.id_kecamatan;
CREATE TRIGGER after_delete_kecamatan
ON kecamatan
AFTER DELETE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data)
    SELECT 'kecamatan', 'DELETE',
           CONCAT('{"id_kecamatan": "', DELETED.id_kecamatan, '", "id_kota": "', DELETED.id_kota, '", "nama_kecamatan": "', DELETED.nama_kecamatan, '"}')
    FROM DELETED;
END;
CREATE TRIGGER after_insert_penduduk
ON penduduk
AFTER INSERT
AS
BEGIN
    INSERT INTO log (table_name, operation, new_data)
    SELECT 'penduduk', 'INSERT', CONCAT('{"id_penduduk": "', INSERTED.id_penduduk, '", "nama": "', INSERTED.nama, '", "tanggal_lahir": "', CONVERT(VARCHAR, INSERTED.tanggal_lahir, 120), '", "jenis_kelamin": "', INSERTED.jenis_kelamin, '", "golongan_darah": "', INSERTED.golongan_darah, '", "alamat": "', INSERTED.alamat, '", "nomor_hp": "', INSERTED.nomor_hp, '", "status": "', INSERTED.status, '", "id_kecamatan": "', INSERTED.id_kecamatan, '"}')
    FROM INSERTED;
END;
CREATE TRIGGER after_update_penduduk
ON penduduk
AFTER UPDATE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data, new_data)
    SELECT 'penduduk', 'UPDATE',
           CONCAT('{"id_penduduk": "', DELETED.id_penduduk, '", "nama": "', DELETED.nama, '", "tanggal_lahir": "', CONVERT(VARCHAR, DELETED.tanggal_lahir, 120), '", "jenis_kelamin": "', DELETED.jenis_kelamin, '", "golongan_darah": "', DELETED.golongan_darah, '", "alamat": "', DELETED.alamat, '", "nomor_hp": "', DELETED.nomor_hp, '", "status": "', DELETED.status, '", "id_kecamatan": "', DELETED.id_kecamatan, '"}'),
           CONCAT('{"id_penduduk": "', INSERTED.id_penduduk, '", "nama": "', INSERTED.nama, '", "tanggal_lahir": "', CONVERT(VARCHAR, INSERTED.tanggal_lahir, 120), '", "jenis_kelamin": "', INSERTED.jenis_kelamin, '", "golongan_darah": "', INSERTED.golongan_darah, '", "alamat": "', INSERTED.alamat, '", "nomor_hp": "', INSERTED.nomor_hp, '", "status": "', INSERTED.status, '", "id_kecamatan": "', INSERTED.id_kecamatan, '"}')
    FROM DELETED
    JOIN INSERTED ON DELETED.id_penduduk = INSERTED.id_penduduk;
END;
CREATE TRIGGER after_delete_penduduk
ON penduduk
AFTER DELETE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data)
    SELECT 'penduduk', 'DELETE',
           CONCAT('{"id_penduduk": "', DELETED.id_penduduk, '", "nama": "', DELETED.nama, '", "tanggal_lahir": "', CONVERT(VARCHAR, DELETED.tanggal_lahir, 120), '", "jenis_kelamin": "', DELETED.jenis_kelamin, '", "golongan_darah": "', DELETED.golongan_darah, '", "alamat": "', DELETED.alamat, '", "nomor_hp": "', DELETED.nomor_hp, '", "status": "', DELETED.status, '", "id_kecamatan": "', DELETED.id_kecamatan, '"}')
    FROM DELETED;
END;
CREATE TRIGGER after_insert_penyakit
ON penyakit
AFTER INSERT
AS
BEGIN
    INSERT INTO log (table_name, operation, new_data)
    SELECT 'penyakit', 'INSERT', CONCAT('{"id_penyakit": "', INSERTED.id_penyakit, '", "mikroorganisme": "', INSERTED.mikroorganisme, '", "nama_family": "', INSERTED.nama_family, '"}')
    FROM INSERTED;
END;
CREATE TRIGGER after_update_penyakit
ON penyakit
AFTER UPDATE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data, new_data)
    SELECT 'penyakit', 'UPDATE',
           CONCAT('{"id_penyakit": "', DELETED.id_penyakit, '", "mikroorganisme": "', DELETED.mikroorganisme, '", "nama_family": "', DELETED.nama_family, '"}'),
           CONCAT('{"id_penyakit": "', INSERTED.id_penyakit, '", "mikroorganisme": "', INSERTED.mikroorganisme, '", "nama_family": "', INSERTED.nama_family, '"}')
    FROM DELETED
    JOIN INSERTED ON DELETED.id_penyakit = INSERTED.id_penyakit;
END;
CREATE TRIGGER after_delete_penyakit
ON penyakit
AFTER DELETE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data)
    SELECT 'penyakit', 'DELETE',
           CONCAT('{"id_penyakit": "', DELETED.id_penyakit, '", "mikroorganisme": "', DELETED.mikroorganisme, '", "nama_family": "', DELETED.nama_family, '"}')
    FROM DELETED;
END;
CREATE TRIGGER after_insert_rumah_sakit
ON rumah_sakit
AFTER INSERT
AS
BEGIN
    INSERT INTO log (table_name, operation, new_data)
    SELECT 'rumah_sakit', 'INSERT', CONCAT('{"id_rumah_sakit": "', INSERTED.id_rumah_sakit, '", "nama_rumah_sakit": "', INSERTED.nama_rumah_sakit, '", "id_kecamatan": "', INSERTED.id_kecamatan, '"}')
    FROM INSERTED;
END;
CREATE TRIGGER after_update_rumah_sakit
ON rumah_sakit
AFTER UPDATE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data, new_data)
    SELECT 'rumah_sakit', 'UPDATE',
           CONCAT('{"id_rumah_sakit": "', DELETED.id_rumah_sakit, '", "nama_rumah_sakit": "', DELETED.nama_rumah_sakit, '", "id_kecamatan": "', DELETED.id_kecamatan, '"}'),
           CONCAT('{"id_rumah_sakit": "', INSERTED.id_rumah_sakit, '", "nama_rumah_sakit": "', INSERTED.nama_rumah_sakit, '", "id_kecamatan": "', INSERTED.id_kecamatan, '"}')
    FROM DELETED
    JOIN INSERTED ON DELETED.id_rumah_sakit = INSERTED.id_rumah_sakit;
END;
CREATE TRIGGER after_delete_rumah_sakit
ON rumah_sakit
AFTER DELETE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data)
    SELECT 'rumah_sakit', 'DELETE',
           CONCAT('{"id_rumah_sakit": "', DELETED.id_rumah_sakit, '", "nama_rumah_sakit": "', DELETED.nama_rumah_sakit, '", "id_kecamatan": "', DELETED.id_kecamatan, '"}')
    FROM DELETED;
END;
CREATE TRIGGER after_insert_riwayat_penyakit
ON riwayat_penyakit
AFTER INSERT
AS
BEGIN
    INSERT INTO log (table_name, operation, new_data)
    SELECT 'riwayat_penyakit', 'INSERT', CONCAT('{"id_riwayat": "', INSERTED.id_riwayat, '", "id_penduduk": "', INSERTED.id_penduduk, '", "id_rumah_sakit": "', INSERTED.id_rumah_sakit, '", "id_penyakit": "', INSERTED.id_penyakit, '", "awal_sakit": "', CONVERT(VARCHAR, INSERTED.awal_sakit, 120), '", "akhir_sakit": "', CONVERT(VARCHAR, INSERTED.akhir_sakit, 120), '"}')
    FROM INSERTED;
END;
CREATE TRIGGER after_update_riwayat_penyakit
ON riwayat_penyakit
AFTER UPDATE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data, new_data)
    SELECT 'riwayat_penyakit', 'UPDATE',
           CONCAT('{"id_riwayat": "', DELETED.id_riwayat, '", "id_penduduk": "', DELETED.id_penduduk, '", "id_rumah_sakit": "', DELETED.id_rumah_sakit, '", "id_penyakit": "', DELETED.id_penyakit, '", "awal_sakit": "', CONVERT(VARCHAR, DELETED.awal_sakit, 120), '", "akhir_sakit": "', CONVERT(VARCHAR, DELETED.akhir_sakit, 120), '"}'),
           CONCAT('{"id_riwayat": "', INSERTED.id_riwayat, '", "id_penduduk": "', INSERTED.id_penduduk, '", "id_rumah_sakit": "', INSERTED.id_rumah_sakit, '", "id_penyakit": "', INSERTED.id_penyakit, '", "awal_sakit": "', CONVERT(VARCHAR, INSERTED.awal_sakit, 120), '", "akhir_sakit": "', CONVERT(VARCHAR, INSERTED.akhir_sakit, 120), '"}')
    FROM DELETED
    JOIN INSERTED ON DELETED.id_riwayat = INSERTED.id_riwayat;
END;
CREATE TRIGGER after_delete_riwayat_penyakit
ON riwayat_penyakit
AFTER DELETE
AS
BEGIN
    INSERT INTO log (table_name, operation, old_data)
    SELECT 'riwayat_penyakit', 'DELETE',
           CONCAT('{"id_riwayat": "', DELETED.id_riwayat, '", "id_penduduk": "', DELETED.id_penduduk, '", "id_rumah_sakit": "', DELETED.id_rumah_sakit, '", "id_penyakit": "', DELETED.id_penyakit, '", "awal_sakit": "', CONVERT(VARCHAR, DELETED.awal_sakit, 120), '", "akhir_sakit": "', CONVERT(VARCHAR, DELETED.akhir_sakit, 120), '"}')
    FROM DELETED;
END;

CREATE VIEW v_penyakit_terbanyak_kecamatan AS
SELECT 
    k.nama_kecamatan,
    p.mikroorganisme AS nama_penyakit,
    COUNT(rp.id_riwayat) AS jumlah_kasus
FROM 
    riwayat_penyakit rp
JOIN 
    penduduk pd ON rp.id_penduduk = pd.id_penduduk
JOIN 
    kecamatan k ON pd.id_kecamatan = k.id_kecamatan
JOIN 
    penyakit p ON rp.id_penyakit = p.id_penyakit
GROUP BY 
    k.nama_kecamatan, p.mikroorganisme;

CREATE VIEW v_penyakit_terbanyak_kota AS
SELECT 
    ko.nama_kota,
    p.mikroorganisme AS nama_penyakit,
    COUNT(rp.id_riwayat) AS jumlah_kasus
FROM 
    riwayat_penyakit rp
JOIN 
    penduduk pd ON rp.id_penduduk = pd.id_penduduk
JOIN 
    kecamatan k ON pd.id_kecamatan = k.id_kecamatan
JOIN 
    kota ko ON k.id_kota = ko.id_kota
JOIN 
    penyakit p ON rp.id_penyakit = p.id_penyakit
GROUP BY 
    ko.nama_kota, p.mikroorganisme;

SELECT * FROM log

--INSERT INTO riwayat_penyakit (id_riwayat, id_penduduk, nama_penyakit, awal_sakit, akhir_sakit) VALUES
--('RP00001', 'P00001', 'Influenza', '2023-01-01 08:00:00', '2023-01-05 08:00:00'),
--('RP00002', 'P00002', 'Diabetes Mellitus', '2023-01-02 08:00:00', '2023-01-06 08:00:00'),
--('RP00003', 'P00003', 'Hipertensi', '2023-01-03 08:00:00', '2023-01-07 08:00:00'),
--('RP00004', 'P00004', 'Asma', '2023-01-04 08:00:00', '2023-01-08 08:00:00'),
--('RP00005', 'P00005', 'Gastritis', '2023-01-05 08:00:00', '2023-01-09 08:00:00'),
--('RP00006', 'P00006', 'Bronkitis', '2023-01-06 08:00:00', '2023-01-10 08:00:00'),
--('RP00007', 'P00007', 'Tuberkulosis', '2023-01-07 08:00:00', '2023-01-11 08:00:00'),
--('RP00008', 'P00008', 'Migraine', '2023-01-08 08:00:00', '2023-01-12 08:00:00'),
--('RP00009', 'P00009', 'Cacar Air', '2023-01-09 08:00:00', '2023-01-13 08:00:00'),
--('RP00010', 'P00010', 'COVID-19', '2023-01-10 08:00:00', '2023-01-14 08:00:00'),
--('RP00011', 'P00011', 'Demam Berdarah', '2023-01-11 08:00:00', '2023-01-15 08:00:00'),
--('RP00012', 'P00012', 'Malaria', '2023-01-12 08:00:00', '2023-01-16 08:00:00'),
--('RP00013', 'P00013', 'Hepatitis', '2023-01-13 08:00:00', '2023-01-17 08:00:00'),
--('RP00014', 'P00014', 'Gagal Ginjal', '2023-01-14 08:00:00', '2023-01-18 08:00:00'),
--('RP00015', 'P00015', 'Artritis', '2023-01-15 08:00:00', '2023-01-19 08:00:00'),
--('RP00016', 'P00016', 'Pneumonia', '2023-01-16 08:00:00', '2023-01-20 08:00:00'),
--('RP00017', 'P00017', 'Eczema', '2023-01-17 08:00:00', '2023-01-21 08:00:00'),
--('RP00018', 'P00018', 'Sinusitis', '2023-01-18 08:00:00', '2023-01-22 08:00:00'),
--('RP00019', 'P00019', 'Epilepsi', '2023-01-19 08:00:00', '2023-01-23 08:00:00'),
--('RP00020', 'P00020', 'Depresi', '2023-01-20 08:00:00', '2023-01-24 08:00:00'),
--('RP00021', 'P00021', 'Schizophrenia', '2023-01-21 08:00:00', '2023-01-25 08:00:00'),
--('RP00022', 'P00022', 'Anoreksia', '2023-01-22 08:00:00', '2023-01-26 08:00:00'),
--('RP00023', 'P00023', 'Bulimia', '2023-01-23 08:00:00', '2023-01-27 08:00:00'),
--('RP00024', 'P00024', 'Osteoporosis', '2023-01-24 08:00:00', '2023-01-28 08:00:00'),
--('RP00025', 'P00025', 'Parkinson', '2023-01-25 08:00:00', '2023-01-29 08:00:00'),
--('RP00026', 'P00026', 'Alzheimer', '2023-01-26 08:00:00', '2023-01-30 08:00:00'),
--('RP00027', 'P00027', 'AIDS', '2023-01-27 08:00:00', '2023-01-31 08:00:00'),
--('RP00028', 'P00028', 'Lupus', '2023-01-28 08:00:00', '2023-02-01 08:00:00'),
--('RP00029', 'P00029', 'Kanker Payudara', '2023-01-29 08:00:00', '2023-02-02 08:00:00'),
--('RP00030', 'P00030', 'Kanker Paru', '2023-01-30 08:00:00', '2023-02-03 08:00:00'),
--('RP00031', 'P00031', 'Kanker Serviks', '2023-01-31 08:00:00', '2023-02-04 08:00:00'),
--('RP00032', 'P00032', 'Kanker Usus', '2023-02-01 08:00:00', '2023-02-05 08:00:00'),
--('RP00033', 'P00033', 'Leukemia', '2023-02-02 08:00:00', '2023-02-06 08:00:00'),
--('RP00034', 'P00034', 'Tumor Otak', '2023-02-03 08:00:00', '2023-02-07 08:00:00'),
--('RP00035', 'P00035', 'Rabies', '2023-02-04 08:00:00', '2023-02-08 08:00:00'),
--('RP00036', 'P00036', 'Gondok', '2023-02-05 08:00:00', '2023-02-09 08:00:00'),
--('RP00037', 'P00037', 'Sklerosis Multipel', '2023-02-06 08:00:00', '2023-02-10 08:00:00'),
--('RP00038', 'P00038', 'Kolera', '2023-02-07 08:00:00', '2023-02-11 08:00:00'),
--('RP00039', 'P00039', 'Polio', '2023-02-08 08:00:00', '2023-02-12 08:00:00'),
--('RP00040', 'P00040', 'Campak', '2023-02-09 08:00:00', '2023-02-13 08:00:00'),
--('RP00041', 'P00041', 'Rubella', '2023-02-10 08:00:00', '2023-02-14 08:00:00'),
--('RP00042', 'P00042', 'Tetanus', '2023-02-11 08:00:00', '2023-02-15 08:00:00'),
--('RP00043', 'P00043', 'Difteri', '2023-02-12 08:00:00', '2023-02-16 08:00:00'),
--('RP00044', 'P00044', 'Demam Tifoid', '2023-02-13 08:00:00', '2023-02-17 08:00:00'),
--('RP00045', 'P00045', 'Radang Tenggorokan', '2023-02-14 08:00:00', '2023-02-18 08:00:00'),
--('RP00046', 'P00046', 'Otitis Media', '2023-02-15 08:00:00', '2023-02-19 08:00:00'),
--('RP00047', 'P00047', 'Vertigo', '2023-02-16 08:00:00', '2023-02-20 08:00:00'),
--('RP00048', 'P00048', 'Ulkus Peptikum', '2023-02-17 08:00:00', '2023-02-21 08:00:00'),
--('RP00049', 'P00049', 'Hemoroid', '2023-02-18 08:00:00', '2023-02-22 08:00:00'),
--('RP00050', 'P00050', 'Konjungtivitis', '2023-02-19 08:00:00', '2023-02-23 08:00:00'),
--('RP00051', 'P00051', 'Katarak', '2023-02-20 08:00:00', '2023-02-24 08:00:00'),
--('RP00052', 'P00052', 'Glaukoma', '2023-02-21 08:00:00', '2023-02-25 08:00:00'),
--('RP00053', 'P00053', 'Retinopati Diabetik', '2023-02-22 08:00:00', '2023-02-26 08:00:00'),
--('RP00054', 'P00054', 'Herpes Zoster', '2023-02-23 08:00:00', '2023-02-27 08:00:00'),
--('RP00055', 'P00055', 'Scabies', '2023-02-24 08:00:00', '2023-02-28 08:00:00'),
--('RP00056', 'P00056', 'Psoriasis', '2023-02-25 08:00:00', '2023-03-01 08:00:00'),
--('RP00057', 'P00057', 'Vitiligo', '2023-02-26 08:00:00', '2023-03-02 08:00:00'),
--('RP00058', 'P00058', 'Alergi', '2023-02-27 08:00:00', '2023-03-03 08:00:00'),
--('RP00059', 'P00059', 'Gagal Jantung', '2023-02-28 08:00:00', '2023-03-04 08:00:00'),
--('RP00060', 'P00060', 'Arrhythmia', '2023-03-01 08:00:00', '2023-03-05 08:00:00'),
--('RP00061', 'P00061', 'Hipotensi', '2023-03-02 08:00:00', '2023-03-06 08:00:00'),
--('RP00062', 'P00062', 'Varises', '2023-03-03 08:00:00', '2023-03-07 08:00:00'),
--('RP00063', 'P00063', 'Stroke', '2023-03-04 08:00:00', '2023-03-08 08:00:00'),
--('RP00064', 'P00064', 'TIA', '2023-03-05 08:00:00', '2023-03-09 08:00:00'),
--('RP00065', 'P00065', 'Spondylosis', '2023-03-06 08:00:00', '2023-03-10 08:00:00'),
--('RP00066', 'P00066', 'Dislokasi', '2023-03-07 08:00:00', '2023-03-11 08:00:00'),
--('RP00067', 'P00067', 'Fraktur', '2023-03-08 08:00:00', '2023-03-12 08:00:00'),
--('RP00068', 'P00068', 'Karies Gigi', '2023-03-09 08:00:00', '2023-03-13 08:00:00'),
--('RP00069', 'P00069', 'Periodontitis', '2023-03-10 08:00:00', '2023-03-14 08:00:00'),
--('RP00070', 'P00070', 'Stomatitis', '2023-03-11 08:00:00', '2023-03-15 08:00:00'),
--('RP00071', 'P00071', 'Sinusitis', '2023-03-12 08:00:00', '2023-03-16 08:00:00'),
--('RP00072', 'P00072', 'Bronkiektasis', '2023-03-13 08:00:00', '2023-03-17 08:00:00'),
--('RP00073', 'P00073', 'Fibrosis Paru', '2023-03-14 08:00:00', '2023-03-18 08:00:00'),
--('RP00074', 'P00074', 'Sarkoidosis', '2023-03-15 08:00:00', '2023-03-19 08:00:00'),
--('RP00075', 'P00075', 'Obesitas', '2023-03-16 08:00:00', '2023-03-20 08:00:00'),
--('RP00076', 'P00076', 'Sindrom Metabolik', '2023-03-17 08:00:00', '2023-03-21 08:00:00'),
--('RP00077', 'P00077', 'Asam Urat', '2023-03-18 08:00:00', '2023-03-22 08:00:00'),
--('RP00078', 'P00078', 'Hipoglikemia', '2023-03-19 08:00:00', '2023-03-23 08:00:00'),
--('RP00079', 'P00079', 'Ketoasidosis Diabetik', '2023-03-20 08:00:00', '2023-03-24 08:00:00'),
--('RP00080', 'P00080', 'Demam Rematik', '2023-03-21 08:00:00', '2023-03-25 08:00:00'),
--('RP00081', 'P00081', 'Autoimun', '2023-03-22 08:00:00', '2023-03-26 08:00:00'),
--('RP00082', 'P00082', 'Sindrom Cushing', '2023-03-23 08:00:00', '2023-03-27 08:00:00'),
--('RP00083', 'P00083', 'Addison', '2023-03-24 08:00:00', '2023-03-28 08:00:00'),
--('RP00084', 'P00084', 'Endometriosis', '2023-03-25 08:00:00', '2023-03-29 08:00:00'),
--('RP00085', 'P00085', 'Fibroid Rahim', '2023-03-26 08:00:00', '2023-03-30 08:00:00'),
--('RP00086', 'P00086', 'Polycystic Ovary Syndrome', '2023-03-27 08:00:00', '2023-03-31 08:00:00'),
--('RP00087', 'P00087', 'Disfungsi Ereksi', '2023-03-28 08:00:00', '2023-04-01 08:00:00'),
--('RP00088', 'P00088', 'Infertilitas', '2023-03-29 08:00:00', '2023-04-02 08:00:00'),
--('RP00089', 'P00089', 'BPH', '2023-03-30 08:00:00', '2023-04-03 08:00:00'),
--('RP00090', 'P00090', 'Prostatitis', '2023-03-31 08:00:00', '2023-04-04 08:00:00'),
--('RP00091', 'P00091', 'Sifilis', '2023-04-01 08:00:00', '2023-04-05 08:00:00'),
--('RP00092', 'P00092', 'Gonore', '2023-04-02 08:00:00', '2023-04-06 08:00:00'),
--('RP00093', 'P00093', 'HIV/AIDS', '2023-04-03 08:00:00', '2023-04-07 08:00:00'),
--('RP00094', 'P00094', 'Trikomoniasis', '2023-04-04 08:00:00', '2023-04-08 08:00:00'),
--('RP00095', 'P00095', 'Klamidia', '2023-04-05 08:00:00', '2023-04-09 08:00:00'),
--('RP00096', 'P00096', 'HPV', '2023-04-06 08:00:00', '2023-04-10 08:00:00'),
--('RP00097', 'P00097', 'Herpes Genitalis', '2023-04-07 08:00:00', '2023-04-11 08:00:00'),
--('RP00098', 'P00098', 'TBC Paru', '2023-04-08 08:00:00', '2023-04-12 08:00:00'),
--('RP00099', 'P00099', 'Demam Berdarah Dengue', '2023-04-09 08:00:00', '2023-04-13 08:00:00'),
--('RP00100', 'P00100', 'Leptospirosis', '2023-04-10 08:00:00', '2023-04-14 08:00:00');
--
--INSERT INTO rumah_sakit (id_rumah_sakit, id_provinsi, id_kota, nama_rumah_sakit) VALUES
--('RS-AC-01', 'ID-AC', 'ID-AC-01', 'Rumah Sakit Umum Zainoel Abidin'),
--('RS-AC-02', 'ID-AC', 'ID-AC-02', 'Rumah Sakit Umum Langsa'),
--('RS-AC-03', 'ID-AC', 'ID-AC-03', 'Rumah Sakit Umum Cut Meutia'),
--('RS-AC-04', 'ID-AC', 'ID-AC-04', 'Rumah Sakit Umum Sabang'),
--('RS-AC-05', 'ID-AC', 'ID-AC-05', 'Rumah Sakit Umum Subulussalam'),
--('RS-BA-01', 'ID-BA', 'ID-BA-01', 'Rumah Sakit Umum Pusat Sanglah'),
--('RS-BT-01', 'ID-BT', 'ID-BT-01', 'Rumah Sakit Umum Kota Cilegon'),
--('RS-BT-02', 'ID-BT', 'ID-BT-02', 'Rumah Sakit Umum Kota Serang'),
--('RS-BT-03', 'ID-BT', 'ID-BT-03', 'Rumah Sakit Umum Kota Tangerang'),
--('RS-BT-04', 'ID-BT', 'ID-BT-04', 'Rumah Sakit Umum Kota Tangerang Selatan'),
--('RS-JK-01', 'ID-JK', 'ID-JK-01', 'Rumah Sakit Umum Jakarta Barat'),
--('RS-JK-02', 'ID-JK', 'ID-JK-02', 'Rumah Sakit Umum Jakarta Pusat'),
--('RS-JK-03', 'ID-JK', 'ID-JK-03', 'Rumah Sakit Umum Fatmawati'),
--('RS-JK-04', 'ID-JK', 'ID-JK-04', 'Rumah Sakit Umum Jakarta Timur'),
--('RS-JK-05', 'ID-JK', 'ID-JK-05', 'Rumah Sakit Umum Jakarta Utara'),
--('RS-YO-01', 'ID-YO', 'ID-YO-01', 'Rumah Sakit Umum Sardjito'),
--('RS-PA-01', 'ID-PA', 'ID-PA-01', 'Rumah Sakit Umum Daerah Jayapura'),
--('RS-SU-01', 'ID-SU', 'ID-SU-01', 'Rumah Sakit Umum Haji Adam Malik'),
--('RS-SU-02', 'ID-SU', 'ID-SU-02', 'Rumah Sakit Umum Kota Binjai'),
--('RS-SU-03', 'ID-SU', 'ID-SU-03', 'Rumah Sakit Umum Kota Tebing Tinggi'),
--('RS-SU-04', 'ID-SU', 'ID-SU-04', 'Rumah Sakit Umum Pematangsiantar'),
--('RS-SU-05', 'ID-SU', 'ID-SU-05', 'Rumah Sakit Umum Kota Tanjungbalai'),
--('RS-SU-06', 'ID-SU', 'ID-SU-06', 'Rumah Sakit Umum Kota Sibolga'),
--('RS-SU-07', 'ID-SU', 'ID-SU-07', 'Rumah Sakit Umum Kota Padang Sidempuan'),
--('RS-SU-08', 'ID-SU', 'ID-SU-08', 'Rumah Sakit Umum Kota Gunungsitoli'),
--('RS-JB-01', 'ID-JB', 'ID-JB-01', 'Rumah Sakit Umum Hasan Sadikin'),
--('RS-JB-02', 'ID-JB', 'ID-JB-02', 'Rumah Sakit Umum Kota Bekasi'),
--('RS-JB-03', 'ID-JB', 'ID-JB-03', 'Rumah Sakit Umum Kota Bogor'),
--('RS-JB-04', 'ID-JB', 'ID-JB-04', 'Rumah Sakit Umum Kota Cimahi'),
--('RS-JB-05', 'ID-JB', 'ID-JB-05', 'Rumah Sakit Umum Kota Cirebon'),
--('RS-JB-06', 'ID-JB', 'ID-JB-06', 'Rumah Sakit Umum Kota Depok'),
--('RS-JB-07', 'ID-JB', 'ID-JB-07', 'Rumah Sakit Umum Kota Sukabumi'),
--('RS-JB-08', 'ID-JB', 'ID-JB-08', 'Rumah Sakit Umum Kota Tasikmalaya'),
--('RS-JT-01', 'ID-JT', 'ID-JT-01', 'Rumah Sakit Umum Dr. Kariadi'),
--('RS-JT-02', 'ID-JT', 'ID-JT-02', 'Rumah Sakit Umum Kota Surakarta'),
--('RS-JT-03', 'ID-JT', 'ID-JT-03', 'Rumah Sakit Umum Kota Salatiga'),
--('RS-JT-04', 'ID-JT', 'ID-JT-04', 'Rumah Sakit Umum Kota Pekalongan'),
--('RS-JT-05', 'ID-JT', 'ID-JT-05', 'Rumah Sakit Umum Kota Tegal'),
--('RS-JT-06', 'ID-JT', 'ID-JT-06', 'Rumah Sakit Umum Kota Magelang'),
--('RS-JI-01', 'ID-JI', 'ID-JI-01', 'Rumah Sakit Umum Dr. Soetomo'),
--('RS-JI-02', 'ID-JI', 'ID-JI-02', 'Rumah Sakit Umum Kota Malang'),
--('RS-JI-03', 'ID-JI', 'ID-JI-03', 'Rumah Sakit Umum Kota Madiun'),
--('RS-JI-04', 'ID-JI', 'ID-JI-04', 'Rumah Sakit Umum Kota Blitar'),
--('RS-JI-05', 'ID-JI', 'ID-JI-05', 'Rumah Sakit Umum Kota Kediri'),
--('RS-JI-06', 'ID-JI', 'ID-JI-06', 'Rumah Sakit Umum Kota Probolinggo'),
--('RS-JI-07', 'ID-JI', 'ID-JI-07', 'Rumah Sakit Umum Kota Pasuruan'),
--('RS-JI-08', 'ID-JI', 'ID-JI-08', 'Rumah Sakit Umum Kota Mojokerto'),
--('RS-JI-09', 'ID-JI', 'ID-JI-09', 'Rumah Sakit Umum Kota Batu'),
--('RS-KB-01', 'ID-KB', 'ID-KB-01', 'Rumah Sakit Umum Dr. Agoesdjam'),
--('RS-KB-02', 'ID-KB', 'ID-KB-02', 'Rumah Sakit Umum Kota Singkawang'),
--('RS-KS-01', 'ID-KS', 'ID-KS-01', 'Rumah Sakit Umum Ulin'),
--('RS-KS-02', 'ID-KS', 'ID-KS-02', 'Rumah Sakit Umum Kota Banjarbaru'),
--('RS-KT-01', 'ID-KT', 'ID-KT-01', 'Rumah Sakit Umum Doris Sylvanus'),
--('RS-KI-01', 'ID-KI', 'ID-KI-01', 'Rumah Sakit Umum Kanujoso Djatiwibowo'),
--('RS-KI-02', 'ID-KI', 'ID-KI-02', 'Rumah Sakit Umum Kota Samarinda'),
--('RS-KI-03', 'ID-KI', 'ID-KI-03', 'Rumah Sakit Umum Kota Bontang'),
--('RS-KU-01', 'ID-KU', 'ID-KU-01', 'Rumah Sakit Umum Tanjung Selor'),
--('RS-KU-02', 'ID-KU', 'ID-KU-02', 'Rumah Sakit Umum Kota Tarakan'),
--('RS-SR-01', 'ID-SR', 'ID-SR-01', 'Rumah Sakit Umum Regional Sulawesi Barat'),
--('RS-SR-02', 'ID-SR', 'ID-SR-02', 'Rumah Sakit Umum Majene'),
--('RS-SN-01', 'ID-SN', 'ID-SN-01', 'Rumah Sakit Umum Labuang Baji'),
--('RS-SN-02', 'ID-SN', 'ID-SN-02', 'Rumah Sakit Umum Kota Palopo'),
--('RS-SN-03', 'ID-SN', 'ID-SN-03', 'Rumah Sakit Umum Kota Parepare'),
--('RS-ST-01', 'ID-ST', 'ID-ST-01', 'Rumah Sakit Umum Anutapura'),
--('RS-ST-02', 'ID-ST', 'ID-ST-02', 'Rumah Sakit Umum Kota Palu'),
--('RS-ST-03', 'ID-ST', 'ID-ST-03', 'Rumah Sakit Umum Kota Palu Selatan'),
--('RS-SG-01', 'ID-SG', 'ID-SG-01', 'Rumah Sakit Umum Bahteramas'),
--('RS-SG-02', 'ID-SG', 'ID-SG-02', 'Rumah Sakit Umum Kendari'),
--('RS-SA-01', 'ID-SA', 'ID-SA-01', 'Rumah Sakit Umum Prof. Dr. R. D. Kandou'),
--('RS-SA-02', 'ID-SA', 'ID-SA-02', 'Rumah Sakit Umum Kota Tomohon'),
--('RS-SA-03', 'ID-SA', 'ID-SA-03', 'Rumah Sakit Umum Bitung'),
--('RS-SB-01', 'ID-SB', 'ID-SB-01', 'Rumah Sakit Umum Dr. M. Djamil'),
--('RS-SB-02', 'ID-SB', 'ID-SB-02', 'Rumah Sakit Umum Kota Bukittinggi'),
--('RS-SB-03', 'ID-SB', 'ID-SB-03', 'Rumah Sakit Umum Kota Solok'),
--('RS-SB-04', 'ID-SB', 'ID-SB-04', 'Rumah Sakit Umum Kota Padang Panjang'),
--('RS-SS-01', 'ID-SS', 'ID-SS-01', 'Rumah Sakit Umum Muhammad Hoesin'),
--('RS-SS-02', 'ID-SS', 'ID-SS-02', 'Rumah Sakit Umum Kota Lubuklinggau'),
--('RS-SS-03', 'ID-SS', 'ID-SS-03', 'Rumah Sakit Umum Kota Prabumulih'),
--('RS-SS-04', 'ID-SS', 'ID-SS-04', 'Rumah Sakit Umum Kota Pagaralam')
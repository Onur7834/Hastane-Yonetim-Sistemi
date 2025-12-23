USE [FirinDB]
GO
/****** Object:  Table [dbo].[Doktorlar]    Script Date: 23.12.2025 13:34:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doktorlar](
	[DoktorID] [int] IDENTITY(1,1) NOT NULL,
	[AdSoyad] [nvarchar](100) NOT NULL,
	[PoliklinikID] [int] NULL,
	[Durum] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DoktorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuvenlikSorulari]    Script Date: 23.12.2025 13:34:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuvenlikSorulari](
	[SoruID] [int] IDENTITY(1,1) NOT NULL,
	[SoruMetni] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SoruID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hastalar]    Script Date: 23.12.2025 13:34:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hastalar](
	[HastaID] [int] IDENTITY(1,1) NOT NULL,
	[AdSoyad] [nvarchar](100) NOT NULL,
	[TCNo] [char](11) NOT NULL,
	[Telefon] [nvarchar](15) NULL,
	[PoliklinikID] [int] NULL,
	[Sikayet] [nvarchar](max) NULL,
	[KayitTarihi] [datetime] NULL,
	[DoktorID] [int] NULL,
	[Durum] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[HastaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kullanicilar]    Script Date: 23.12.2025 13:34:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanicilar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KullaniciAdi] [nvarchar](50) NOT NULL,
	[Sifre] [nvarchar](50) NOT NULL,
	[Rol] [nvarchar](30) NULL,
	[SoruID] [int] NULL,
	[GuvenlikCevabi] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Poliklinikler]    Script Date: 23.12.2025 13:34:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poliklinikler](
	[PoliklinikID] [int] IDENTITY(1,1) NOT NULL,
	[PoliklinikAdi] [nvarchar](50) NOT NULL,
	[Durum] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PoliklinikID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Doktorlar] ON 

INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (1, N'Dr. Ali Vefa', 1, 1)
INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (2, N'Dr. Nazlı Gül', 1, 1)
INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (3, N'Dr. Ferman Eryiğit', 1002, 1)
INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (4, N'Dr. Tanju Hoca', 3, 1)
INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (5, N'Mehmet Soylu', 3, 0)
INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (1002, N'Dr. Yasemin', 1, 1)
INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (1003, N'Erol', 3, 1)
INSERT [dbo].[Doktorlar] ([DoktorID], [AdSoyad], [PoliklinikID], [Durum]) VALUES (1004, N'Ayşe Erdoğan', 1002, 1)
SET IDENTITY_INSERT [dbo].[Doktorlar] OFF
GO
SET IDENTITY_INSERT [dbo].[GuvenlikSorulari] ON 

INSERT [dbo].[GuvenlikSorulari] ([SoruID], [SoruMetni]) VALUES (1, N'Annenizin kızlık soyadı nedir?')
INSERT [dbo].[GuvenlikSorulari] ([SoruID], [SoruMetni]) VALUES (2, N'İlk evcil hayvanınızın adı nedir?')
INSERT [dbo].[GuvenlikSorulari] ([SoruID], [SoruMetni]) VALUES (3, N'İlkokul öğretmeninizin adı nedir?')
INSERT [dbo].[GuvenlikSorulari] ([SoruID], [SoruMetni]) VALUES (4, N'En sevdiğiniz yemek hangisidir?')
INSERT [dbo].[GuvenlikSorulari] ([SoruID], [SoruMetni]) VALUES (5, N'Doğduğunuz şehir neresidir?')
SET IDENTITY_INSERT [dbo].[GuvenlikSorulari] OFF
GO
SET IDENTITY_INSERT [dbo].[Hastalar] ON 

INSERT [dbo].[Hastalar] ([HastaID], [AdSoyad], [TCNo], [Telefon], [PoliklinikID], [Sikayet], [KayitTarihi], [DoktorID], [Durum]) VALUES (1005, N'Muharrem Kutlu', N'40217414241', N'024878462', 1, N'Kalbinde Ağır Delik Açılmış', CAST(N'2025-12-21T19:34:51.950' AS DateTime), 1, 0)
INSERT [dbo].[Hastalar] ([HastaID], [AdSoyad], [TCNo], [Telefon], [PoliklinikID], [Sikayet], [KayitTarihi], [DoktorID], [Durum]) VALUES (2002, N'Ahmet İmam', N'40217414241', N'03814984141', 1, N'Hasta Ağır Yaralı', CAST(N'2025-12-22T09:51:31.603' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Hastalar] OFF
GO
SET IDENTITY_INSERT [dbo].[Kullanicilar] ON 

INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Rol], [SoruID], [GuvenlikCevabi]) VALUES (4, N'Onur', N'123', N'Admin', 5, N'İsanbul')
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Rol], [SoruID], [GuvenlikCevabi]) VALUES (1003, N'Oğuz', N'12345', N'Orta', 4, N'Döner')
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Rol], [SoruID], [GuvenlikCevabi]) VALUES (1004, N'Kerem', N'567', N'Kullanici', 2, N'Köpek')
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Rol], [SoruID], [GuvenlikCevabi]) VALUES (2003, N'Yusuf', N'123', N'Kullanıcı', 3, N'Yasemin')
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Rol], [SoruID], [GuvenlikCevabi]) VALUES (2004, N'Öznur', N'908', N'Kullanıcı', 2, N'kuş')
SET IDENTITY_INSERT [dbo].[Kullanicilar] OFF
GO
SET IDENTITY_INSERT [dbo].[Poliklinikler] ON 

INSERT [dbo].[Poliklinikler] ([PoliklinikID], [PoliklinikAdi], [Durum]) VALUES (1, N'Dahiliye', 1)
INSERT [dbo].[Poliklinikler] ([PoliklinikID], [PoliklinikAdi], [Durum]) VALUES (3, N'Kardiyoloji', 1)
INSERT [dbo].[Poliklinikler] ([PoliklinikID], [PoliklinikAdi], [Durum]) VALUES (4, N'Cildiye', 0)
INSERT [dbo].[Poliklinikler] ([PoliklinikID], [PoliklinikAdi], [Durum]) VALUES (1002, N'Gastroenteroloji', 1)
SET IDENTITY_INSERT [dbo].[Poliklinikler] OFF
GO
ALTER TABLE [dbo].[Doktorlar] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[Hastalar] ADD  DEFAULT (getdate()) FOR [KayitTarihi]
GO
ALTER TABLE [dbo].[Hastalar] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[Kullanicilar] ADD  CONSTRAINT [DF_Kullanicilar_Rol]  DEFAULT ('Kullanıcı') FOR [Rol]
GO
ALTER TABLE [dbo].[Poliklinikler] ADD  DEFAULT ((1)) FOR [Durum]
GO

# 🏥 Hastane Yönetim Sistemi

Bu proje, **C#** ve **ASP.NET Web Forms** kullanılarak geliştirilmiş Basit bir hastane otomasyonudur.

## 🚀 Özellikler
- **Hasta Kabul:** Kademeli seçim (Poliklinik -> Doktor) ile hasta kaydı.
- **Akıllı Silme (Smart Delete):** Veriler önce arşivlenir (Pasif), istenirse kalıcı silinir.
- **Rol Yönetimi:** Admin, Personel ve Kullanıcı yetkilendirmesi.
- **Raporlama:** Görselleştirilmiş veri listeleri.

## 🛠️ Kurulum
1. Projeyi indirin.
2. `Veritabani_Kurulum.sql` dosyasını MSSQL Server'da çalıştırarak veritabanını oluşturun.
3. `Web.config` dosyasındaki bağlantı cümlesini kendi sunucunuza göre düzenleyin.
4. Projedeki **.cs** uzantılı dosyaları (Örn: `HastaneOtomasyon.aspx.cs`, `WebForm1.aspx.cs`) açın.
5. En üst satırlarda bulunan **`baglantiYolu`** değişkenindeki sunucu adını (`Data Source`) kendi bilgisayarınızın SQL sunucu adına göre güncelleyin.
6. Projeyi Visual Studio ile başlatın.

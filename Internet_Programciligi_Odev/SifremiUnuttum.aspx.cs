using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
namespace Internet_Programciligi_Odev
{
    public partial class SifremiUnuttum : System.Web.UI.Page
    {
        string baglantiYolu = "Data Source=localhost;Initial Catalog=FirinDB;User ID=sa;Password=123;";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSorgula_Click(object sender, EventArgs e)
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {

                string sorgu = "SELECT GuvenlikSorulari.SoruMetni FROM Kullanicilar INNER JOIN GuvenlikSorulari ON Kullanicilar.SoruID = GuvenlikSorulari.SoruID WHERE Kullanicilar.KullaniciAdi = @p1";
                SqlCommand komut = new SqlCommand(sorgu, baglanti);
                komut.Parameters.AddWithValue("@p1", txtKullaniciAdi.Text);

                baglanti.Open();
                object sonuc = komut.ExecuteScalar();

                if (sonuc != null)
                {

                    lblSoru.Text = sonuc.ToString();


                    pnlKullaniciSorgu.Visible = false;
                    pnlSifreDegistir.Visible = true;


                    Session["KullaniciAdi"] = txtKullaniciAdi.Text;
                    lblMesaj.Text = "";
                }
                else
                {
                    lblMesaj.Text = "Böyle bir kullanıcı bulunamadı!";
                    lblMesaj.ForeColor = Color.Red;
                }
            }
        }

        protected void btnDegistir_Click(object sender, EventArgs e)
        {
            
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sorgu = "UPDATE Kullanicilar SET Sifre=@yeniSifre WHERE KullaniciAdi=@kadi AND GuvenlikCevabi=@cevap";
                SqlCommand komut = new SqlCommand(sorgu, baglanti);

                komut.Parameters.AddWithValue("@yeniSifre", txtYeniSifre.Text);
                komut.Parameters.AddWithValue("@kadi", Session["KullaniciAdi"].ToString());
                komut.Parameters.AddWithValue("@cevap", txtGuvenlikCevap.Text);

                baglanti.Open();

                int etkilenenSatir = komut.ExecuteNonQuery();

                if (etkilenenSatir > 0)
                {
                    lblMesaj.Text = "Şifreniz başarıyla güncellendi! Yönlendiriliyorsunuz...";
                    lblMesaj.ForeColor = Color.Green;

                   
                    pnlSifreDegistir.Visible = false;

                  
                    Response.AddHeader("REFRESH", "3;URL=WebForm1.aspx");
                }
                else
                {
                    lblMesaj.Text = "Güvenlik cevabı hatalı!";
                    lblMesaj.ForeColor = Color.Red;
                }
            }
        }
    }
}
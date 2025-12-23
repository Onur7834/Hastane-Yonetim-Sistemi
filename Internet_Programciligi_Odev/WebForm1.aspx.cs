using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;

namespace Internet_Programciligi_Odev
{
    public partial class WebForm1 : System.Web.UI.Page
    {
       
        string baglantiYolu = "Data Source=localhost;Initial Catalog=FirinDB;User ID=sa;Password=123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack==false)
            {
                if (Session["YanlisSifreEkranindanGeldi"] != null)
                {
                    Session["HataSayaci"] = 0;
                    txtDogrulamaKodu.Visible = true;
                    txtKullanici.Visible = false;
                    txtSifre.Visible = false;


                }
                else
                {
           
                    txtDogrulamaKodu.Visible = false;
                    
                }
            }
        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            int hataSayaci = 0;
            if (Session["HataSayaci"] == null)
            {
                Session["HataSayaci"] = 0;
            }

            if (Session["YanlisSifreEkranindanGeldi"] != null)
            {
                if (txtDogrulamaKodu.Text != Session["DogruKod"].ToString())
                {
                    lblHata.Text = "Doğrulama kodu hatalı Tekrar Yanlış Şifre Ekranına yönlendiriliyorsunuz";
                    Response.AddHeader("REFRESH", "3;URL=Yanlis_Sifre.aspx");
                    return;
                }
                else
                {
                    lblHata.Text = "Kod doğru şifre Yenileme Ekranına Yönlendiriliyorsunuz";
                    lblHata.ForeColor = System.Drawing.Color.Green;

                    Session.Remove("YanlisSifreEkranindanGeldi");     
                    Session.Remove("DogruKod");
                    Response.AddHeader("REFRESH", "3;URL=SifremiUnuttum.aspx");
                 return;
                    

                }

            }


            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                
               
                string sorgu = "SELECT COUNT(*) FROM Kullanicilar WHERE KullaniciAdi=@KullaniciAdi AND Sifre=@Sifre";
                SqlCommand komut = new SqlCommand(sorgu, baglanti);
                komut.Parameters.AddWithValue("@KullaniciAdi", txtKullanici.Text);
                komut.Parameters.AddWithValue("@Sifre", txtSifre.Text);
                baglanti.Open();
                int sonuc = (int)komut.ExecuteScalar();

                
                if (sonuc > 0)
                {
                   
                  
                    string sorgu2 = "SELECT Rol from Kullanicilar where KullaniciAdi=@KullaniciAdi";
                    SqlCommand komut2 = new SqlCommand(sorgu2, baglanti);
                    komut2.Parameters.AddWithValue("@KullaniciAdi", txtKullanici.Text);
                    string rol = (string)komut2.ExecuteScalar();
                    Session["Rol"] = rol;
                    Session["Kullanici"]=txtKullanici.Text;
                    Response.Write("Rol: " + Session["Rol"]);
                    lblHata.Text = "Giriş Başarılı";
                    lblHata.ForeColor = System.Drawing.Color.Green;
                    Response.Redirect("Bekle.aspx");

                }
                else
                {
                   
                    if ((int)Session["HataSayaci"] == 0)
                    {
                        lblHata.Text = "Kullanıcı adı veya şifre hatalı Bir Sonraki Hatalı Girişinizde Yanlış Şifre Sayfasına Yönlendirileceksiniz";
                        hataSayaci++;
                        Session["HataSayaci"] = hataSayaci;
                  
                    }
                    else
                    {
                        Session["HataSayaci"] = (int)Session["HataSayaci"] + 1;
                      
                        if ((int)Session["HataSayaci"] == 2)
                        {
                            lblHata.Text = "Çok fazla Hatalı Giriş Yaptınız Yanlış Şifre ekranına Yönlendiriliyorsunuz";
                            Response.AddHeader("REFRESH", "3;URL=Yanlis_Sifre.aspx");
                            Session["HataSayaci"] = 0;
                        }

                    }
                 }
            }
        }

        protected void txtKullanici_TextChanged(object sender, EventArgs e)
        {

        }

        protected void lnkSifremiUnuttum_Click(object sender, EventArgs e)
        {
            Response.Redirect("SifremiUnuttum.aspx");
        }

        protected void lnkKayitOl_Click(object sender, EventArgs e)
        {
            Response.Redirect("KayitOl.aspx");
        }
    }
}
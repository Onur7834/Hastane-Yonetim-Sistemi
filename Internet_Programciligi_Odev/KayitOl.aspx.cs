using System;
using System.Data;
using System.Data.SqlClient;

namespace Internet_Programciligi_Odev
{
    public partial class KayitOl : System.Web.UI.Page
    {
        string baglantiYolu = "Data Source=localhost;Initial Catalog=FirinDB;User ID=sa;Password=123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
             
                SorulariGetir();
            }
        }

     
        private void SorulariGetir()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sorgu = "SELECT SoruID, SoruMetni FROM GuvenlikSorulari";
                SqlDataAdapter da = new SqlDataAdapter(sorgu, baglanti);
                DataTable dt = new DataTable();
                da.Fill(dt);

             
                ddlSorular.DataSource = dt;
                ddlSorular.DataTextField = "SoruMetni";
                ddlSorular.DataValueField = "SoruID";   
                ddlSorular.DataBind();

               
                ddlSorular.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Lütfen bir soru seçiniz...", "0"));
            }
        }

        protected void btnKayitOl_Click(object sender, EventArgs e)
        {
       
            if (ddlSorular.SelectedValue == "0")
            {
                lblDurum.Text = "Lütfen bir güvenlik sorusu seçiniz!";
                return;
            }

            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                try
                {
                    string sorgu = "INSERT INTO Kullanicilar (KullaniciAdi, Sifre, SoruID, GuvenlikCevabi) VALUES (@kadi, @sifre, @soruID, @cevap)";

                    SqlCommand komut = new SqlCommand(sorgu, baglanti);
                    komut.Parameters.AddWithValue("@kadi", txtKadi.Text);
                    komut.Parameters.AddWithValue("@sifre", txtSifre.Text);
                    komut.Parameters.AddWithValue("@soruID", ddlSorular.SelectedValue); // DropDown'dan seçilen ID
                    komut.Parameters.AddWithValue("@cevap", txtCevap.Text);

                    baglanti.Open();
                    komut.ExecuteNonQuery();

                    lblDurum.Text = "Kayıt Başarılı! Giriş ekranına yönlendiriliyorsunuz...";
                    lblDurum.ForeColor = System.Drawing.Color.Green;

                  
                    Response.AddHeader("REFRESH", "2;URL=WebForm1.aspx");
                }
                catch (Exception ex)
                {
                    lblDurum.Text = "Hata oluştu: " + ex.Message;
                }
            }
        }
    }
}
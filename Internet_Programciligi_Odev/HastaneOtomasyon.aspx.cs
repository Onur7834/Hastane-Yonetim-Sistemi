using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace Internet_Programciligi_Odev
{
    public partial class HastaneOtomasyon : System.Web.UI.Page
    {
       
        string baglantiYolu = "Data Source=localhost;Initial Catalog=FirinDB;User ID=sa;Password=123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
             
                if (Session["Rol"] == null)
                {
                    Response.Redirect("WebForm1.aspx");
                    return;
                }

             
                if (Session["Kullanici"] != null) lblKullanici.Text = Session["Kullanici"].ToString();
                if (Session["Rol"] != null) lblRol.Text = Session["Rol"].ToString();

               
                PanelAc(pnlHastalar, btnHastalar);

                PoliklinikleriGetir();
                KullanicilariGetir();

         
                HastalariListele();
                Yetki();



            }
            Yetki();
        }
        void Yetki()
        {
           if( Session["Rol"].ToString() == "Kullanıcı")
            {
                btnDoktorGuncelle.Visible = false;
                btnHastaGuncelle.Visible = false;
                btnHastaSil.Visible = false;
                btnPolGuncelle.Visible=false;
            }
            if (Session["Rol"].ToString() == "Orta")
            {
                btnDoktorGuncelle.Visible = true;
                btnHastaGuncelle.Visible = true;
                btnPolGuncelle.Visible = true;
                if (btnHastaSil.Text== "Kalıcı Olarak Sil")
                {
                    btnHastaSil.Visible = false;
                   btnYetkiKaydet.Visible = false;
                    btnYetkilendirme.Visible = false;
                 
                }
                
            
            }
        }
        // ==========================================
        //  YARDIMCI METOD: DURUM KONTROLÜ (AKILLI SİLME İÇİN)
        // ==========================================

        bool KayitAktifMi(string tabloAdi, string idKolonu, string idDegeri)
        {
            bool aktifMi = false;
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = $"SELECT Durum FROM {tabloAdi} WHERE {idKolonu}=@id";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@id", idDegeri);
                baglanti.Open();
                object sonuc = komut.ExecuteScalar();
                if (sonuc != null && sonuc != DBNull.Value)
                {
                    aktifMi = Convert.ToBoolean(sonuc);
                }
            }
            return aktifMi;
        }

        // ==========================================
        //  PANEL GEÇİŞLERİ
        // ==========================================
        void PanelAc(Panel acilacakPanel, Button tiklananButon)
        {
     
            pnlHastalar.Visible = false;
            pnlPoliklinik.Visible = false;
            pnlDoktor.Visible = false;
            pnlYetki.Visible = false;

          
            btnHastalar.Enabled = true;
            btnPoliklinikler.Enabled = true;
            btnDoktorlar.Enabled = true;
            btnYetkilendirme.Enabled = true;

        
            acilacakPanel.Visible = true;

         
            tiklananButon.Enabled = false;

            lblDurum.Text = "";
        }


        protected void btnHastalar_Click(object sender, EventArgs e) 
        {
            PanelAc(pnlHastalar, btnHastalar); 
            HastalariListele(); 

        }
        protected void btnPoliklinikler_Click(object sender, EventArgs e)
        { 
            PanelAc(pnlPoliklinik, btnPoliklinikler);
            PoliklinikleriListele();
        }
        protected void btnDoktorlar_Click(object sender, EventArgs e)
        {
            PanelAc(pnlDoktor, btnDoktorlar); 
            DoktorlariListele(); 
        }
        protected void btnYetkilendirme_Click(object sender, EventArgs e)
        {
            if (Session["Rol"].ToString() == "Admin" || Session["Rol"].ToString() == "Orta")
            { PanelAc(pnlYetki, btnYetkilendirme);
                KullanicilariListele();
                if (Session["Rol"].ToString() == "Orta")
                {
                    btnYetkiKaydet.Visible = false; 
                   
                }
                else
                {
                  
                    btnYetkiKaydet.Visible = true;
                    ddlRoller.Enabled = true;
                }

            }
            else
            { lblDurum.Text = "Yetkiniz yok!"; 
              lblDurum.ForeColor = Color.Red;
            }
        }
        protected void lnkCikis_Click(object sender, EventArgs e)
        { 
            Session.Abandon(); 
          Response.Redirect("WebForm1.aspx");
        }


        // ==========================================
        //  1. HASTA İŞLEMLERİ
        // ==========================================
        void HastalariListele()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
        
                string sql = @"SELECT H.HastaID, H.AdSoyad, H.TCNo, H.Telefon, H.Sikayet, H.Durum, 
                                      P.PoliklinikAdi, D.AdSoyad AS DoktorAdi 
                               FROM Hastalar H
                               LEFT JOIN Poliklinikler P ON H.PoliklinikID = P.PoliklinikID
                               LEFT JOIN Doktorlar D ON H.DoktorID = D.DoktorID";

                if (Session["Rol"].ToString() != "Admin" && Session["Rol"].ToString() != "Orta")
                {
                    sql += " WHERE H.Durum = 1";
                }
                    

                SqlDataAdapter da = new SqlDataAdapter(sql, baglanti);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gridHastalar.DataSource = dt;
                gridHastalar.DataBind();
            }
        }

        protected void btnHastaKaydet_Click(object sender, EventArgs e)
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "INSERT INTO Hastalar (AdSoyad, TCNo, Telefon, PoliklinikID, DoktorID, Sikayet, Durum) VALUES (@ad, @tc, @tel, @pol, @dr, @sik, 1)";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@ad", txtHastaAdSoyad.Text);
                komut.Parameters.AddWithValue("@tc", txtTC.Text);
                komut.Parameters.AddWithValue("@tel", txtTelefon.Text);

                if (ddlPoliklinik.SelectedValue == "0") komut.Parameters.AddWithValue("@pol", DBNull.Value);
                else komut.Parameters.AddWithValue("@pol", ddlPoliklinik.SelectedValue);

                if (ddlDoktor.SelectedValue == "0" || ddlDoktor.SelectedValue == "") komut.Parameters.AddWithValue("@dr", DBNull.Value);
                else komut.Parameters.AddWithValue("@dr", ddlDoktor.SelectedValue);

                komut.Parameters.AddWithValue("@sik", txtSikayet.Text);

                baglanti.Open();
                komut.ExecuteNonQuery();
                HastalariListele();
                TemizleHasta();
                lblDurum.Text = "Hasta kaydedildi."; lblDurum.ForeColor = Color.Green;
            }
        }

        protected void btnHastaGuncelle_Click(object sender, EventArgs e)
        {
            if (txtHastaID.Text == "") return;
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "UPDATE Hastalar SET AdSoyad=@ad, TCNo=@tc, Telefon=@tel, PoliklinikID=@pol, DoktorID=@dr, Sikayet=@sik WHERE HastaID=@id";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@ad", txtHastaAdSoyad.Text);
                komut.Parameters.AddWithValue("@tc", txtTC.Text);
                komut.Parameters.AddWithValue("@tel", txtTelefon.Text);
                komut.Parameters.AddWithValue("@pol", ddlPoliklinik.SelectedValue);
                komut.Parameters.AddWithValue("@dr", ddlDoktor.SelectedValue);
                komut.Parameters.AddWithValue("@sik", txtSikayet.Text);
                komut.Parameters.AddWithValue("@id", txtHastaID.Text);

                baglanti.Open();
                komut.ExecuteNonQuery();
                HastalariListele();
                lblDurum.Text = "Hasta güncellendi."; lblDurum.ForeColor = Color.Blue;
            }
        }

   
        protected void btnHastaSil_Click(object sender, EventArgs e)
        {
            if (txtHastaID.Text == "") return;

           
            bool aktifMi = KayitAktifMi("Hastalar", "HastaID", txtHastaID.Text);

            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "";

                if (aktifMi)
                {
                 
                    sql = "UPDATE Hastalar SET Durum=0 WHERE HastaID=@id";
                    lblDurum.Text = "Hasta pasife alındı (Arşivlendi). Tamamen silmek için tekrar Sil'e basınız.";
                    lblDurum.ForeColor = Color.Orange;
                 
                    btnHastaSil.Text = "Kalıcı Sil";
                }
                else
                {
                   
                    sql = "DELETE FROM Hastalar WHERE HastaID=@id";
                    lblDurum.Text = "Hasta kaydı kalıcı olarak silindi.";
                    lblDurum.ForeColor = Color.Red;
                    btnHastaSil.Text = "Sil / Pasife Al"; 
                }

                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@id", txtHastaID.Text);
                baglanti.Open();
                komut.ExecuteNonQuery();

                HastalariListele();
                if (!aktifMi) TemizleHasta(); 
            }
        }

        protected void btnHastaTemizle_Click(object sender, EventArgs e) { TemizleHasta(); }
        void TemizleHasta()
        {
            txtHastaID.Text = ""; txtHastaAdSoyad.Text = ""; txtTC.Text = ""; txtTelefon.Text = ""; txtSikayet.Text = "";
            ddlPoliklinik.SelectedIndex = 0; ddlDoktor.Items.Clear();
            btnHastaSil.Text = "Sil / Pasife Al";
        }
        void HastaDetayGetir(int hastaId)
        {
            string sql = @"
        SELECT 
        H.HastaID,
        H.AdSoyad,
        H.TCNo,
        H.Telefon,
        H.Sikayet,
        H.Durum,
        H.PoliklinikID, 
        P.PoliklinikAdi,
        H.DoktorID,     
        D.AdSoyad AS DoktorAdi
    FROM Hastalar H
    LEFT JOIN Poliklinikler P ON H.PoliklinikID = P.PoliklinikID
    LEFT JOIN Doktorlar D ON H.DoktorID = D.DoktorID
    WHERE H.HastaID = @HastaID";

            if (Session["Rol"] == null ||
      (Session["Rol"].ToString() != "Admin" && Session["Rol"].ToString() != "Orta"))
            {
                sql += " AND H.Durum = 1";
            }


            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                SqlCommand komut = new SqlCommand(sql, baglanti);
                {
                    komut.Parameters.AddWithValue("@HastaID", hastaId);

                    baglanti.Open();
                    SqlDataReader dr = komut.ExecuteReader();

                    if (dr.Read())
                    {
                        txtHastaID.Text = dr["HastaID"].ToString();
                        txtHastaAdSoyad.Text = dr["AdSoyad"].ToString();
                        txtTC.Text = dr["TCNo"].ToString();
                        txtTelefon.Text = dr["Telefon"] == DBNull.Value ? "" : dr["Telefon"].ToString();
                        txtSikayet.Text = dr["Sikayet"] == DBNull.Value ? "" : dr["Sikayet"].ToString();
                        ddlPoliklinik.SelectedValue = dr["PoliklinikID"].ToString();
                        var gelenPolID = dr["PoliklinikID"].ToString();
                        SqlDataAdapter daDoktor = new SqlDataAdapter("SELECT DoktorID, AdSoyad FROM Doktorlar WHERE PoliklinikID=" + gelenPolID, baglantiYolu);
                        DataTable dtDoktor = new DataTable();
                        daDoktor.Fill(dtDoktor);

                        ddlDoktor.DataSource = dtDoktor;
                        ddlDoktor.DataTextField = "AdSoyad";
                        ddlDoktor.DataValueField = "DoktorID";
                        ddlDoktor.DataBind();
                        ddlDoktor.Items.Insert(0, new ListItem("Seçiniz...", "0"));


                        if (dr["DoktorID"] != DBNull.Value)
                        {
                            ddlDoktor.SelectedValue = dr["DoktorID"].ToString();
                        }

                        btnHastaSil.Text = Convert.ToBoolean(dr["Durum"]) ? "Pasife Al" : "Kalıcı Olarak Sil";

                        if (Session["Rol"] != null && Session["Rol"].ToString() == "Orta")
                        {
                            
                            if (btnHastaSil.Text == "Kalıcı Olarak Sil")
                            {
                                btnHastaSil.Visible = false;
                            }
                            else
                            {
                               
                                btnHastaSil.Visible = true;
                            }
                        }

                        baglanti.Close();
                    }
                }
            }
        }

        
            
             
        

        protected void gridHastalar_SelectedIndexChanged(object sender, EventArgs e)
        {

            int hastaId = Convert.ToInt32(gridHastalar.SelectedDataKey.Value);
            HastaDetayGetir(hastaId);
        }


        // ==========================================
        //  2. POLİKLİNİK İŞLEMLERİ
        // ==========================================
        void PoliklinikleriListele()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Poliklinikler", baglanti);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gridPoliklinikler.DataSource = dt;
                gridPoliklinikler.DataBind();
            }
        }

        protected void btnPolKaydet_Click(object sender, EventArgs e)
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "INSERT INTO Poliklinikler (PoliklinikAdi, Durum) VALUES (@adi, @durum)";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@adi", txtPoliklinikAdi.Text);
                komut.Parameters.AddWithValue("@durum", chkPoliklinikAktif.Checked);
                baglanti.Open();
                komut.ExecuteNonQuery();
                PoliklinikleriListele();
                PoliklinikleriGetir();
                lblDurum.Text = "Poliklinik Eklendi.";
            }
        }

        protected void btnPolGuncelle_Click(object sender, EventArgs e)
        {
            if (txtPoliklinikID.Text == "") return;
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "UPDATE Poliklinikler SET PoliklinikAdi=@adi, Durum=@durum WHERE PoliklinikID=@id";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@adi", txtPoliklinikAdi.Text);
                komut.Parameters.AddWithValue("@durum", chkPoliklinikAktif.Checked);
                komut.Parameters.AddWithValue("@id", txtPoliklinikID.Text);
                baglanti.Open();
                komut.ExecuteNonQuery();
                PoliklinikleriListele();
                PoliklinikleriGetir();
                lblDurum.Text = "Poliklinik Güncellendi.";
            }
        }

      
        protected void btnPolTemizle_Click(object sender, EventArgs e)
        {
         
            txtPoliklinikID.Text = ""; txtPoliklinikAdi.Text = ""; chkPoliklinikAktif.Checked = true;
        }

         
        protected void btnPolSil_Click(object sender, EventArgs e)
        {
            if (txtPoliklinikID.Text == "") return;
            bool aktifMi = KayitAktifMi("Poliklinikler", "PoliklinikID", txtPoliklinikID.Text);

            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "";
                if (aktifMi)
                {
                    sql = "UPDATE Poliklinikler SET Durum=0 WHERE PoliklinikID=@id";
                    lblDurum.Text = "Poliklinik pasife alındı.";
                }
                else
                {
                    sql = "DELETE FROM Poliklinikler WHERE PoliklinikID=@id";
                    lblDurum.Text = "Poliklinik tamamen silindi.";
                }
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@id", txtPoliklinikID.Text);
                baglanti.Open();
                komut.ExecuteNonQuery();
                PoliklinikleriListele();
                PoliklinikleriGetir();
            }
        }

        protected void gridPoliklinikler_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gridPoliklinikler.SelectedRow;
            txtPoliklinikID.Text = row.Cells[1].Text;
            txtPoliklinikAdi.Text = row.Cells[2].Text;

            Label lblDurum = (Label)row.FindControl("lblDurum");
            if (lblDurum != null)
            {
                chkPoliklinikAktif.Checked = (lblDurum.Text == "Aktif");
            }
        }


        // ==========================================
        //  3. DOKTOR İŞLEMLERİ
        // ==========================================
        void DoktorlariListele()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = @"SELECT D.DoktorID, D.AdSoyad, D.Durum, P.PoliklinikAdi 
                               FROM Doktorlar D
                               LEFT JOIN Poliklinikler P ON D.PoliklinikID = P.PoliklinikID";
                SqlDataAdapter da = new SqlDataAdapter(sql, baglanti);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gridDoktorlar.DataSource = dt;
                gridDoktorlar.DataBind();
            }
        }

        protected void btnDoktorKaydet_Click(object sender, EventArgs e)
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "INSERT INTO Doktorlar (AdSoyad, PoliklinikID, Durum) VALUES (@ad, @pid, @durum)";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@ad", txtDoktorAd.Text);
                komut.Parameters.AddWithValue("@pid", ddlDoktorPoliklinik.SelectedValue);
                komut.Parameters.AddWithValue("@durum", chkDoktorAktif.Checked);
                baglanti.Open();
                komut.ExecuteNonQuery();
                DoktorlariListele();
                lblDurum.Text = "Doktor Eklendi.";
            }
        }

        protected void btnDoktorGuncelle_Click(object sender, EventArgs e)
        {
            if (txtDoktorID.Text == "") return;
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "UPDATE Doktorlar SET AdSoyad=@ad, PoliklinikID=@pid, Durum=@durum WHERE DoktorID=@id";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@ad", txtDoktorAd.Text);
                komut.Parameters.AddWithValue("@pid", ddlDoktorPoliklinik.SelectedValue);
                komut.Parameters.AddWithValue("@durum", chkDoktorAktif.Checked);
                komut.Parameters.AddWithValue("@id", txtDoktorID.Text);
                baglanti.Open();
                komut.ExecuteNonQuery();
                DoktorlariListele();
                lblDurum.Text = "Doktor Güncellendi.";
            }
        }

        protected void btnDoktorTemizle_Click(object sender, EventArgs e)
        {
            txtDoktorID.Text = ""; txtDoktorAd.Text = ""; ddlDoktorPoliklinik.SelectedIndex = 0; chkDoktorAktif.Checked = true;

    
        }

      
        protected void btnDoktorSil_Click(object sender, EventArgs e)
        {
           
            if (txtDoktorID.Text == "") return;
            bool aktifMi = KayitAktifMi("Doktorlar", "DoktorID", txtDoktorID.Text);

            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "";
                if (aktifMi)
                {
                    sql = "UPDATE Doktorlar SET Durum=0 WHERE DoktorID=@id";
                    lblDurum.Text = "Doktor pasife alındı.";
                }
                else
                {
                    sql = "DELETE FROM Doktorlar WHERE DoktorID=@id";
                    lblDurum.Text = "Doktor tamamen silindi.";
                }
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@id", txtDoktorID.Text);
                baglanti.Open();
                komut.ExecuteNonQuery();
                DoktorlariListele();
            }
        }

        protected void gridDoktorlar_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gridDoktorlar.SelectedRow;
            txtDoktorID.Text = row.Cells[1].Text;
            txtDoktorAd.Text = row.Cells[2].Text;
            
            string secilenValue = row.Cells[3].Text.Trim();
            PoliklinikleriGetir();
            int poliklinikID;
            using (SqlConnection baglati =new SqlConnection(baglantiYolu))
            {
                SqlCommand polid = new SqlCommand("SELECT PoliklinikID FROM Poliklinikler WHERE PoliklinikAdi=@p", baglati);
                polid.Parameters.AddWithValue("@p",secilenValue);
                baglati.Open();
                poliklinikID = Convert.ToInt32(polid.ExecuteScalar());
                if (poliklinikID != 0)
                {
                    ddlDoktorPoliklinik.SelectedValue = poliklinikID.ToString();
                }
            }

               


            Label lblDurum = (Label)row.FindControl("lblDurum");
            if (lblDurum != null)
            {
                chkDoktorAktif.Checked = (lblDurum.Text == "Aktif");
            }
        }


        // ==========================================
        //  4. YETKİLENDİRME
        // ==========================================
        void KullanicilariListele()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT ID AS KullaniciID, KullaniciAdi, Rol FROM Kullanicilar", baglanti);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gridKullanicilar.DataSource = dt;
                gridKullanicilar.DataBind();
            }
        }

        protected void btnYetkiKaydet_Click(object sender, EventArgs e)
        {
            if (ddlKullanicilar.SelectedValue == "0" || ddlRoller.SelectedValue == "0") return;
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                string sql = "UPDATE Kullanicilar SET Rol=@rol WHERE ID=@id";
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.AddWithValue("@rol", ddlRoller.SelectedValue);
                komut.Parameters.AddWithValue("@id", ddlKullanicilar.SelectedValue);
                baglanti.Open();
                komut.ExecuteNonQuery();
                KullanicilariListele();
                lblDurum.Text = "Yetki güncellendi.";
            }
        }



        void PoliklinikleriGetir()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
              
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Poliklinikler WHERE Durum=1", baglanti);
                DataTable dt = new DataTable();
                da.Fill(dt);

            
                ddlPoliklinik.DataSource = dt;
                ddlPoliklinik.DataTextField = "PoliklinikAdi";
                ddlPoliklinik.DataValueField = "PoliklinikID";
                ddlPoliklinik.DataBind();
                ddlPoliklinik.Items.Insert(0, new ListItem("Seçiniz...", "0"));

           
                ddlDoktorPoliklinik.DataSource = dt;
                ddlDoktorPoliklinik.DataTextField = "PoliklinikAdi";
                ddlDoktorPoliklinik.DataValueField = "PoliklinikID";
                ddlDoktorPoliklinik.DataBind();
                ddlDoktorPoliklinik.Items.Insert(0, new ListItem("Seçiniz...", "0"));
            }
        }


        protected void ddlPoliklinik_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPoliklinik.SelectedValue != "0")
            {
                using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
                {
                    string sql = "SELECT * FROM Doktorlar WHERE PoliklinikID=@pID AND Durum=1";
                    SqlCommand komut = new SqlCommand(sql, baglanti);
                    komut.Parameters.AddWithValue("@pID", ddlPoliklinik.SelectedValue);
                    SqlDataAdapter da = new SqlDataAdapter(komut);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlDoktor.DataSource = dt;
                    ddlDoktor.DataTextField = "AdSoyad";
                    ddlDoktor.DataValueField = "DoktorID";
                    ddlDoktor.DataBind();
                    ddlDoktor.Items.Insert(0, new ListItem("Seçiniz...", "0"));
                }
            }
            else
            {
                ddlDoktor.Items.Clear();
            }
        }

        void KullanicilariGetir()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiYolu))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT ID, KullaniciAdi FROM Kullanicilar", baglanti);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlKullanicilar.DataSource = dt;
                ddlKullanicilar.DataTextField = "KullaniciAdi";
                ddlKullanicilar.DataValueField = "ID";
                ddlKullanicilar.DataBind();
                ddlKullanicilar.Items.Insert(0, new ListItem("Seçiniz...", "0"));
            }
        }

        protected void txtHastaID_TextChanged(object sender, EventArgs e)
        {

        }


        protected void ddlDoktor_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
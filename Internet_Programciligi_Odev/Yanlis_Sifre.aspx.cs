using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Internet_Programciligi_Odev
{
    public partial class Yanlis_Sifre : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUret_Click(object sender, EventArgs e)
        {
            string karakterler = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@$£{/*+[½#>";

            Random rastgele = new Random();

            string uretilenKod = "";

          
            for (int i = 0; i < 5; i++)
            {
                int index = rastgele.Next(karakterler.Length);
                uretilenKod += karakterler[index];
            }
            txtRandomKod.Text = uretilenKod;
            Session["DogruKod"] = uretilenKod;
            Session["YanlisSifreEkranindanGeldi"] = true;
         
        }
        protected void btnGeriDon_Click(object sender, EventArgs e)
        {           
            Response.Redirect("WebForm1.aspx");
        }
    }
}
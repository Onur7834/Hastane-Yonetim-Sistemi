using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Internet_Programciligi_Odev
{
    public partial class Bekle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            lblKullaniciAdi.Text = Session["Kullanici"].ToString();
            lblRol.Text = Session["Rol"].ToString();
            Response.AddHeader("REFRESH", "3;URL=HastaneOtomasyon.aspx");
        }
    }
}
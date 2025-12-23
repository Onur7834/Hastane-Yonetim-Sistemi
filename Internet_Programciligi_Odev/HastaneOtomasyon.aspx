<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HastaneOtomasyon.aspx.cs" Inherits="Internet_Programciligi_Odev.HastaneOtomasyon" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hastane Yönetim Sistemi</title>
    <style>
        /* GENEL AYARLAR */
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 0; padding: 0; display: flex; height: 100vh; overflow: hidden; }
       
        /* SOL MENÜ (SIDEBAR) */
        .sidebar { width: 250px; background-color: #343a40; color: white; display: flex; flex-direction: column; flex-shrink: 0; }
        .sidebar-header { padding: 20px; text-align: center; background-color: #212529; font-size: 1.2em; font-weight: bold; border-bottom: 1px solid #4b545c; }
        .menu-items { flex-grow: 1; padding-top: 20px; }
        .menu-btn { 
            display: block; width: 100%; padding: 15px 20px; 
            background: none; border: none; color: #c2c7d0; 
            text-align: left; cursor: pointer; font-size: 16px; 
            transition: 0.3s; text-decoration: none; border-left: 4px solid transparent;
        }
        .menu-btn:hover { background-color: #494e53; color: white; border-left-color: #17a2b8; }
        .menu-btn.active { background-color: #007bff; color: white; border-left-color: white; }

        /* SAĞ İÇERİK ALANI */
        .main-content { flex-grow: 1; display: flex; flex-direction: column; overflow-y: auto; }
        
        /* ÜST BAR (TOPBAR) */
        .topbar { 
            background-color: white; padding: 15px 30px; 
            border-bottom: 1px solid #dee2e6; display: flex; 
            justify-content: space-between; align-items: center; 
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .user-info { font-size: 0.9em; color: #555; }
        .user-info span { font-weight: bold; color: #333; }
        .logout-btn { color: #dc3545; text-decoration: none; font-weight: bold; margin-left: 15px; border:none; background:none; cursor:pointer;}
        .logout-btn:hover { text-decoration: underline; }

        /* PANELLER VE FORMLAR */
        .content-area { padding: 30px; }
        .panel-box { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .panel-header { margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #f0f2f5; color: #333; font-size: 1.5em; }

        /* FORM GRUPLARI */
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #666; font-size: 0.9em; }
        .form-control { 
            width: 100%; padding: 10px; border: 1px solid #ced4da; 
            border-radius: 4px; font-size: 14px; transition: 0.2s; 
        }
        .form-control:focus { border-color: #80bdff; outline: 0; box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); }
        .full-width { grid-column: span 2; }

        /* BUTONLAR */
        .action-buttons { margin-top: 20px; border-top: 1px solid #eee; padding-top: 15px; text-align: right; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; color: white; cursor: pointer; font-weight: bold; margin-left: 5px; font-size: 14px; }
        .btn-save { background-color: #28a745; }
        .btn-save:hover { background-color: #218838; }
        .btn-update { background-color: #ffc107; color: #333; }
        .btn-update:hover { background-color: #e0a800; }
        .btn-delete { background-color: #dc3545; }
        .btn-delete:hover { background-color: #c82333; }
        .btn-clear { background-color: #6c757d; }

        /* TABLO (GRIDVIEW) TASARIMI */
        .grid-style { width: 100%; border-collapse: collapse; margin-top: 30px; font-size: 0.9em; }
        .grid-style th { background-color: #343a40; color: white; padding: 12px; text-align: left; }
        .grid-style td { border-bottom: 1px solid #dee2e6; padding: 10px; color: #333; }
        .grid-style tr:nth-child(even) { background-color: #f8f9fa; }
        .grid-style tr:hover { background-color: #e9ecef; cursor: pointer; }
        .grid-selected { background-color: #ffeeba !important; font-weight: bold; }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="display:flex; width:100%;">

        <div class="sidebar">
            <div class="sidebar-header">🏥 Hastane V1.0</div>
            <div class="menu-items">
                <asp:Button ID="btnHastalar" runat="server" Text="😷 Hasta İşlemleri" CssClass="menu-btn" OnClick="btnHastalar_Click" />
                <asp:Button ID="btnPoliklinikler" runat="server" Text="🏥 Poliklinikler" CssClass="menu-btn" OnClick="btnPoliklinikler_Click" />
                <asp:Button ID="btnDoktorlar" runat="server" Text="👨‍⚕️ Doktorlar" CssClass="menu-btn" OnClick="btnDoktorlar_Click" />
                <asp:Button ID="btnYetkilendirme" runat="server" Text="🔒 Yetkilendirme" CssClass="menu-btn" OnClick="btnYetkilendirme_Click" />
            </div>
        </div>

        <div class="main-content">
            
            <div class="topbar">
                <div class="page-title">Yönetim Paneli</div>
                <div class="user-info">
                    Hoşgeldiniz, <asp:Label ID="lblKullanici" runat="server" Text="..."></asp:Label> 
                    <span style="margin:0 10px;">|</span>
                    Yetki: <asp:Label ID="lblRol" runat="server" Text="..."></asp:Label>
                    <asp:LinkButton ID="lnkCikis" runat="server" CssClass="logout-btn" OnClick="lnkCikis_Click">Çıkış Yap</asp:LinkButton>
                </div>
            </div>

            <div class="content-area">
                <asp:Label ID="lblDurum" runat="server" Text="" EnableViewState="false" Font-Bold="true"></asp:Label>

                <asp:Panel ID="pnlHastalar" runat="server" CssClass="panel-box">
                    <div class="panel-header">Hasta Kayıt & Düzenleme</div>
                    
                    <div class="form-grid">
                        <asp:TextBox ID="txtHastaID" runat="server" Visible="false"></asp:TextBox>

                        <div class="form-group">
                            <label>TC Kimlik No</label>
                            <asp:TextBox ID="txtTC" runat="server" CssClass="form-control" MaxLength="11" placeholder="11122233344"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Ad Soyad</label>
                            <asp:TextBox ID="txtHastaAdSoyad" runat="server" CssClass="form-control" placeholder="Örn: Ahmet Yılmaz"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Telefon</label>
                            <asp:TextBox ID="txtTelefon" runat="server" CssClass="form-control" placeholder="05XX XXX XX XX"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Poliklinik Seçimi</label>
                            <asp:DropDownList ID="ddlPoliklinik" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPoliklinik_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label>Doktor Seçimi</label>
                            <asp:DropDownList ID="ddlDoktor" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlDoktor_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="form-group full-width">
                            <label>Şikayet</label>
                            <asp:TextBox ID="txtSikayet" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Hastanın şikayetini giriniz..."></asp:TextBox>
                        </div>
                    </div>

                    <div class="action-buttons">
                        <asp:Button ID="btnHastaTemizle" runat="server" Text="Temizle" CssClass="btn btn-clear" OnClick="btnHastaTemizle_Click" />
                        <asp:Button ID="btnHastaSil" runat="server" Text="Sil" CssClass="btn btn-delete" OnClientClick="return confirm('Silmek istediğine emin misin?');" OnClick="btnHastaSil_Click" />
                        <asp:Button ID="btnHastaGuncelle" runat="server" Text="Güncelle" CssClass="btn btn-update" OnClick="btnHastaGuncelle_Click" />
                        <asp:Button ID="btnHastaKaydet" runat="server" Text="Kaydet" CssClass="btn btn-save" OnClick="btnHastaKaydet_Click" />
                    </div>

                    <asp:GridView ID="gridHastalar" runat="server" CssClass="grid-style" AutoGenerateColumns="False" 
                        DataKeyNames="HastaID" OnSelectedIndexChanged="gridHastalar_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="Seç" ControlStyle-ForeColor="#007bff" />
                            <asp:BoundField DataField="HastaID" HeaderText="ID" />
                            <asp:BoundField DataField="AdSoyad" HeaderText="Ad Soyad" />
                            <asp:BoundField DataField="TCNo" HeaderText="TC No" />
                            <asp:BoundField DataField="PoliklinikAdi" HeaderText="Poliklinik" />
                            <asp:BoundField DataField="DoktorAdi" HeaderText="Doktor" />
                            
                            <asp:TemplateField HeaderText="Durum">
                                <ItemTemplate>
                                    <asp:Label ID="lblDurum" runat="server" 
                                        Text='<%# Convert.ToBoolean(Eval("Durum")) ? "Aktif" : "Pasif" %>' 
                                        ForeColor='<%# Convert.ToBoolean(Eval("Durum")) ? System.Drawing.Color.Green : System.Drawing.Color.Red %>' 
                                        Font-Bold="true">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <SelectedRowStyle CssClass="grid-selected" />
                    </asp:GridView>
                </asp:Panel>


                <asp:Panel ID="pnlPoliklinik" runat="server" CssClass="panel-box" Visible="false">
                    <div class="panel-header">Poliklinik Tanımlama</div>
                    
                    <asp:TextBox ID="txtPoliklinikID" runat="server" Visible="false"></asp:TextBox>

                    <div class="form-grid">
                        <div class="form-group">
                            <label>Poliklinik Adı</label>
                            <asp:TextBox ID="txtPoliklinikAdi" runat="server" CssClass="form-control" placeholder="Örn: Kardiyoloji"></asp:TextBox>
                        </div>
                        <div class="form-group" style="display:flex; align-items:center;">
                            <asp:CheckBox ID="chkPoliklinikAktif" runat="server" Text=" Bu Poliklinik Aktif mi?" Checked="true" style="margin-left:5px;" />
                        </div>
                    </div>

                    <div class="action-buttons">
                        <asp:Button ID="btnPolTemizle" runat="server" Text="Temizle" CssClass="btn btn-clear" OnClick="btnPolTemizle_Click" />
                        <asp:Button ID="btnPolGuncelle" runat="server" Text="Güncelle" CssClass="btn btn-update" OnClick="btnPolGuncelle_Click" />
                        <asp:Button ID="btnPolKaydet" runat="server" Text="Kaydet" CssClass="btn btn-save" OnClick="btnPolKaydet_Click" />
                    </div>

                    <asp:GridView ID="gridPoliklinikler" runat="server" CssClass="grid-style" AutoGenerateColumns="False" 
                        DataKeyNames="PoliklinikID" OnSelectedIndexChanged="gridPoliklinikler_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="Seç" ControlStyle-ForeColor="#007bff" />
                            <asp:BoundField DataField="PoliklinikID" HeaderText="ID" />
                            <asp:BoundField DataField="PoliklinikAdi" HeaderText="Poliklinik Adı" />
                            
                            <asp:TemplateField HeaderText="Durum">
                                <ItemTemplate>
                                    <asp:Label ID="lblDurum" runat="server" 
                                        Text='<%# Convert.ToBoolean(Eval("Durum")) ? "Aktif" : "Pasif" %>' 
                                        ForeColor='<%# Convert.ToBoolean(Eval("Durum")) ? System.Drawing.Color.Green : System.Drawing.Color.Red %>' 
                                        Font-Bold="true">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <SelectedRowStyle CssClass="grid-selected" />
                    </asp:GridView>
                </asp:Panel>


                <asp:Panel ID="pnlDoktor" runat="server" CssClass="panel-box" Visible="false">
                    <div class="panel-header">Doktor Tanımlama</div>

                    <asp:TextBox ID="txtDoktorID" runat="server" Visible="false"></asp:TextBox>

                    <div class="form-grid">
                        <div class="form-group">
                            <label>Doktor Adı Soyadı</label>
                            <asp:TextBox ID="txtDoktorAd" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Bağlı Olduğu Poliklinik</label>
                            <asp:DropDownList ID="ddlDoktorPoliklinik" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label>Durum</label><br />
                            <asp:CheckBox ID="chkDoktorAktif" runat="server" Text=" Doktor şu an görevde mi?" Checked="true" />
                        </div>
                    </div>

                    <div class="action-buttons">
                        <asp:Button ID="btnDoktorTemizle" runat="server" Text="Temizle" CssClass="btn btn-clear" OnClick="btnDoktorTemizle_Click" />
                        <asp:Button ID="btnDoktorGuncelle" runat="server" Text="Güncelle" CssClass="btn btn-update" OnClick="btnDoktorGuncelle_Click" />
                        <asp:Button ID="btnDoktorKaydet" runat="server" Text="Kaydet" CssClass="btn btn-save" OnClick="btnDoktorKaydet_Click" />
                    </div>
                    
                    <asp:GridView ID="gridDoktorlar" runat="server" CssClass="grid-style" AutoGenerateColumns="False" 
                        DataKeyNames="DoktorID" OnSelectedIndexChanged="gridDoktorlar_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="Seç" ControlStyle-ForeColor="#007bff" />
                            <asp:BoundField DataField="DoktorID" HeaderText="ID" />
                            <asp:BoundField DataField="AdSoyad" HeaderText="Doktor Adı" />
                            <asp:BoundField DataField="PoliklinikAdi" HeaderText="Bölümü" />
                            
                            <asp:TemplateField HeaderText="Durum">
                                <ItemTemplate>
                                    <asp:Label ID="lblDurum" runat="server" 
                                        Text='<%# Convert.ToBoolean(Eval("Durum")) ? "Aktif" : "Pasif" %>' 
                                        ForeColor='<%# Convert.ToBoolean(Eval("Durum")) ? System.Drawing.Color.Green : System.Drawing.Color.Red %>' 
                                        Font-Bold="true">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <SelectedRowStyle CssClass="grid-selected" />
                    </asp:GridView>
                </asp:Panel>


                <asp:Panel ID="pnlYetki" runat="server" CssClass="panel-box" Visible="false">
                    <div class="panel-header">Kullanıcı Rol Yönetimi</div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label>Kullanıcı Seçiniz</label>
                            <asp:DropDownList ID="ddlKullanicilar" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label>Yeni Rol Atayınız</label>
                            <asp:DropDownList ID="ddlRoller" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">Seçiniz...</asp:ListItem>
                                <asp:ListItem Value="Admin">Yönetici (Admin)</asp:ListItem>
                                <asp:ListItem Value="Orta">Personel (Orta Yetki)</asp:ListItem>
                                <asp:ListItem Value="Kullanici">Standart Kullanıcı</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="action-buttons">
                        <asp:Button ID="btnYetkiKaydet" runat="server" Text="Yetkiyi Güncelle" CssClass="btn btn-update" OnClick="btnYetkiKaydet_Click" />
                    </div>

                    <asp:GridView ID="gridKullanicilar" runat="server" CssClass="grid-style" AutoGenerateColumns="False" DataKeyNames="KullaniciID">
                        <Columns>
                            <asp:BoundField DataField="KullaniciID" HeaderText="ID" />
                            <asp:BoundField DataField="KullaniciAdi" HeaderText="Kullanıcı Adı" />
                            <asp:BoundField DataField="Rol" HeaderText="Mevcut Yetki" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>

            </div>
        </div>
    </form>
</body>
</html>
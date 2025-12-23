<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SifremiUnuttum.aspx.cs" Inherits="Internet_Programciligi_Odev.SifremiUnuttum" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Şifre Yenileme</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f6; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .reset-container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        .input-field { width: 100%; margin-bottom: 15px; padding: 12px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        .action-button { width: 100%; padding: 12px; background-color: #007bff; border: none; color: white; border-radius: 5px; cursor: pointer; font-weight: bold; margin-bottom: 10px;}
        .action-button:hover { background-color: #0056b3; }
        .question-label { display: block; text-align: left; margin-bottom: 5px; font-weight: bold; color: #555; }
        .error-msg { color: red; font-size: 0.9em; margin-bottom: 10px; display: block; }
        .success-msg { color: green; font-size: 0.9em; margin-bottom: 10px; display: block; }
        .back-link { display: inline-block; margin-top: 10px; color: #6c757d; text-decoration: none; font-size: 0.9em; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="reset-container">
            <h3>Şifre Yenileme</h3>
            <asp:Label ID="lblMesaj" runat="server" Text="" EnableViewState="false"></asp:Label>

            <asp:Panel ID="pnlKullaniciSorgu" runat="server">
                <p style="color:#666; font-size:0.9em;">Lütfen şifresini yenilemek istediğiniz kullanıcı adını giriniz.</p>
                <asp:TextBox ID="txtKullaniciAdi" runat="server" CssClass="input-field" placeholder="Kullanıcı Adı"></asp:TextBox>
                <asp:Button ID="btnSorgula" runat="server" Text="Güvenlik Sorusunu Getir" CssClass="action-button" OnClick="btnSorgula_Click" />
            </asp:Panel>

            <asp:Panel ID="pnlSifreDegistir" runat="server" Visible="false">
                <div style="background-color: #e9ecef; padding: 10px; border-radius: 5px; margin-bottom: 15px; text-align: left;">
                    <span style="font-size: 0.8em; color: #888;">Güvenlik Sorusu:</span><br />
                    <asp:Label ID="lblSoru" runat="server" Text="..." style="font-weight: bold; color: #333;"></asp:Label>
                </div>

                <asp:TextBox ID="txtGuvenlikCevap" runat="server" CssClass="input-field" placeholder="Cevabınız"></asp:TextBox>
                <asp:TextBox ID="txtYeniSifre" runat="server" CssClass="input-field" TextMode="Password" placeholder="Yeni Şifre"></asp:TextBox>
                
                <asp:Button ID="btnDegistir" runat="server" Text="Şifreyi Güncelle" CssClass="action-button" style="background-color: #28a745;" OnClick="btnDegistir_Click" />
            </asp:Panel>

            <a href="WebForm1.aspx" class="back-link">← Giriş Ekranına Dön</a>
        </div>
    </form>
</body>
</html>

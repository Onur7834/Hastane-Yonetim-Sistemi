<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bekle.aspx.cs" Inherits="Internet_Programciligi_Odev.Bekle" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Giriş Başarılı</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #e9ecef; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .welcome-card { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; border-top: 8px solid #28a745; width: 400px; }
        .success-title { color: #28a745; font-size: 2.5em; font-weight: bold; margin-bottom: 20px; display: block; }
        .info-label { display: block; font-size: 1.2em; color: #495057; margin: 10px 0; }
        .info-value { font-weight: bold; color: #212529; }
        .divider { height: 1px; background: #dee2e6; margin: 20px 0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="welcome-card">
            <asp:Label ID="lblBaslik" runat="server" Text="Giriş Başarılı Veriler Yükleniyor Birkaç Saniye Bekleyiniz" CssClass="success-title"></asp:Label>
            
            <div class="divider"></div>

            <div class="info-label">
                Hoş Geldiniz, <asp:Label ID="lblKullaniciAdi" runat="server" CssClass="info-value"></asp:Label>
            </div>

            <div class="info-label">
                Yetki Rolünüz: <asp:Label ID="lblRol" runat="server" CssClass="info-value"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
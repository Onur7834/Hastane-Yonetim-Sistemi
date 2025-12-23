<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Yanlis_Sifre.aspx.cs" Inherits="Internet_Programciligi_Odev.Yanlis_Sifre" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Güvenlik Kodu Oluştur</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #fff3cd; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.2); text-align: center; width: 350px; border: 2px solid #ffc107; }
        .title { color: #856404; margin-bottom: 20px; font-size: 1.2em; font-weight: bold; }
        .input-code { width: 100%; padding: 15px; font-size: 1.5em; text-align: center; font-family: monospace; letter-spacing: 5px; border: 1px solid #ced4da; border-radius: 5px; margin-bottom: 20px; background-color: #f8f9fa; color: #333; }
        .generate-button { background-color: #ffc107; color: #000; border: none; padding: 12px 25px; border-radius: 5px; cursor: pointer; font-weight: bold; width: 100%; }
        .generate-button:hover { background-color: #e0a800; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="title">Çok Fazla Hatalı Giriş Yapıldı!</div>
            <p style="font-size: 0.9em; color: #666;">Lütfen aşağıdaki butona basarak 5 haneli doğrulama kodunuzu alın:</p>
            
            <asp:TextBox ID="txtRandomKod" runat="server" CssClass="input-code" ReadOnly="true" placeholder="-----"></asp:TextBox>
            
            <asp:Button ID="btnUret" runat="server" Text="Yeni Kod Üret" CssClass="generate-button" OnClick="btnUret_Click" />

        </div>
        <div style="margin-top: 15px;">
    <asp:LinkButton ID="btnGeriDon" runat="server" Text="Giriş Ekranına Geri Dön" OnClick="btnGeriDon_Click" style="color: #856404; text-decoration: none; font-size: 0.9em; font-weight: bold;"></asp:LinkButton>
</div>
    </form>
</body>
</html>
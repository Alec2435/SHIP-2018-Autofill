<%@ Page Title="Search"Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SHIPAutofill.CompletionPage" MasterPageFile="~/Site.Master" %>
<%@ Register Assembly="AjaxControlToolkit"  Namespace="AjaxControlToolkit" TagPrefix="ajaxTookit" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="MainContent">

    <style>
        .padding {padding:.5em; font-family:HelvLight; font-size:18px; width:500px;min-width:400px;}
        .padding:focus{ outline: none;}
        .SubmitButton{min-width:65px;}
        .SubmitButton:focus{outline: none;}
        .drop{
            font-family:HelvLight;
            background-color:white;
            font-size:14px;
            padding-bottom:.5em;
        }
        .drop_highlight{
            background-color:#5381cc;
            color:white;
            font-family:HelvLight;
            padding-bottom:.5em;
            font-size:14px;
        }
    </style>


    <div aria-orientation="vertical" style="height: 60%; text-align: center; margin: 0 auto; clip: rect(auto, 0px, auto, auto);">
        <h1>Autofill Box</h1>
                <asp:DropDownList ID="ddldb" runat="server" OnChange="$find('SearchText').set_contextKey(this.value);" style="margin-bottom:10px;" AppendDataBoundItems="true">
                </asp:DropDownList>
                <div style="position: relative; top: 50%; display:inline-flex; display: block; padding-bottom: 20vh;">
                    <asp:TextBox ID="SearchText" runat="server" spellcheck="true" TextMode="MultiLine" CssClass="padding" AutoPostback="False" OnClick="searchText_click()" Style ="display: inline; Width:90%;box-sizing:border-box; " onkeyup = "SetContextKey()" placeholder="Type and the system will suggest..."></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender 
                        runat="server" 
                        ID="autoComplete1" 
                        TargetControlID="SearchText"
                        ServiceMethod="GetCompletionList"
                        ServicePath="AutoComplete.asmx"
                        MinimumPrefixLength="1" 
                        CompletionInterval="250"
                        OnClientItemSelected="autoCompleteEx_ItemSelected"
                        EnableCaching="true"
                        useContextKey="true"
                        DelimiterCharacters=".,!?"
                        CompletionSetCount="10"                   
                        ShowOnlyCurrentWordInCompletionListItem="true" CompletionListItemCssClass="drop" CompletionListHighlightedItemCssClass="drop_highlight" >
                    </ajaxToolkit:AutoCompleteExtender>

                </div>
          <h1>Text Area</h1>
                <div style="position: relative; top: 50%; display:inline-flex; display: block; margin-bottom:10px;">
                    <asp:TextBox ID="TextBox1" runat="server" spellcheck="true" CssClass="padding" TextMode="MultiLine" AutoPostback="False" OnClick="searchText_click()" Style ="display: inline; Width:90%;box-sizing:border-box;  Height:40vh;"></asp:TextBox>


                </div>
            
        <button type="button" class="btn btn-default btn-lg" id="save">Save</button>
        <button type="button" class="btn btn-default btn-lg" id="Copy" onclick="copy()">Copy</button>

            </div>
    <script type="text/javascript">
        // Listen for the event.
      //  document.getElementById("autoComplete1").addEventListener('itemSelected', function (e) {
          //  var txtVal = $('#MainContent_TextBox1').val() + $('#MainContent_SearchText').val();
         //   console.log(txtVal);
        //      $('#MainContent_TextBox1').val(txtVal);
     //   }, false);
         function autoCompleteEx_ItemSelected(sender, args) {
               var n1 = document.getElementById('MainContent_SearchText');
               var n2 = document.getElementById('MainContent_TextBox1');
             n2.value = n2.value + n1.value;
             n1.value = "";
             console.log("I Ran!!!");
        }
        function download(data, filename, type) {
            var file = new Blob([data], {type: type});
            if (window.navigator.msSaveOrOpenBlob) // IE10+
                window.navigator.msSaveOrOpenBlob(file, filename);
            else { // Others
                var a = document.createElement("a"),
                        url = URL.createObjectURL(file);
                a.href = url;
                a.download = filename;
                document.body.appendChild(a);
                a.click();
                setTimeout(function() {
                    document.body.removeChild(a);
                    window.URL.revokeObjectURL(url);  
                }, 0); 
            }
        }
        function copy() {
            var copyText = document.getElementById("MainContent_TextBox1");
            copyText.select();
            document.execCommand("copy");
        }
        $(document).ready(function() {
            $("#save").click(function () {
                 var n2 = document.getElementById('MainContent_TextBox1');
                download(n2.value, "Typed_Text.txt", "txt");
    }); 
});
    </script>
    <script type = "text/javascript">
    function SetContextKey() {
        $find('<%=autoComplete1.ClientID%>').set_contextKey($get("<%=ddldb.ClientID %>").value);
        }
        $(".btn").click(function(){
    $("button").addClass("active");
    $(".rest").addClass("active");
    $(".icon").addClass("active");
});
</script>
</asp:Content>



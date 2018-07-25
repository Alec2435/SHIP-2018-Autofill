﻿<%@ Page Title="Search"Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SHIPAutofill.CompletionPage" MasterPageFile="~/Site.Master" %>
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
        .alert {
            padding: 20px;
            background-color: #ff9800;
            color: white;
            align-items: center;
            justify-content: center;
        }

    .closebtn {
        margin-left: 15px;
        color: white;
        font-weight: bold;
        float: right;
        font-size: 22px;
        line-height: 20px;
        cursor: pointer;
    transition: 0.3s;
    }

    .closebtn:hover {
        color: black;
    }
    .closeall{
        color: white;
        float: right;
        cursor: pointer;
        background-color: red;
        text-align: center;
        position:relative;
        top:50%;
    }
    </style>


    <div ID="maindiv" aria-orientation="vertical" style="height: 60%; text-align: center; margin: 0 auto; clip: rect(auto, 0px, auto, auto);">
        <h1>Autofill Box</h1>
            <asp:DropDownList ID="ddldb" runat="server" OnChange="$find('SearchText').set_contextKey(this.value);" style="margin-bottom:10px;" AppendDataBoundItems="true">
                </asp:DropDownList>
                <asp:CheckBox ID="TaxonomyCheckbox" runat="server" OnCheckedChanged="CheckBox1_CheckedChanged" Text="Taxonomic Search" ToolTip="Add result as a taxonomic search term instead of adding it to the text box" />
                <div style="position: relative; top: 50%; display:inline-flex; display: block; padding-bottom: 20vh;">
                    <asp:TextBox ID="SearchText" runat="server" spellcheck="true" TextMode="MultiLine" CssClass="padding" AutoPostback="False" Style ="display: inline; box-sizing:border-box; " onkeyup = "SetContextKey()" placeholder="Type and the system will suggest..." Width="1090px"></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender 
                        runat="server" 
                        ID="autoComplete1" 
                        TargetControlID="SearchText"
                        ServiceMethod="GetCompletionList"
                        ServicePath="AutoComplete.asmx"
                        MinimumPrefixLength="1" 
                        CompletionInterval="100"
                        OnClientItemSelected="autoCompleteEx_ItemSelected"
                        EnableCaching="false"
                        useContextKey="true"
                        DelimiterCharacters=".,!?"
                        CompletionSetCount="10"                   
                        ShowOnlyCurrentWordInCompletionListItem="true" CompletionListItemCssClass="drop" CompletionListHighlightedItemCssClass="drop_highlight" >
                    </ajaxToolkit:AutoCompleteExtender>

                </div>
          <h1>Text Area</h1>
                <div style="position: relative; top: 50%; display:inline-flex; display: block; margin-bottom:10px;">
                    <asp:TextBox ID="TextBox1" runat="server" spellcheck="true" CssClass="padding" TextMode="MultiLine" AutoPostback="False"  Style ="display: inline; Width:90%;box-sizing:border-box;  Height:40vh;"></asp:TextBox>


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
        var taxValues = [];
        function autoCompleteEx_ItemSelected(sender, args) {
            if (!document.getElementById('MainContent_TaxonomyCheckbox').checked) {
                var n1 = document.getElementById('MainContent_SearchText');
                var n2 = document.getElementById('MainContent_TextBox1');

                n2.value = n2.value + n1.value;
                n1.value = "";
            } else {
                taxValues.push(document.getElementById('MainContent_SearchText').value);
                SetContextKey();
                if (taxValues.length >= 3) {
                    document.getElementById('MainContent_TaxonomyCheckbox').checked = false;
                    document.getElementById('MainContent_TaxonomyCheckbox').disabled = true;
                }
                var alertBoxLast = "<div id='tax" +(taxValues.length-1)+ "' class=\"alert\"><span class=\"closebtn\" onclick=updateAlerts()>&times;</span> <strong>Taxonomy:</strong> " + document.getElementById('MainContent_SearchText').value + "<button type=\"button\" class=\"btn btn-default closeall\" onclick=closeAllAlerts() id='"+(taxValues.length-1)+"-btn'>Close all</button></div>";
                $('#MainContent_ddldb').before(alertBoxLast);
                for (var i = taxValues.length - 2; i >= 0; i--) {
                    document.getElementById('tax' + i).outerHTML = "<div id='tax"+ i+"' class=\"alert\"><strong>Taxonomy:</strong> " + taxValues[i] + "</div>";
                }
                document.getElementById('MainContent_SearchText').value = "";

            }
             

        }
        function closeAllAlerts() {
            document.getElementById('MainContent_TaxonomyCheckbox').disabled = false;
            for (var i = 0;i< taxValues.length; i++) {
                    document.getElementById('tax' + i).parentNode.removeChild(document.getElementById('tax' + i));
            }
            taxValues = [];
        }
        function updateAlerts() {
            document.getElementById('MainContent_TaxonomyCheckbox').disabled = false;
            document.getElementById('tax' + (taxValues.length - 1)).parentNode.removeChild(document.getElementById('tax' + (taxValues.length - 1)));
            taxValues.pop();
            if (taxValues.length < 1) {
                return;
            }
            document.getElementById('tax' + (taxValues.length - 1)).outerHTML = "<div id='tax" + (taxValues.length - 1) + "' class=\"alert\"><span class=\"closebtn\" onclick=updateAlerts()>&times;</span><button type=\"button\" onclick=closeAllAlerts() class=\"btn btn-default closeall\" id='"+(taxValues.length-1)+"-btn'>Close all</button><strong>Taxonomy:</strong> " + taxValues[taxValues.length-1] + "</div>";
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
        $find('<%=autoComplete1.ClientID%>').set_contextKey($get("<%=ddldb.ClientID %>").value+"*"+taxValues.join("*"));
    }


    $(".btn").click(function(){
        $("button").addClass("active");
        $(".rest").addClass("active");
        $(".icon").addClass("active");
});
</script>
</asp:Content>



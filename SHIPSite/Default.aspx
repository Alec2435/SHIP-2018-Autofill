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
                <div style="position: relative; top: 50%; display:inline-flex">
                    <asp:TextBox ID="SearchText" runat="server" spellcheck="true" CssClass="padding" TextMode="MultiLine" AutoPostback="False" OnClick="searchText_click()" Style ="display: inline; Width:90vw; Height:80vh;">Search...</asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender 
                        runat="server" 
                        ID="autoComplete1" 
                        TargetControlID="SearchText"
                        ServiceMethod="GetCompletionList"
                        ServicePath="AutoComplete.asmx"
                        MinimumPrefixLength="1" 
                        CompletionInterval="250"
                        EnableCaching="true"
                        CompletionSetCount="10"                   
                        ShowOnlyCurrentWordInCompletionListItem="true" CompletionListItemCssClass="drop" CompletionListHighlightedItemCssClass="drop_highlight" >
                    </ajaxToolkit:AutoCompleteExtender>

                </div>
            </div>

</asp:Content>



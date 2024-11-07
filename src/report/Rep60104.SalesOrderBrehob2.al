report 60104 "Sales Order Brehob 2"
{
    ApplicationArea = All;
    Caption = 'Sales Order Confirmation';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/report/Layout/SalesOrderBH.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(SHNo; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(Logo; CompInfo.Picture)
                    {
                    }
                    column(CompAddr1; CompAddr[1])
                    {
                    }
                    column(CompAddr2; CompAddr[2])
                    {
                    }
                    column(CompAddr3; CompAddr[3])
                    {
                    }
                    column(CompAddr4; CompAddr[4])
                    {
                    }
                    column(CompAddr5; CompAddr[5])
                    {
                    }
                    column(CompAddr6; CompAddr[6])
                    {
                    }
                    column(CompAddr7; CompAddr[7])
                    {
                    }
                    column(CompAddr8; CompAddr[8])
                    {
                    }
                    column(CompAddr9; CompAddr[9])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(SellToAddr1; SellToAddr[1])
                    {
                    }
                    column(SellToAddr2; SellToAddr[2])
                    {
                    }
                    column(SellToAddr3; SellToAddr[3])
                    {
                    }
                    column(SellToAddr4; SellToAddr[4])
                    {
                    }
                    column(SellToAddr5; SellToAddr[5])
                    {
                    }
                    column(SellToAddr6; SellToAddr[6])
                    {
                    }
                    column(SellToAddr7; SellToAddr[7])
                    {
                    }
                    column(SellToAddr8; SellToAddr[8])
                    {
                    }
                    column(SHExpShipDt; "Sales Header"."Shipment Date")
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(SHSellToCustNo; "Sales Header"."Sell-to Customer No.")
                    {
                    }
                    column(SHExtDocNo; "Sales Header"."External Document No.")
                    {
                    }
                    column(SalesPersName; SalesPurchPerson.Name)
                    {
                    }
                    column(SHOrdDate; "Sales Header"."Order Date")
                    {
                    }
                    column(ShipmentMethDesc; ShipmentMethod.Description)
                    {
                    }
                    column(ShipAgentName; ShipAgent.Name)
                    {
                    }
                    column(ShipAgentAcctNo; ShipAgent."Account No.")
                    {
                    }
                    //column(FrtTermsDesc; FrtTerms.Description) { }
                    column(PayTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(EnteredBy; "Sales Header"."Assigned User ID")
                    {
                    }
                    dataitem(SalesLine; "Sales Line") //SalesLine
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));

                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(ItemNumberToPrint; ItemNumberToPrint)
                        {
                        }
                        column(ItemRefNo; "Item Reference No.")
                        {
                        }
                        column(PLUOM; "Unit of Measure")
                        {
                        }
                        column(PLQty; Quantity)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(OLDesc; Description)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        trigger OnPreDataItem() //SalesLine
                        begin
                            Clear(AmountExclInvDisc);
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;

                        trigger OnAfterGetRecord() //SalesLine
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            ItemNumberToPrint := "No.";
                            If "Item Reference No." <> '' then ItemRefNo := "Item Reference No.";
                            if Type = Type::" " then begin
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                "Line Amount" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            end;
                            AmountExclInvDisc := "Line Amount";
                            if Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / Quantity, 0.00001);
                            if OnLineNumber = NumberOfLines then begin
                                PrintFooter := true;
                            end;
                        end;
                    }
                }
                trigger OnPreDataItem() //CopyLoop
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then NoLoops := 1;
                    CopyNo := 0;
                end;

                trigger OnAfterGetRecord() //CopyLoop
                begin
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then SalesPrinted.Run("Sales Header");
                        CurrReport.Break();
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;
            }
            trigger OnAfterGetRecord() //Sales Header
            begin
                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompAddr, RespCenter);
                        //CompInfo."Phone No." := RespCenter."Phone No.";
                        //CompInfo."Fax No." := RespCenter."Fax No.";
                    end;
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                IF "Shipping Agent Code" = '' then
                    clear(ShipAgent)
                else
                    ShipAgent.get("Shipping Agent Code");
                FormatAddress.SalesHeaderSellTo(SellToAddr, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddr, ShipToAddr, "Sales Header");
                if not CurrReport.Preview then begin
                    if ArchiveDocument then ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);
                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", '', "Posting Description", '');
                    end;
                end;
                if "Posting Date" <> 0D then
                    UseDate := "Posting Date"
                else
                    UseDate := WorkDate();
            end;

            trigger OnPreDataItem() //Sales Header Header
            begin
                if PrintCompany then begin
                    FormatAddress.Company(CompAddr, CompInfo);
                    CompInfo.calcfields(Picture);
                end
                else
                    Clear(CompAddr);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NumberOfCopies; NoCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                        ToolTip = 'Specifies the number of copies of each sales order, in addition to the original, that you want to print.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                        ToolTip = 'Specifies if you are printing on plain paper or if your company address is not pre-printed on your forms. If you do not select this field, the report will omit your company''s address.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;
                        ToolTip = 'Specifies if the document is archived when you run the report.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if the interaction with the vendor is logged when ,you run the report.';

                        trigger OnValidate()
                        begin
                            if LogInteraction then ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit() //Request Page
        begin
            LogInteractionEnable := true;
            ArchiveDocumentEnable := true;
        end;

        trigger OnOpenPage() //Request Page
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule();
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Ord. Cnfrmn.") <> '';
            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
        LblTitle = 'SALES ORDER';
        LblSONo = 'Order No.';
        LblDate = 'Order Date';
        LblPage = 'Page:';
        LblSellTo = 'Sell To';
        LblShipTo = 'Ship To';
        LblShipDate = 'Shipment Date';
        LblSalesPerson = 'Salesperson';
        LblSentVia = 'Sent Via';
        LblTerms = 'Terms';
        LblShipVia = 'Ship Via';
        LblFOB = 'FOB';
        LblOurItem = 'Our Item No.';
        LblYourItem = 'Your Item No.';
        LblDesc = 'Description';
        LblQty = 'Quantity';
        LblUOM = 'UOM';
        LblUnitPr = 'Unit Price';
        LblExtPr = 'Ext. Price';
        LblTotal = 'Total';
        LblShipAcctNo = 'Ship Via Acct. No.';
        LblCustPO = 'Customer P.O. No.';
        LblEnteredBy = 'Entered By';
        //LblLegal1 = 'None of the terms, prices and conditions in this purchase order may be added to, modified';
        //LblLegal2 = 'or otherwise altered, except by written agreement between seller and buyer.';
        //LblLegal3 = 'Seller shall comply with the EEO clause in Section 202 of Executive Order 11246, as amended,';
        //LblLegal4 = '41 CFR 60-250 and 41 CFR 60-741, as amended, which are incorporated.';
    }
    trigger OnPreReport() //Report
    begin
        CompInfo.Get;
    end;

    var
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        ShipAgent: record "Shipping Agent";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompInfo: Record "Company Information";
        RespCenter: record "Responsibility Center";
        CompAddr: array[9] of Text[100];
        SellToAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[50];
        ItemRefNo: text[50];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        SalesPrinted: Codeunit "Sales-Printed";
        FormatAddress: Codeunit "Format Address 2";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        UseDate: Date;
        Text000: Label 'COPY';
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
}

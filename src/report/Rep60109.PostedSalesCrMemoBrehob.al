report 60109 "Posted Sales Cr. Memo Brehob"
{
    ApplicationArea = All;
    Caption = 'Sales Credit Memo';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './Local/PostedSalesCrMemoBH.rdlc';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(SalesCrMemoNo; "No.")
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
                    column(BillToAddr1; BillToAddr[1])
                    {
                    }
                    column(BillToAddr2; BillToAddr[2])
                    {
                    }
                    column(BillToAddr3; BillToAddr[3])
                    {
                    }
                    column(BillToAddr4; BillToAddr[4])
                    {
                    }
                    column(BillToAddr5; BillToAddr[5])
                    {
                    }
                    column(BillToAddr6; BillToAddr[6])
                    {
                    }
                    column(BillToAddr7; BillToAddr[7])
                    {
                    }
                    column(BillToAddr8; BillToAddr[8])
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
                    column(ExpShipDt; "Sales Cr.Memo Header"."Shipment Date")
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
                    column(SHSellToCustNo; "Sales Cr.Memo Header"."Sell-to Customer No.")
                    {
                    }
                    column(ExtDocNo; "Sales Cr.Memo Header"."External Document No.")
                    {
                    }
                    column(PurchPersName; SalesPurchPerson.Name)
                    {
                    }
                    column(SHDocDate; "Sales Cr.Memo Header"."Document Date")
                    {
                    }
                    column(PostingDate; "Sales Cr.Memo Header"."Posting Date")
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
                    column(BillToCustNo; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(JobNo; "Sales Cr.Memo Header"."Job No.")
                    {
                    }
                    column(OrderNo; "Sales Cr.Memo Header"."Pre-Assigned No.")
                    {
                    }
                    /*
                    column(SQQuoteEndDate; "Sales Cr.Memo Header"."Quote Valid Until Date")
                    {
                    }
                    column(EnteredBy; "Sales Cr.Memo Header"."Assigned User ID")
                    {
                    }
                    */
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

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
                        column(FrtAmt; FrtAmt)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(Subtotal; Subtotal)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(OLDesc; Description)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(IsFreight; Freight)
                        {
                        }
                        trigger OnPreDataItem() //PurchLine
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
                            If Freight then FrtAmt := FrtAmt + "Line Amount";
                            If Freight = false then Subtotal += AmountExclInvDisc;
                            TaxAmount := "Amount Including VAT" - Amount;
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
                        if not CurrReport.Preview then SalesCrMemoPrinted.Run("Sales Cr.Memo Header");
                        CurrReport.Break();
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;
            }
            trigger OnAfterGetRecord() //Purchase Header
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
                FormatAddress.SalesCrMemoSellTo(SellToAddr, "Sales Cr.Memo Header");
                FormatAddress.SalesCrMemoShipTo(ShipToAddr, ShipToAddr, "Sales Cr.Memo Header");
                Clear("Bill-to Contact");
                FormatAddress.SalesCrMemoBillTo(BillToAddr, "Sales Cr.Memo Header");
                if not CurrReport.Preview then begin
                    if LogInteraction then begin
                        SegManagement.LogDocument(6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                    end;
                end;
                if "Posting Date" <> 0D then
                    UseDate := "Posting Date"
                else
                    UseDate := WorkDate();
            end;

            trigger OnPreDataItem() //Purchase Header
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
                        ToolTip = 'Specifies the number of copies of each sales quote, in addition to the original, that you want to print.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                        ToolTip = 'Specifies if you are printing on plain paper or if your company address is not pre-printed on your forms. If you do not select this field, the report will omit your company''s address.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if the interaction with the vendor is logged when ,you run the report.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit() //Request Page
        begin
            PrintCompany := true;
            LogInteractionEnable := false;
        end;

        trigger OnOpenPage() //Request Page
        begin
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Cr. Memo") <> '';
            LogInteractionEnable := LogInteraction;
            LogInteraction := false;
        end;
    }
    labels
    {
        LblTitle = 'SALES CREDIT MEMO';
        LblSCMNo = 'Credit Memo No.';
        LblDate = 'Cr. Memo Date';
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
        LblLegal1 = 'Acceptance of Brehob''s products or services shall be deemed to constitute an agreement on th part of the Buyer to the terms and conditions set forth on the reverse side of this document which';
        LblLegal2 = 'supersede all previous agreements. The terms and conditions stated herein shall take precedence over any other conditions and no contrary, additional or differnt conditions shall be binding on Brehob';
        LblLegal3 = 'unless accepted by Brehob in writing.';
        LblLegal4 = 'Past due invoice are subject to a service charge of 1.5% per month. Our permission must be obtained before rerturning merchandise to us.';
        LblFrtChrg = 'Freight Charge';
        LblTax = 'Sales Tax';
        LblQtEndDate = 'Quote Expiration Date';
        LblSubtotal = 'Subtotal';
        LblCustPO = 'Customer P.O. No.';
        LblEnteredBy = 'Entered By';
        LblCustNo = 'Customer No.';
        LblCustCode = 'Cust. Code';
        LblOrdNo = 'Order No.';
        LblJobNo = 'Project No.';
        LblBillTo = 'Bill To';
        LblFreightTotal = 'Freight Total';
        LblRemitTo = 'Remit to:';
        LblRemit1 = 'P.O. Box 2023';
        LblRemit2 = 'Indianapolis, IN 46206-2023';
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
        BillToAddr: array[8] of Text[100];
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
        SalesCrMemoPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddress: Codeunit "Format Address 2";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        UseDate: Date;
        Text000: Label 'COPY';
        LogInteractionEnable: Boolean;
        FrtAmt: decimal;
        TaxAmount: decimal;
        Subtotal: decimal;
}

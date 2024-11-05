report 60106 "Sales Invoice Brehob 2"
{
    ApplicationArea = All;
    Caption = 'Sales Invoice';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './Local/SalesInvoiceBH.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(SIHNo; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

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
                    column(SIHExpShipDt; "Sales Invoice Header"."Shipment Date")
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
                    column(SIHSellToCustNo; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(SIHExtDocNo; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(PurchPersName; SalesPurchPerson.Name)
                    {
                    }
                    column(SIHInvDate; "Sales Invoice Header"."Document Date")
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
                    column(JobNo; "Sales Invoice Header"."Job No.")
                    {
                    }
                    column(CompDate; "Sales Invoice Header"."Completion Date")
                    {
                    }
                    column(OrderNo; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(BillToCustNo; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(HideQtyUOM; HideQtyUOM)
                    {
                    }
                    dataitem(SalesInvLine; "Sales Invoice Line") //SalesInvLine
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemLink = "Document No."=FIELD("No.");
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
                        Column(Type; Type)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                        DecimalPlaces = 2: 5;
                        }
                        column(FrtAmt; FrtAmt)
                        {
                        DecimalPlaces = 2: 5;
                        }
                        column(Subtotal; Subtotal)
                        {
                        DecimalPlaces = 2: 5;
                        }
                        column(OLDesc; Description)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        DecimalPlaces = 2: 5;
                        }
                        column(IsFreight; Freight)
                        {
                        }
                        trigger OnPreDataItem() //SalesInvLine
                        begin
                            Clear(AmountExclInvDisc);
                            NumberOfLines:=Count;
                            OnLineNumber:=0;
                            PrintFooter:=false;
                        end;
                        trigger OnAfterGetRecord() //SalesInvLine
                        begin
                            //IF "Amount Including VAT" = 0 then
                            //    CurrReport.skip;
                            OnLineNumber:=OnLineNumber + 1;
                            ItemNumberToPrint:="No.";
                            If "Item Reference No." <> '' then ItemRefNo:="Item Reference No.";
                            if Type = Type::" " then begin
                                ItemNumberToPrint:='';
                                "Unit of Measure":='';
                                "Line Amount":=0;
                                "Inv. Discount Amount":=0;
                                Quantity:=0;
                            end;
                            AmountExclInvDisc:="Line Amount";
                            If Freight then FrtAmt:=FrtAmt + "Line Amount";
                            If Freight = false then Subtotal+=AmountExclInvDisc;
                            TaxAmount:="Amount Including VAT" - Amount;
                            if Quantity = 0 then UnitPriceToPrint:=0 // so it won't print
                            else
                                UnitPriceToPrint:=Round(AmountExclInvDisc / Quantity, 0.00001);
                            if OnLineNumber = NumberOfLines then begin
                                PrintFooter:=true;
                            end;
                        end;
                    }
                }
                trigger OnPreDataItem() //CopyLoop
                begin
                    NoLoops:=1 + Abs(NoCopies);
                    if NoLoops <= 0 then NoLoops:=1;
                    CopyNo:=0;
                end;
                trigger OnAfterGetRecord() //CopyLoop
                begin
                    if CopyNo = NoLoops then begin
                        //if not CurrReport.Preview then
                        //SalesPrinted.Run("Sales Invoice Header");
                        CurrReport.Break();
                    end;
                    CopyNo:=CopyNo + 1;
                    if CopyNo = 1 then // Original
 Clear(CopyTxt)
                    else
                        CopyTxt:=Text000;
                end;
            }
            trigger OnAfterGetRecord() //Sales Invoice Header
            begin
                if PrintCompany then if RespCenter.Get("Responsibility Center")then begin
                        FormatAddress.RespCenter(CompAddr, RespCenter);
                    //CompInfo."Phone No." := RespCenter."Phone No.";
                    //CompInfo."Fax No." := RespCenter."Fax No.";
                    end;
                if "Salesperson Code" = '' then Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if "Payment Terms Code" = '' then Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                IF "Shipping Agent Code" = '' then clear(ShipAgent)
                else
                    ShipAgent.get("Shipping Agent Code");
                FormatAddress.SalesInvSellTo(SellToAddr, "Sales Invoice Header");
                Clear("Ship-to Contact");
                FormatAddress.SalesInvShipTo(ShipToAddr, ShipToAddr, "Sales Invoice Header");
                Clear("Bill-to Contact");
                FormatAddress.SalesInvBillTo(BillToAddr, "Sales Invoice Header");
                /*
                if not CurrReport.Preview then begin
                    if ArchiveDocument then
                        ArchiveManagement.StoreSalesDocument("Sales Invoice Header", LogInteraction);

                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Customer, "Sell-to Customer No.",
                          "Salesperson Code", '', "Posting Description", '');
                    end;
                end;
                */
                if "Posting Date" <> 0D then UseDate:="Posting Date"
                else
                    UseDate:=WorkDate();
                calcfields("Job No.");
                If "Job No." <> '' then If Job.get("Job No.")then begin
                        Job.calcfields("Completion Date");
                    end;
            end;
            trigger OnPreDataItem() //Sales Invoice Header
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
                            if not ArchiveDocument then LogInteraction:=false;
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
                            if LogInteraction then ArchiveDocument:=ArchiveDocumentEnable;
                        end;
                    }
                    field(HideQtyUOM; HideQtyUOM)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Quantity & UOM Columns';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit() //Request Page
        begin
            LogInteractionEnable:=true;
            ArchiveDocumentEnable:=true;
        end;
        trigger OnOpenPage() //Request Page
        begin
            ArchiveDocument:=ArchiveManagement.SalesDocArchiveGranule();
            LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Ord.") <> '';
            ArchiveDocumentEnable:=ArchiveDocument;
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    LblTitle='INVOICE';
    LblSIHNo='Invoice No.';
    LblDate='Invoice Date';
    LblPage='Page:';
    LblSellTo='Sell To';
    LblShipTo='Ship To';
    LblShipDate='Shipment Date';
    LblSalesPerson='Salesperson';
    LblSentVia='Sent Via';
    LblTerms='Terms';
    LblShipVia='Ship Via';
    LblFOB='FOB';
    LblOurItem='Our Item No.';
    LblYourItem='Your Item No.';
    LblDesc='Description';
    LblQty='Quantity';
    LblUOM='UOM';
    LblUnitPr='Unit Price';
    LblExtPr='Ext. Price';
    LblTotal='Invoice Total';
    LblShipAcctNo='Ship Via Acct. No.';
    LblLegal1='Acceptance of Brehob''s products or services shall be deemed to constitute an agreement on the part of the Buyer to the terms and conditions set forth';
    LblLegal2='on the reverse side of this document which supersedes all previous agreements. The terms and conditions stated herein shall take precedence';
    LblLegal3='over any other conditions and no contrary, additional or differnt conditions shall be binding on Brehob unless accepted by Brehob in writing.';
    LblFrtChrg='Freight Charge';
    LblTax='Sales Tax';
    LblCC='Brehob will charge a 3% surcharge for all invoices paid by credit card.';
    LblSubtotal='Subtotal';
    LblCustPO='Customer P.O. No.';
    LblEnteredBy='Entered By';
    LblCustNo='Customer No.';
    LblCustCode='Cust. Code';
    LblOrdNo='Order No.';
    LblJobNo='Project No.';
    LblCompDate='Compl. Date';
    LblBillTo='Bill To';
    LblFreightTotal='Freight Total';
    LblRemitTo='Remit to:';
    LblRemit1='P.O. Box 2023';
    LblRemit2='Indianapolis, IN 46206-2023';
    }
    trigger OnPreReport() //Report
    begin
        CompInfo.Get;
    end;
    var UnitPriceToPrint: Decimal;
    AmountExclInvDisc: Decimal;
    ShipmentMethod: Record "Shipment Method";
    ShipAgent: record "Shipping Agent";
    PaymentTerms: Record "Payment Terms";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    CompInfo: Record "Company Information";
    RespCenter: record "Responsibility Center";
    Res: record Resource;
    Job: record Job;
    CompAddr: array[9]of Text[100];
    BillToAddr: array[8]of Text[100];
    SellToAddr: array[8]of Text[100];
    ShipToAddr: array[8]of Text[100];
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
    FrtAmt: decimal;
    TaxAmount: decimal;
    Subtotal: decimal;
    HideQtyUOM: Boolean;
}

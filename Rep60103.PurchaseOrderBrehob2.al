report 60103 "Purchase Order Brehob 2"
{
    ApplicationArea = All;
    Caption = 'Purchase Order';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './Local/PurchaseOrderBH.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.";

            column(PHNo; "No.")
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
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PHExpRcptDt; "Purchase Header"."Expected Receipt Date")
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
                    column(ShipToAddr9; ShipToAddr[9])
                    {
                    }
                    column(PHBuyFromVendNo; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(PHYourRef; "Purchase Header"."Your Reference")
                    {
                    }
                    column(PurchPersName; SalesPurchPerson.Name)
                    {
                    }
                    column(PHNo1; "Purchase Header"."No.")
                    {
                    }
                    column(PHOrdDate; "Purchase Header"."Order Date")
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
                    column(PayTermsDesc; PaymentTerms.Description)
                    {
                    }
                    //column(CompInfoPhoneNo; CompInfo."Phone No.") { }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(EnteredBy; "Purchase Header"."Assigned User ID")
                    {
                    }
                    dataitem(PurchLine; "Purchase Line") //PurchLine
                    {
                        DataItemLink = "Document No."=FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")WHERE("Document Type"=CONST(Order));

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
                        DecimalPlaces = 2: 5;
                        }
                        column(OLDesc; Description)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        trigger OnPreDataItem() //PurchLine
                        begin
                            Clear(AmountExclInvDisc);
                            NumberOfLines:=Count;
                            OnLineNumber:=0;
                            PrintFooter:=false;
                        end;
                        trigger OnAfterGetRecord() //PurchLine
                        begin
                            OnLineNumber:=OnLineNumber + 1;
                            //if "Vendor Item No." <> '' then
                            //    ItemNumberToPrint := "Vendor Item No."
                            //else
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
                        if not CurrReport.Preview then PurchasePrinted.Run("Purchase Header");
                        CurrReport.Break();
                    end;
                    CopyNo:=CopyNo + 1;
                    if CopyNo = 1 then // Original
 Clear(CopyTxt)
                    else
                        CopyTxt:=Text000;
                end;
            }
            trigger OnAfterGetRecord() //Purchase Header
            begin
                if PrintCompany then if RespCenter.Get("Responsibility Center")then begin
                        FormatAddress.RespCenter(CompAddr, RespCenter);
                    //CompInfo."Phone No." := RespCenter."Phone No.";
                    //CompInfo."Fax No." := RespCenter."Fax No.";
                    end;
                if "Purchaser Code" = '' then Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Purchaser Code");
                if "Payment Terms Code" = '' then Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                IF "Shipping Agent Code" = '' then clear(ShipAgent)
                else
                    ShipAgent.get("Shipping Agent Code");
                FormatAddress.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddr, "Purchase Header");
                if not CurrReport.Preview then begin
                    if ArchiveDocument then ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);
                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                    end;
                end;
                if "Posting Date" <> 0D then UseDate:="Posting Date"
                else
                    UseDate:=WorkDate();
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
                        ToolTip = 'Specifies the number of copies of each blanket purchase order, in addition to the original, that you want to print.';
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
            ArchiveDocument:=ArchiveManagement.PurchaseDocArchiveGranule();
            LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Ord.") <> '';
            ArchiveDocumentEnable:=ArchiveDocument;
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    LblTitle='PURCHASE ORDER';
    LblPONo='Order No.';
    LblDate='Order Date';
    LblPage='Page:';
    LblBuyFrom='Buy From';
    LblShipTo='Ship To';
    LblShipDate='Req. Receipt Date';
    LblBuyer='Buyer';
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
    LblTotal='Total';
    LblShipAcctNo='Ship Via Acct. No.';
    LblLegal1='None of the terms, prices and conditions in this purchase order may be added to, modified';
    LblLegal2='or otherwise altered, except by written agreement between seller and buyer.';
    LblLegal3='Seller shall comply with the EEO clause in Section 202 of Executive Order 11246, as amended,';
    LblLegal4='41 CFR 60-250 and 41 CFR 60-741, as amended, which are incorporated.';
    LblEnteredBy='Entered By';
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
    CompAddr: array[9]of Text[100];
    BuyFromAddr: array[8]of Text[100];
    ShipToAddr: array[9]of Text[100];
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
    PurchasePrinted: Codeunit "Purch.Header-Printed";
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

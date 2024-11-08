codeunit 60100 Subscribers
{
    //to prevent posting if connected to job.  Posting occurs through jobs.
    [EventSubscriber(ObjectType::codeunit, codeunit::"Sales-Post", 'OnBeforePostCommitSalesDoc', '', true, true)]
    procedure OnBeforePostCommitSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; var ModifyHeader: Boolean; var CommitIsSuppressed: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    var
        Text001: TextConst ENU = 'Sales Order %1 requires a job, and as such, cannot be invoiced from here.';
    begin
        If(SalesHeader."Job Required") AND (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)then error(Text001, SalesHeader."No.");
    end;
    //to prevent prepayments if connected to a job.  Posting occurs through jobs.
    [EventSubscriber(ObjectType::codeunit, codeunit::"Sales-Post Prepayment (Yes/No)", 'OnBeforePostPrepmtDocument', '', true, true)]
    procedure OnBeforePostPrepmtDocument(var SalesHeader: Record "Sales Header"; PrepmtDocumentType: Option)
    var
        Text002: textconst ENU = 'Sales Order %1 requires a job, and as such, prepayment invoicing cannot be done from here.';
    begin
        If(SalesHeader."Job Required") AND (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)then error(Text002, SalesHeader."No.");
    end;
    //To add Resource Rental fields from Sales Line to Resource Journal Line
    //[EventSubscriber(ObjectType::codeunit, codeunit::"Sales-Post", 'OnPostResJnlLineOnAfterInit', '', true, true)]
    //procedure OnPostResJnlLineOnAfterInit(var ResJnlLine: Record "Res. Journal Line"; var SalesLine: Record "Sales Line")
    //begin
    //    ResJnlLine.Rental := SalesLine.Rental;
    //    ResJnlLine."On Rent" := SalesLine."On Rent";
    //    ResJnlLine."Rental Start Date" := SalesLine."Rental Start Date";
    //    ResJnlLine."Rental End Date" := SalesLine."Rental End Date";
    //    ResJnlLine."Rental Days" := SalesLine."Rental Days";
    //    IF ResJnlLine."On Rent" then
    //        ResJnlLine."Entry Type" := ResJnlLine."Entry Type"::Rent;
    //end;
    //To add Resource Rental fields from Sales Line to Resource Journal Line
    [EventSubscriber(ObjectType::table, database::"Res. Journal Line", 'OnAfterCopyResJnlLineFromSalesLine', '', true, true)]
    procedure OnAfterCopyResJnlLineFromSalesLine(var SalesLine: Record "Sales Line"; var ResJnlLine: Record "Res. Journal Line")
    begin
        ResJnlLine.Rental:=SalesLine.Rental;
        ResJnlLine."On Rent":=SalesLine."On Rent";
        ResJnlLine."Rental Start Date":=SalesLine."Rental Start Date";
        ResJnlLine."Rental End Date":=SalesLine."Rental End Date";
        //ResJnlLine."Rental Days" := SalesLine."Rental Days";
        IF ResJnlLine."On Rent" then ResJnlLine."Entry Type":=ResJnlLine."Entry Type"::Rent;
    end;
    //To move custom fields from Sales Line to Sales Invoice Line
    [EventSubscriber(ObjectType::codeunit, codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', true, true)]
    procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; PostingSalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
        SalesInvLine.Rental:=SalesLine.Rental;
        SalesInvLine."On Rent":=SalesLine."On Rent";
        SalesInvLine."Rental Start Date":=SalesLine."Rental Start Date";
        SalesInvLine."Rental End Date":=SalesLine."Rental End Date";
        SalesInvLine.Freight:=SalesLine.Freight;
    end;
    //To move custom fields from Sales Line to Sales Credit Memo Line
    [EventSubscriber(ObjectType::codeunit, codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', true, true)]
    procedure OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var PostingSalesLine: Record "Sales Line")
    begin
        SalesCrMemoLine.Rental:=SalesLine.Rental;
        SalesCrMemoLine."On Rent":=SalesLine."On Rent";
        SalesCrMemoLine."Rental Start Date":=SalesLine."Rental Start Date";
        SalesCrMemoLine."Rental End Date":=SalesLine."Rental End Date";
    //SalesLine.calcfields("Meter Serial No.");
    //SalesCrMemoLine."Meter Serial No." := SalesLine."Meter Serial No.";
    end;
    //To move custom fields from Sales Line to Sales Shipment Line
    [EventSubscriber(ObjectType::codeunit, codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', true, true)]
    procedure OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; ItemLedgShptEntryNo: Integer; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        SalesShptLine.Rental:=SalesLine.Rental;
        SalesShptLine."On Rent":=SalesLine."On Rent";
        SalesShptLine."Rental Start Date":=SalesLine."Rental Start Date";
        SalesShptLine."Rental End Date":=SalesLine."Rental End Date";
    //SalesLine.calcfields("Meter Serial No.");
    //SalesShptLine."Meter Serial No." := SalesLine."Meter Serial No.";
    end;
    //To post custom resource fields from resource journal to resouce ledger.
    [EventSubscriber(ObjectType::table, database::"Res. Ledger Entry", 'OnAfterCopyFromResJnlLine', '', true, true)]
    procedure OnAfterCopyFromResJnlLine(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    begin
        ResLedgerEntry."Entry Type":=ResJournalLine."Entry Type";
        ResLedgerEntry.Rental:=ResJournalLine.Rental;
        ResLedgerEntry."On Rent":=ResJournalLine."On Rent";
        ResLedgerEntry."Rental Start Date":=ResJournalLine."Rental Start Date";
        ResLedgerEntry."Rental End Date":=ResJournalLine."Rental End Date";
    //ResLedgerEntry."Rental Days" := ResJournalLine."Rental Days";
    end;
    //forced Handled to true so the rest of the function is skipped
    [EventSubscriber(ObjectType::table, database::"Job Planning Line", 'OnBeforeValidateModification', '', true, true)]
    procedure OnBeforeValidateModification(var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean; xJobPlanningLine: Record "Job Planning Line"; FieldNo: Integer)
    begin
        IsHandled:=true;
    end;
    //add rental fields to transfer
    [EventSubscriber(ObjectType::codeunit, codeunit::"Job Create-Invoice", 'OnCreateSalesLineOnBeforeValidateSalesLineNo', '', true, true)]
    procedure OnCreateSalesLineOnBeforeValidateSalesLineNo(var JobPlanningLine: Record "Job Planning Line"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        SalesLine.Rental:=JobPlanningLine.rental;
        //SalesLine."On Rent" := JobPlanningLine."On Rent";
        SalesLine."Rental Start Date":=JobPlanningLine."Rental Start Date";
        SalesLine."Rental End Date":=JobPlanningLine."Rental Start Date";
    //SalesLine."Rental Days" := JobPlanningLine."Rental Days";
    end;
    [EventSubscriber(ObjectType::codeunit, codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesLine', '', true, true)]
    procedure OnBeforeInsertSalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line"; JobInvCurrency: Boolean)
    begin
        SalesLine.Rental:=JobPlanningLine.Rental;
        SalesLine."Rental Start Date":=JobPlanningLine."Rental Start Date";
        SalesLine."Rental End Date":=JobPlanningLine."Rental Start Date";
        //SalesLine."Rental Days" := JobPlanningLine."Rental Days";
        SalesLine.Freight:=JobPlanningLine.Freight;
    end;
    //to add Ship-to Phone Number to purchase header after location validation
    [EventSubscriber(ObjectType::table, database::"Purchase Header", 'OnUpdateShipToAddressOnAfterCopyFromLocation', '', true, true)]
    procedure OnUpdateShipToAddressOnAfterCopyFromLocation(var PurchaseHeader: Record "Purchase Header"; Location: Record Location)
    begin
        PurchaseHeader."Ship-to Phone No.":=Location."Phone No.";
    end;
    //to add Ship-to Phone Number to purchase header after company validation
    [EventSubscriber(ObjectType::table, database::"Purchase Header", 'OnUpdateShipToAddressOnAfterCopyFromCompany', '', true, true)]
    procedure OnUpdateShipToAddressOnAfterCopyFromCompany(var PurchaseHeader: Record "Purchase Header"; CompanyInformation: Record "Company Information")
    begin
        PurchaseHeader."Ship-to Phone No.":=CompanyInformation."Phone No.";
    end;
    [EventSubscriber(ObjectType::table, database::Job, 'OnBeforeCheckBillToCustomerAssosEntriesExist', '', true, true)]
    local procedure OnBeforeCheckBillToCustomerAssosEntriesExist(var Job: Record Job; var xJob: Record Job; var IsHandled: Boolean)
    begin
        IsHandled:=true;
    end;
    [EventSubscriber(ObjectType::codeunit, codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesHeader', '', true, true)]
    procedure OnBeforeInsertSalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    begin
        Job.calcfields("Completion Date");
        SalesHeader."Completion Date":=Job."Completion Date";
        SalesHeader."Job No.":=Job."No.";
    end;
}

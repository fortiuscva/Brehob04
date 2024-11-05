report 60102 "Create Job"
{
    Caption = 'Create Job';
    ProcessingOnly = true;
    UseRequestPage = false;
    ShowPrintStatus = false;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST(Order));

            trigger OnAfterGetRecord()
            begin
                SalesHeader.testfield("Job Required", true);
                SalesHeader.CalcFields("Job No.");
                If SalesHeader."Job No." <> '' then error(Text002, SalesHeader."Job No.");
                SalesHeader.Testfield(Status, SalesHeader.Status::Released);
                SalesHeader.testfield("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.testfield("Location Code");
                JobSetup.get;
                clear(job);
                Job.Init;
                IF JobSetup."Default Job No." = JobSetup."Default Job No."::"Sales Order No." then Job.validate("No.", SalesHeader."No.")
                else
                    Job.validate("No.");
                Job.insert(true);
                Job.Description:=SalesHeader."Posting Description";
                Job.validate("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
                Job."Bill-to Name":=SalesHeader."Bill-to Name";
                Job."Bill-to Name 2":=SalesHeader."Bill-to Name 2";
                Job."Bill-to Address":=SalesHeader."Bill-to Address";
                Job."Bill-to Address 2":=SalesHeader."Bill-to Address 2";
                Job."Bill-to City":=SalesHeader."Bill-to City";
                Job."Bill-to County":=SalesHeader."Bill-to County";
                Job."Bill-to Contact":=SalesHeader."Bill-to Contact";
                Job."Bill-to Post Code":=SalesHeader."Bill-to Post Code";
                Job."Bill-to Country/Region Code":=SalesHeader."Bill-to Country/Region Code";
                Job."External Document No.":=SalesHeader."External Document No.";
                Job."Your Reference":=SalesHeader."Your Reference";
                Job.Status:=JobSetup."Default Job Status";
                Job."Job Posting Group":=JobSetup."Default Job Posting Group";
                Job.Validate("Ship-to Code", SalesHeader."Ship-to Code");
                Job."Creation Date":=SalesHeader."Order Date";
                Job."Starting Date":=SalesHeader."Document Date";
                Job."Payment Terms Code":=SalesHeader."Payment Terms Code";
                Job."Payment Method Code":=SalesHeader."Payment Method Code";
                //This line of code below is temporary until after release 24.x is installed.
                Job."Loc Code Temp":=SalesHeader."Location Code";
                SalesHeader.calcfields("Work Description");
                Job.validate("Work Description", SalesHeader."Work Description");
                Job.calcfields("Work Description");
                Job.modify;
                //Create Job Task, one task line only
                clear(JobTask);
                JobTask.init;
                JobTask."Job No.":=Job."No.";
                If JobSetup."Default Task No." <> '' then JobTask."Job Task No.":=JobSetup."Default Task No."
                else
                    JobTask."Job Task No.":=Job."No.";
                JobTask.Description:=Job.Description;
                JobTask."Job Task Type":=JobTask."Job Task Type"::Posting;
                JobTask.insert(true);
                //Create Job Planning Lines - one line per sales line
                SalesLine.reset;
                SalesLine.setrange("Document Type", SalesHeader."Document Type");
                SalesLine.setrange("Document No.", SalesHeader."No.");
                IF SalesLine.findset then begin
                    LineNo:=10000;
                    repeat JobPlanLine.Init;
                        JobPlanLine.validate("Job No.", Job."No.");
                        JobPlanLine.validate("Job Task No.", JobTask."Job No.");
                        JobPlanLine."Line No.":=LineNo;
                        JobPlanLine."Line Type":=JobPlanLine."Line Type"::Budget;
                        JobPlanLine."Planning Date":=Job."Creation Date";
                        JobPlanLine."Document No.":=SalesLine."Document No.";
                        //This line below is temporary until release 2.4.x is installed.
                        JobPlanLine.validate("Location Code", Job."Loc Code Temp");
                        If SalesLine.Type = SalesLine.Type::" " then JobPlanLine.Type:=JobPlanLine.Type::Text;
                        If SalesLine.Type = SalesLine.Type::"G/L Account" then JobPlanLine.Type:=JobPlanLine.Type::"G/L Account";
                        If SalesLine.Type = SalesLine.Type::Resource then JobPlanLine.Type:=JobPlanLine.Type::Resource;
                        If SalesLine.Type = SalesLine.Type::Item then JobPlanLine.Type:=JobPlanLine.Type::Item;
                        If SalesLine.Type = SalesLine.Type::"Fixed Asset" then exit;
                        If SalesLine.Type = SalesLine.Type::"Charge (Item)" then exit;
                        JobPlanLine.validate("No.", SalesLine."No.");
                        JobPlanLine.validate("Variant Code", SalesLine."Variant Code");
                        JobPlanLine.Description:=SalesLine.Description;
                        JobPlanLine."Description 2":=SalesLine."Description 2";
                        JobPlanLine.validate(Quantity, SalesLine.Quantity);
                        JobPlanLine.validate("Qty. to Transfer to Journal", JobPlanLine.Quantity);
                        JobPlanLine.validate("Unit Price", SalesLine."Unit Price");
                        JobPlanLine.Rental:=SalesLine.Rental;
                        JobPlanLine."Rental Start Date":=SalesLine."Rental Start Date";
                        JobPlanLine."Rental End Date":=SalesLine."Rental End Date";
                        //JobPlanLine."Rental Days" := SalesLine."Rental Days";
                        If JobPlanLine.Type = JobPlanLine.Type::Item then begin
                            If Item.get(JobPlanLine."No.")then If Item."Item Tracking Code" <> '' then If ItemTracking.get(Item."Item Tracking Code")then If ItemTracking."SN Specific Tracking" then JobPlanLine.Serialized:=true;
                        end;
                        JobPlanLine.insert;
                        LineNo+=10000;
                    until SalesLine.next = 0;
                end;
            end;
        }
    }
    var SalesLine: record "Sales Line";
    Job: record Job;
    JobTask: record "Job Task";
    JobPlanLine: record "Job Planning Line";
    JobSetup: record "Jobs Setup";
    Item: record Item;
    ItemTracking: record "Item Tracking Code";
    LineNo: Integer;
    Text001: TextConst ENU = 'Job %1 created.';
    Text002: TextConst ENU = 'Job %1 is already assigned to this sales order.';
    trigger OnPostReport()
    begin
        message(Text001, Job."No.");
    end;
}

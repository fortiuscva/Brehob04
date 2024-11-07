pageextension 60107 "Resource Card Ext" extends "Resource Card"
{
    layout
    {
        addlast(content)
        {
            group(Rentals)
            {
                field(Rental; rec.Rental)
                {
                    caption = 'Rental';
                    ToolTip = 'Specifies whether the Resource is a rental.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF(rec.Rental <> xrec.Rental) and (rec.Rental = FALSE)then begin
                            CheckIfOnRent();
                        end;
                    end;
                }
                field(RentOn; RentOn)
                {
                    caption = 'On Rent';
                    ToolTip = 'Specifies whether the Resource is currently on rent.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RentStart; RentStart)
                {
                    caption = 'Rental Start Date';
                    ToolTip = 'Specifies the Rental Start Date if the Resource is currently on rent.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RentEnd; RentEnd)
                {
                    caption = 'Rental End Date';
                    ToolTip = 'Specifies the Rental Start Date if the Resource is currently on rent.';
                    ApplicationArea = All;
                    Editable = false;
                }
                //field(RentDays; RentDays)
                //{
                //    caption = 'Rental Days';
                //    ToolTip = 'Specifies the number of days the resource is currently on rent.';
                //    ApplicationArea = All;
                //    Editable = false;
                //}
                field("Fixed Asset No."; rec."Fixed Asset No.")
                {
                    caption = 'Fixed Asset No.';
                    ToolTip = 'Specifies the Fixed Asset No. if the resource is a fixed asset.';
                    ApplicationArea = All;
                }
            }
        }
        addafter("Unit Price")
        {
            field(Freight; rec.Freight)
            {
                caption = 'Freight';
                ToolTip = 'Specifies if the resource represents freight on invoices.';
                ApplicationArea = All;
            }
        }
    }
    var ResLedgEntry: record "Res. Ledger Entry";
    OpenApprovalEntriesExist: Boolean;
    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    OpenApprovalEntriesExistCurrUser: Boolean;
    ShowWorkflowStatus: Boolean;
    RentOn: boolean;
    RentStart: date;
    RentEnd: date;
    RentDays: Integer;
    Text50000: TextConst ENU = 'Resource %1 is currently on rent.';
    protected var NewMode: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    trigger OnAfterGetRecord()
    begin
        RentOn:=false;
        RentStart:=0D;
        RentEnd:=0D;
        RentDays:=0;
        ResLedgEntry.reset;
        ResLedgEntry.SetCurrentKey("Entry No.", "Resource No.");
        ResLedgEntry.SetAscending("Entry No.", false);
        ResLedgEntry.setrange("Resource No.", rec."No.");
        ResLedgEntry.setrange(Rental, true);
        ResLedgEntry.setrange("Entry Type", ResLedgEntry."Entry Type"::Rent);
        If ResLedgEntry.Findfirst()then begin
            RentOn:=ResLedgEntry."On Rent";
            RentStart:=ResLedgEntry."Rental Start Date";
            RentEnd:=ResLedgEntry."Rental End Date";
            //RentDays := ResLedgEntry."Rental Days";
            CurrPage.Update();
        end;
    end;
    local procedure CheckIfOnRent()
    begin
        ResLedgEntry.reset;
        ResLedgEntry.SetCurrentKey("Entry No.", "Resource No.");
        ResLedgEntry.SetAscending("Entry No.", false);
        ResLedgEntry.setrange("Resource No.", rec."No.");
        ResLedgEntry.setrange(Rental, true);
        ResLedgEntry.setrange("Entry Type", ResLedgEntry."Entry Type"::Rent);
        If ResLedgEntry.Findfirst()then begin
            If ResLedgEntry."On Rent" then error(Text50000, rec."No.");
        end;
    end;
}

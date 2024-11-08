pageextension 60103 "Job Planning Lines Ext" extends "Job Planning Lines"
{
    layout
    {
        addafter(Description)
        {
            field(Serialzied; rec.Serialized)
            {
                caption = 'Serialized';
                Editable = false;
                ApplicationArea = all;
            }
            field(Rental; rec.Rental)
            {
                caption = 'Rental';
                Editable = false;
                ApplicationArea = all;
            }
            field(RentOn; RentOn)
            {
                caption = 'On Rent';
                Editable = false;
                ApplicationArea = all;
            }
            field("Rental Start Date"; rec."Rental Start Date")
            {
                caption = 'Rental Start Date';
                ApplicationArea = all;
            }
            field("Rental End Date"; rec."Rental End Date")
            {
                caption = 'Rental End Date';
                ApplicationArea = all;
            }
            field("Rental Days"; rec."Rental Days")
            {
                caption = 'Rental Days';
                Editable = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Reserve)
        {
            action("Select Nonstoc&k Items")
            {
                AccessByPermission = TableData "Nonstock Item"=R;
                ApplicationArea = All;
                Caption = 'Select Ca&talog Items';
                Image = NonStockItem;
                ToolTip = 'View the list of catalog items that exist in the system. ';

                trigger OnAction()
                begin
                    ShowNonstockItems();
                end;
            }
        }
    }
    var ResLedgEntry: record "Res. Ledger Entry";
    Text50000: TextConst ENU = 'Resource %1 is currently on rent.';
    RentOn: Boolean;
    trigger OnAfterGetRecord()
    begin
        RentOn:=false;
        IF rec.Type = rec.Type::Resource then begin
            ResLedgEntry.reset;
            ResLedgEntry.SetCurrentKey("Entry No.", "Resource No.");
            ResLedgEntry.SetAscending("Entry No.", false);
            ResLedgEntry.setrange("Resource No.", rec."No.");
            ResLedgEntry.setrange(Rental, true);
            ResLedgEntry.setrange("Entry Type", ResLedgEntry."Entry Type"::Rent);
            If ResLedgEntry.Findfirst()then begin
                RentOn:=ResLedgEntry."On Rent";
            end;
        //CurrPage.Update();
        end;
    end;
    trigger OnDeleteRecord(): Boolean var
        JPLInvoice: record "Job Planning Line Invoice";
    begin
        JPLInvoice.setrange("Job No.", rec."Job No.");
        JPLInvoice.setrange("Job Task No.", rec."Job Task No.");
        JPLInvoice.setrange("Line No.", rec."Line No.");
        JPLInvoice.deleteall;
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
            If ResLedgEntry."On Rent" then RentOn:=true;
        //message(Text50000, rec."No.");
        end;
    end;
    procedure ShowNonstockItems()
    begin
        rec.ShowNonstock();
    end;
}

tableextension 60103 "Job Planning Lines Ext" extends "Job Planning Line"
{
    fields
    {
        field(60100; Serialized; boolean)
        {
            Caption = 'Serialized';
            DataClassification = ToBeClassified;
        }
        field(60110; Rental; Boolean)
        {
            Editable = false;
            Caption = 'Rental';
            DataClassification = ToBeClassified;
        }
        field(60115; "Rental Start Date"; Date)
        {
            Caption = 'Rental Start Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                testfield(Rental, true);
                CalcRentDate;
            end;
        }
        field(60120; "Rental End Date"; Date)
        {
            Caption = 'Rental End Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                testfield(Rental, true);
                testfield("Rental Start Date");
                CalcRentDate;
            end;
        }
        //field(60125; "On Rent"; Boolean)
        //{
        //    Caption = 'On Rent';
        //    DataClassification = ToBeClassified;
        //}
        field(60130; "Rental Days"; Integer)
        {
            Caption = 'On Rent';
            DataClassification = ToBeClassified;
        }
        field(60160; Freight; Boolean)
        {
            caption = 'Freight';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("No.")
        {
        trigger OnAfterValidate()
        begin
            If Type = Type::Resource then If Res2.get("No.")then begin
                    Rental:=Res2.Rental;
                    Freight:=Res2.Freight;
                end;
        end;
        }
    }
    var Item: record Item;
    ItemTracking: record "Item Tracking Code";
    Res2: record Resource;
    Text001: TextConst ENU = 'Rental Start Date cannot be greater than Rental End Date.';
    SelectNonstockItemErr: Label 'You can only select a catalog item for an empty line.';
    CatalogItemMgt: Codeunit "Catalog Item Management 2";
    NonstockItem: Record "Nonstock Item";
    trigger OnModify()
    begin
        If Type = Type::Item then If Item.get("No.")then If Item."Item Tracking Code" <> '' then begin
                    If ItemTracking.get(Item."Item Tracking Code")then begin
                        If ItemTracking."SN Specific Tracking" then begin
                            Serialized:=true;
                        end;
                    end;
                end
                else
                    Serialized:=false;
    end;
    local procedure CalcRentDate()
    var
        StartDay: integer;
        EndDay: integer;
    begin
        IF "Rental End Date" <> 0D then begin
            IF "Rental Start Date" > "Rental End Date" then error(Text001);
            //IF ("Rental Start Date" <= today) AND ("Rental End Date" >= today) then
            //    "On Rent" := true;
            StartDay:=DATE2DMY("Rental Start Date", 1);
            EndDay:=DATE2DMY("Rental End Date", 1);
            "Rental Days":=EndDay - StartDay + 1;
        end;
    end;
    procedure ShowNonstock()
    var
        IsHandled: Boolean;
    begin
        IsHandled:=false;
        //OnBeforeShowNonStock(Rec, NonstockItem, IsHandled);
        if IsHandled then exit;
        TestField(Type, Type::Item);
        if "No." <> '' then Error(SelectNonstockItemErr);
        //OnShowNonstockOnBeforeOpenCatalogItemList(Rec, NonstockItem);
        if PAGE.RunModal(PAGE::"Catalog Item List", NonstockItem) = ACTION::LookupOK then begin
            CheckNonstockItemTemplate(NonstockItem);
            "No.":=NonstockItem."Entry No.";
            CatalogItemMgt.NonStockJobs(Rec);
            Validate("No.", "No.");
            UpdateUnitPriceFromNonstockItem();
        //OnAfterShowNonStock(Rec, NonstockItem);
        end;
    end;
    local procedure CheckNonstockItemTemplate(NonstockItem: Record "Nonstock Item")
    var
        ItemTempl: Record "Item Templ.";
    begin
        ItemTempl.Get(NonstockItem."Item Templ. Code");
        ItemTempl.TestField("Gen. Prod. Posting Group");
        ItemTempl.TestField("Inventory Posting Group");
    end;
    local procedure UpdateUnitPriceFromNonstockItem()
    var
        IsHandled: Boolean;
    begin
        IsHandled:=false;
        //OnBeforeUpdateUnitPriceFromNonstockItem(Rec, NonstockItem, IsHandled);
        if IsHandled then exit;
        Validate("Unit Price", NonstockItem."Unit Price");
    end;
}

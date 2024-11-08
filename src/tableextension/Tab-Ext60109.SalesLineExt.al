tableextension 60109 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
        trigger OnAfterValidate()
        begin
            If Type = Type::Resource then begin
                If Res.get("No.")then Begin
                    Rental:=Res.Rental;
                    Freight:=Res.Freight;
                end;
            end;
        END;
        }
        field(60110; Rental; Boolean)
        {
            caption = 'Rental';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60115; "Rental Start Date"; date)
        {
            caption = 'Rental Start Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                testfield(Rental);
            //CalcRentDate;
            end;
        }
        field(60120; "Rental End Date"; date)
        {
            caption = 'Rental End Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                testfield(Rental);
            //CalcRentDate;
            end;
        }
        field(60150; "On Rent"; boolean)
        {
            caption = 'On Rent';
            DataClassification = ToBeClassified;
        }
        field(60155; "Resource Type";Enum "Resource Type")
        {
            caption = 'Resource Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60160; Freight; Boolean)
        {
            caption = 'Freight';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    var Res: record Resource;
    Text50002: TextConst ENU = 'Rental Start Date cannot be greater than Rental End Date.';
/*
    local procedure CalcRentDate()
    var
        StartDay: integer;
        EndDay: integer;
    begin
        IF "Rental End Date" <> 0D then begin
            IF "Rental Start Date" > "Rental End Date" then
                error(Text50002);

            IF ("Rental Start Date" <= today) AND ("Rental End Date" >= today) then
                "On Rent" := true;

            StartDay := DATE2DMY("Rental Start Date", 1);
            EndDay := DATE2DMY("Rental End Date", 1);
            "Rental Days" := EndDay - StartDay + 1;

        end;
    end;
    */
}

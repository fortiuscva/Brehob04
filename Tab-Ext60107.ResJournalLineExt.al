tableextension 60107 "Res. Journal Line Ext" extends "Res. Journal Line"
{
    fields
    {
        field(50100; Rental; Boolean)
        {
            Editable = false;
            Caption = 'Rental';
            DataClassification = ToBeClassified;
        }
        field(50101; "Rental Start Date"; Date)
        {
            Caption = 'Rental Start Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                testfield(Rental, true);
            //CalcRentDate;
            end;
        }
        field(50102; "Rental End Date"; Date)
        {
            Caption = 'Rental End Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                testfield(Rental, true);
                testfield("Rental Start Date");
            //CalcRentDate;
            end;
        }
        field(50103; "On Rent"; Boolean)
        {
            Caption = 'On Rent';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                If("Entry Type" = "Entry Type"::Rent) AND (Rental = true) and ("On Rent" = false) and (Quantity = 0)then RemoveFromRent();
            end;
        }
        modify("Resource No.")
        {
        trigger OnAfterValidate()
        begin
            If Res2.get("Resource No.")then begin
                Rental:=Res2.Rental;
            end;
        end;
        }
    }
    var Res2: record Resource;
    Text001: TextConst ENU = 'Rental Start Date cannot be greater than Rental End Date.';
    /*
    local procedure CalcRentDate()
    var
        StartYear: integer;
        StartMonth: Integer;
        StartDay: integer;
        StartLastDay: DateFormula;
        EndYear: integer;
        EndMonth: integer;
        EndDay: integer;
        Days: Integer;
        Months: integer;
        RentDays: integer;
    begin
        IF "Rental End Date" <> 0D then begin
            IF "Rental Start Date" > "Rental End Date" then
                error(Text001);

            IF ("Rental Start Date" <= today) AND ("Rental End Date" >= today) then
                "On Rent" := true;

            StartDay := DATE2DMY("Rental Start Date", 1);
            EndDay := DATE2DMY("Rental End Date", 1);
            "Rental Days" := EndDay - StartDay + 1;

            //--------------------------------------------------

            StartYear := DATE2DMY("Rental Start Date", 3);
            StartMonth := DATE2DMY("Rental Start Date", 2);
            StartDay := DATE2DMY("Rental Start Date", 1);

            EndYear := DATE2DMY("Rental End Date", 3);
            EndMonth := DATE2DMY("Rental End Date", 2);
            EndDay := DATE2DMY("Rental End Date", 1);

StartLastDay := calcdate(<'CM'>;"Rental Start Date");

        end;
    end;
    local procedure calcRentDate()
    var
        RentDuration: decimal;
        RentDays: decimal;
    //StartDate: datetime;

    begin
        RentDuration := "Rental End Date" - "Rental Start Date";
        RentDuration := RentDuration / 1000;
        RentDays := ROUND((RentDuration / 86400), 1, '<');
        "Rental Day3" := RentDays;
        //RentDays := ROUND((RentDays / 86400), 1, '<');
        //"Rental Day2" := format(1 + ROUND((RentDays / 86400), 1, '<'));
        //"Rental Day2" := format(RentDays);

    end;
    */
    procedure RemoveFromRent()
    begin
        If("Entry Type" = "Entry Type"::Rent) and (Rental = true)then begin
            "On Rent":=false;
            "Rental Start Date":=0D;
            "Rental End Date":=0D;
            //"Rental Days" := 0;
            Description:='Remove From Rent';
        end;
    end;
}

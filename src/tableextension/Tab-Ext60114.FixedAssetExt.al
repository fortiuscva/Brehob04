tableextension 60114 "Fixed Asset Ext" extends "Fixed Asset"
{
    fields
    {
        field(60100; "Resource No."; code[20])
        {
            Caption = 'Resource No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Rental=const(true));

            trigger OnValidate()
            begin
                If "Resource No." = '' then Rental:=false
                else IF Res.get("Resource No.")then Rental:=Res.Rental;
            end;
        }
        field(60105; Rental; Boolean)
        {
            Caption = 'Rental';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    var ResLedgEntry: record "Res. Ledger Entry";
    Res: record Resource;
}
